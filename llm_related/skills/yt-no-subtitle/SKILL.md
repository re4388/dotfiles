---
name: yt-no-subtitle
description: Workflow for YouTube videos without subtitles. Downloads audio via yt-dlp, transcribes via local mlx-whisper (Apple Metal), and generates detailed summaries.
tags: [youtube, transcription, whisper, stt, 9router, audio, yt-dlp, mlx]
related_skills: [nine-router-stt, youtube-content]
version: 1.9.1
---

# YT No Subtitle (Whisper Fallback)

當 YouTube 影片沒有字幕/逐字稿時，自動執行音訊轉錄流程。
也可用於 **一般音訊檔案**（.m4a/.mp3/.wav）的直接轉錄 — 見步驟 6（跳過步驟 1-3）。

# Video Transcription & Download (Whisper Fallback)

當影片沒有字幕或需要從特定平台（YouTube, Bilibili）抓取內容時的標準流程。支援音訊轉錄與影片下載。

## 平台特定策略 (yt-dlp)

### YouTube — 字幕檢查 & 下載
- **先檢查字幕**：`yt-dlp --list-subs --cookies-from-browser firefox "URL"`
- **若有正體中文手動字幕 (zh-TW)**：優先下載 VTT，品質最高
  ```bash
  yt-dlp --cookies-from-browser firefox --write-subs --sub-langs zh-TW --skip-download -o "yt_sub_<id>" "URL"
  ```
- **若有自動字幕 (automatic captions)**：仍可用 `--write-auto-subs --sub-langs zh-Hant` 抓取
- **若完全無字幕**：下載音訊進行轉錄

**多軌字幕語言優先序**：`en-orig > zh-TW > zh-Hant > zh-Hans > en > zh-CN`（英文原音片通常有 `en-orig`；中文片為 `zh-TW`/`zh-Hant`）。

**批量抓字幕（canonical）**：
```bash
yt-dlp --cookies-from-browser firefox --skip-download \
  --write-subs --write-auto-subs \
  --sub-langs "zh-TW,zh-Hant,zh-Hans,zh-CN,en,en-orig" --convert-subs vtt \
  -a urls.txt -o "out/%(id)s.%(ext)s"
```

### VTT 字幕清洗（純文字轉換，含自動字幕去重）

YouTube 自動字幕是「滾動式」——同一句會在連續多個 cue 重複，且夾雜 `<c>` 逐字時間標籤。天真的逐行 join 會產生大量重複；用下面這支（auto 與手動字幕都適用）：

```python
import re

def clean_vtt(path):
    kept = []
    for ln in open(path, encoding="utf-8").read().split("\n"):
        s = ln.strip()
        if not s or "-->" in s:
            continue
        if s.startswith(("WEBVTT", "NOTE", "Kind:", "Language:", "X-TIMESTAMP")):
            continue
        s = re.sub(r"<[^>]*>", "", s).strip().replace("\u200b", "")  # 去 <c> 與逐字時間標籤
        if s:
            kept.append(s)
    cjk = any("\u4e00" <= c <= "\u9fff" for c in "".join(kept))
    out = []
    for s in kept:
        if not out:
            out.append(s); continue
        if cjk:
            if s == out[-1] or s in out[-1]:          # 滾動重複：整句或子句重複 → 跳過
                continue
        else:
            if s == out[-1] or out[-1].endswith(s):
                continue
        out.append(s)
    return ("".join(out) if cjk else " ".join(out)).strip()
```

邏輯：**每個 cue 取第一個非空行**，並跳過與前一行相同／被前一行包含的行。批次版見 `scripts/pipeline.py`。

### YouTube 音訊下載（無字幕時）
`yt-dlp -x --audio-format m4a -o "/path/to/%(id)s.%(ext)s" "URL"`
- **若報 403**：這是 SABR，別重試一般格式。改用 `-f 18 --no-check-certificate` 抓 mp4 再抽音訊。詳見下方「YouTube 下載 403 Forbidden（SABR）」。

### Bilibili (及受限平台)
- **必須帶 Cookies**：使用 `--cookies-from-browser chrome` (或其他瀏覽器) 繞過 412 錯誤與 480P 限制。
- **防止限速/斷線**：建議加 `--limit-rate 5M` 穩定連線。
- 指令：`yt-dlp --cookies-from-browser chrome -f "bestvideo+bestaudio/best" --limit-rate 5M -o "%(title)s.%(ext)s" "URL"`

## 轉錄流程 (mlx-whisper / Metal)

### 1. 判斷轉錄方式
- **9Router API**：截至 2026-06，quota 常態性耗盡，除非特別要求，否則優先使用本地轉錄。
- **本地 mlx-whisper（預設）**：Apple Silicon Metal GPU 加速。venv：`~/.venvs/whisper-bench`（已含 mlx-whisper + faster-whisper 1.2.1 作備援）。
  - **模型選擇（M2 Air 實測 748s 中文音檔）**：`base` 39s（19x real-time）；`small` ~86s（8.7x）且中文準確率明顯優於 base；faster-whisper CPU int8 base 236s（3.2x）。
  - **`medium`/`large-v3` 在此硬體慢於 real-time，不可用**（memory bandwidth bound）。
  - 預設用 **small**（中文錯字最少）；求快可降 `base`。2h 影片外推：CPU base ~38min、mlx base ~6min、mlx small ~14min。
- **路徑偏好**：若輸入檔案位於 workspace 外部（如 `~/Downloads/`），**輸出的 .txt 與 .md 應與原檔放置於同一目錄**，腳本則保留在 workspace 方便執行。

### 2. 執行指令
`execute_code` sandbox 無 mlx-whisper，須將腳本寫入檔案後透過 `terminal` 執行。

```python
# templates/transcribe_template.py
import mlx_whisper
text = mlx_whisper.transcribe("audio.m4a", path_or_hf_repo="mlx-community/whisper-small-mlx", language="zh")["text"]
with open("output.txt", "w") as f:
    f.write(text)
```

- venv 執行：`~/.venvs/whisper-bench/bin/python script.py`
- **背景執行**：`terminal("...script.py", background=True, notify_on_complete=True)`（長影片 >30 min 必用）
- 模型首次下載至 `~/.cache/huggingface`（HF 下載偏慢，已快取後勿重複下載）

## GitHub 自動化推送
所有轉錄完成後，應推送至 `re4388/audio_transcript_0`。
**資料夾規則**：repo 已改為「每個有新增檔案的 commit 一個資料夾」，資料夾命名為 `<YYYYMMDD>_<N>`（`YYYYMMDD` = commit 日期，`N` = 當天第幾個新增檔案的 commit，從 1 起算）。同一批轉錄的檔案全部放進當天最新的一個資料夾。
1. `git clone ... /tmp/repo`
2. 在 repo 內建立當天資料夾 `<YYYYMMDD>_<N>`（演算法見「### 7. GitHub 推送」）；**不要放到 repo 根目錄**
3. `cp -- <id>.txt <id>.md <YYYYMMDD_N>/`
4. `git add . && git commit -m "..." && git push`


- **無須 ffmpeg 切片** — 單檔 <~100MB 直接餵給 mlx-whisper 即可
- **background 模式**：若音訊 >30 分鐘（foreground timeout 600s 不足），用 `notify_on_complete=true`：

```bash
# 寫入腳本後執行
terminal("~/.venvs/whisper-bench/bin/python /path/to/script.py", background=True, notify_on_complete=true)
# 完成後自動通知，直接 read_file 看結果
```

- 注意：`notify_on_complete` 只通知完成，**不 capture stdout**。把結果寫到檔案後 read_file

**重要限制：`execute_code` sandbox 無 mlx-whisper。須寫 .py 到磁碟，用 `terminal()` 執行：**

```bash
# 1. write_file 寫入腳本
# 2. terminal("~/.venvs/whisper-bench/bin/python -u /path/to/script.py")
```

**批次處理（多影片）：**
mlx-whisper 走 Metal GPU，但仍循序執行即可（一支跑完再跑下一支）：
- 不要啟動多個 Python 進程同時跑 mlx-whisper（會搶 GPU memory 反而更慢）
- 每支 <30 min 可放心前景跑；mlx small 約 8.7x real-time，一支 2h 影片 ~14min

**Python API（建議）：**
```python
import mlx_whisper
text = mlx_whisper.transcribe("/path/to/audio.m4a", path_or_hf_repo="mlx-community/whisper-small-mlx", language="zh")["text"]
# omit language → auto-detect；指定 "zh"/"en" 提升準確率
with open("/path/to/yt_transcript_XXX.txt", "w") as f:
    f.write(text)
```

**faster-whisper 備援（僅在 mlx 不可用時）：**
```python
from faster_whisper import WhisperModel
model = WhisperModel("base", device="cpu", compute_type="int8")
segs, _ = model.transcribe("/path/to/audio.m4a", beam_size=5, language="zh")
text = " ".join(s.text for s in segs)
with open("/path/to/yt_transcript_XXX.txt", "w") as f:
    f.write(text)
```

**長影片（>30 min）背景轉錄模式：**
mlx `transcribe()` 是整檔一次跑完，無 per-segment 進度回呼。Foreground timeout 上限 600s，超過須用背景模式（mlx small 對 2h 影片約 14min，需背景）：
```python
# 背景執行，完成後自動通知；結果寫入檔案後 read_file 看結果
# terminal("~/.venvs/whisper-bench/bin/python script.py", background=True, notify_on_complete=True)
# 中途想看進度：process(action='poll') 看 %cpu；mlx 在 GPU 上跑時 %cpu 低是正常的
```

完整參考：`references/background-transcription.md`

**原版 Whisper CLI（最後手段，慢）：**
```bash
whisper /path/to/audio.m4a --language zh --model base --output_dir /path/to/output
```

### 7. GitHub 推送

產出兩個檔案，都推送到 `re4388/audio_transcript_0`。

**資料夾放置規則（必遵守，最常出錯的地方）**：

⚠️ **絕對不要把 `<id>.txt` / `<id>.md` 複製到 repo 根目錄**。repo 慣例是「每個有新增檔案的 commit 一個資料夾」，資料夾命名 `<YYYYMMDD>_<N>`：
- `YYYYMMDD` = commit 當天日期（= `date +%Y%m%d`）
- `N` = 當天第幾個新增檔案的 commit，從 1 起算（= 當天已存在的 `<YYYYMMDD>_*` 資料夾數 + 1）

同一批轉錄（同一次 push）的全部檔案，放進**同一個**日期資料夾，例如 `20261008_1/7typuNJDvRY.md`。

```bash
# 在 clone 下來的 repo 目錄內執行（不要 cd 去別處再 cp 回 root）
D=$(date +%Y%m%d)
N=$(ls -d "${D}"_* 2>/dev/null | wc -l | tr -d ' ')   # 當天已有幾個資料夾
FOLDER="${D}_$((N+1))"
mkdir -p "$FOLDER"
for f in *.txt *.md; do
  [ -f "$f" ] || continue
  [ "$f" = "README.md" ] && continue                  # 別把 README 搬進去
  cp -- "./$f" "$FOLDER/"                             # './' 讓 - 開頭檔名不被當成選項
done
git add -A && git commit -m "..." && git push
```

- 驗證時路徑要含資料夾：`gh api repos/re4388/audio_transcript_0/contents/<FOLDER>/<id>.md --jq .name`。
- 少數情況要「接續」已推過的同一批（追加檔案到既有資料夾），才手動 `cp -- ./<id>.* "<既有 FOLDER>/"`；否則每次新批次都建新資料夾。

**檔名規則**：
- YouTube 影片：使用 video ID（如 `CVx0DyJYP5k`）
- 一般音訊檔案：保留原檔名（如 `1150709_Serena_eng_transcript.txt`）
- 本地暫存：`yt_transcript_<video_id>.txt` / `.md`
- 推送到 GitHub 後：重命名為 `<video_id>.txt` / `<video_id>.md`（放進上述日期資料夾內）

**Repo 管理陷阱**：
- **Git Repo 損壞/不存在**：若 `/tmp` 下的 repo 因 session 重啟或系統清理而遺失 `.git` 目錄，`rm -rf` 常會被系統阻擋 (BLOCKED)。
- **解決方案**：不要執著於刪除，直接 clone 到一個新的臨時路徑（如 `audio_transcript_0_v3`），完成推送後放著即可。路徑名按版本遞增避免混淆。
  ```bash
  cd /tmp && git clone https://github.com/re4388/audio_transcript_0.git audio_transcript_0_vN
  ```

### 推送與批次陷阱
- **推送後務必驗證遠端**（別只看 `git commit` 訊息）：`git ls-remote https://github.com/re4388/audio_transcript_0.git HEAD`，或 `gh api repos/re4388/audio_transcript_0/contents/<folder>/<id>.md --jq .name` 抽查。曾經 `cp *.txt *.md` 靜默失敗，導致「nothing to commit」卻誤以為已推送。
- **檔名以 `-` 開頭**（如 `-_adjFzTuyc`）：`cp *.txt`、`ls` 會把它當成選項 → 用 `cp ./-file` 或逐檔迴圈。
- **批次下載可能靜默漏檔**：下載後比對 id 清單（`comm -23 want got`），缺的逐支重抓。

### 8. 批次處理 (Multiple Videos)

當使用者一次給予多個連結時：

1. **依序下載**：使用 loop `for vid in ...` 先完成所有音訊提取。
2. **循序轉錄**：**一次只跑一支影片**。避免 CPU 過載導致轉錄速度大幅下降或系統崩潰。
3. **命名隔離**：轉錄腳本與狀態檔名應包含 video ID（例如 `transcribe_<id>.py`, `status_<id>.txt`），避免後續清理或重試時產生混淆。
4. **統一提交**：所有影片轉錄完畢後，一次性 `git add . && git commit` 推送。

### 9. 摘要與回覆 (可選)

根據使用者需求產出結構化摘要。若使用者僅要求轉錄與上傳，則可略過詳細摘要。

- **核心論點**
- **關鍵事件時間軸**
- **關鍵洞察**
- **金句摘錄**
- **一句話總結**

同時在回覆中提供完整的處理摘要表格：影片ID、標題、時長、轉錄耗時、字數。

### 10. 加到個人 Apple Notes（每支影片必做，最終步驟）

每支影片處理完成後，除了推送 GitHub，**最後一步必須**為該支影片新增一則 Apple 筆記。

規則：**一支影片一則筆記**。

- **放置位置**：iCloud 帳號 → 資料夾「YT 稍後觀看」（不存在時腳本會自動建立）。
- **標題**：用 `<id>.md` 的第一行 `# <影片標題>`。Notes 會把內文第一行當筆記標題，所以不必另外設定標題。
- **字級**：內文 24px、段落標題 26px、文章大標 28px。
  - ⚠️ Notes 會把寫入的 HTML 字級縮成約 2/3，而且有 9px 下限。腳本會先乘 1.5 補回來，否則字會縮到 9px 變得超小。
- **去重**：同標題筆記已存在就跳過。要覆蓋更新時加 `--force`。

指令：

```bash
python3 ~/.agents/skills/yt-no-subtitle/scripts/md_to_apple_note.py <id>.md
# 覆蓋更新：
python3 ~/.agents/skills/yt-no-subtitle/scripts/md_to_apple_note.py <id>.md --force
```

- 腳本會自動完成：md → HTML、建立資料夾、比對標題去重、建立筆記。
- **批次多支時**：每支各跑一次。
- **若暫存已清理、本機已無 `<id>.md`**：先從 GitHub 取回，再跑腳本：
  ```bash
  P=$(gh api "repos/re4388/audio_transcript_0/git/trees/HEAD?recursive=1" \
        --jq ".tree[].path | select(endswith(\"/<id>.md\"))")
  gh api "repos/re4388/audio_transcript_0/contents/$P" --jq .content | tr -d '\n' | base64 -d > <id>.md
  ```

## 陷阱 / 已知問題

### 語言假設錯誤
- **不要預設語言是英文**。使用者給的音檔可能是中文、日文或其他語言。不確定時直接問使用者。
- mlx-whisper 支援 auto-detect（omit `language` 參數），但指定正確語言可大幅提升準確率。
- 若轉錄出來全是錯字或錯誤語言 → 立即用正確語言重跑，不要等使用者糾正。
- 中英夾雜的錄音：指定主要語言（如 `"zh"`）即可，仍會輸出英文部分。
- **反向警告**：英文影片務必用 `language="en"`。若把英文音訊硬指定 `zh`，會輸出整段亂碼 → 立刻改用正確語言重跑（實例：f1gkkzHZxNg、ITU1TpTwe8w）。
- 轉錄前可先 `ffprobe` 比對音訊時長；若逐字稿明顯偏短，切一段重轉確認，避免「內容只講到一半」被漏掉。

### 9Router Whisper Quota 耗盡
- 錯誤訊息：`[openai/whisper-1] You exceeded your current quota`
- 重置 timer 會倍增 (2s → 4s → 8s → 16s...)，不會在短時間內真正恢復
- 這是 9Router 後端 OpenAI API key 的額度完全吃光，session 內不用等
- **截至 2026-06 狀態：已確定 quota 耗盡，直接跳 mlx-whisper，不用再試**
- 解法：直接降級到本機 mlx-whisper（步驟 6），不要再 retry

### 暫存清理 (Cleanup)
- **直接刪除，不必問使用者**：`/tmp` 下的 `.m4a`、`.py` 等暫存檔，轉錄完成後直接 `rm -f` 清掉即可，無須先取得確認。
- **清理限制**：`rm` 指令在 `/Users/re4388/workspace` 或 `/tmp` 下執行時，若涉及多個檔案或特定路徑，偶爾會被 `BLOCKED`。
- **策略**：轉錄腳本末尾應包含 `os.remove(status_file)`。其餘暫存檔直接 `rm -f`；若清理失敗，告知並保持原樣，不必為了清理而反覆嘗試。

### YouTube 下載 403 Forbidden（SABR）
- **SABR 是什麼**：Server-side Adaptive Bitrate，YouTube 自研的串流協定，2025 起取代 DASH。它把音訊與影片包在單一 UMP 格式回應裡，並用播放時間（不是 byte range）索取片段，所以只有 YouTube 自家播放器吃得下。`web` client 現在常只吐 SABR-only 格式 → 用一般 https 格式抓就 403。
- **症狀**：`-x`／`bestaudio`／`-f 251` 等一般格式下載時報 `HTTP Error 403: Forbidden`（取字幕仍正常）。
- **實測可行解法（2026-10 驗證，10 支影片 3 支中招，一次成功）**：
  ```bash
  # 抓中低畫質漸進式 mp4（含音軌），再抽音訊
  yt-dlp --cookies-from-browser firefox --no-check-certificate -f 18 -o "audio/%(id)s.%(ext)s" "$URL"
  ffmpeg -y -i "audio/<id>.mp4" -vn -ac 1 -ar 16000 "audio/<id>.m4a"
  ```
  重點：`-f 18`（progressive 360p，https 直鏈，非 SABR）＋ `--no-check-certificate`。mlx-whisper 也可直接吃 `.mp4`。
- **不要浪費時間的方向**：`-x`、`bestaudio[ext=m4a]/bestaudio`、`player_client=tv,web_safari`（會回 "Requested format is not available"）、以及重試同一條一般格式。
- 若 `-f 18` 也失敗，再 `--list-formats` 挑 `https` 直鏈的 progressive 格式，或更新 yt-dlp（SABR 支援仍在演進）。

### 本機轉錄限制（實測結論，M2 Air / mlx-whisper 0.4.3 / faster-whisper 1.2.1）
- **mlx 甜蜜點 = base/small**。`medium`/`large-v3` 在此硬體 memory-bandwidth bound，慢於 real-time（12.5min 檔 medium 花 865s），勿用。
- 實測（748s 中文音檔）：faster-whisper CPU int8 base 236s；mlx base 39s；mlx small ~86s 且中文錯字明顯最少（如「居留權」base 全錯、small 全對）。
- 中文辨識偶有諧音錯誤（尤其英文夾雜處）。

### VAD filter 異常慢 segment（僅 faster-whisper 備援）
部分 segment 的 VAD 處理時間可達正常的 10x（如某 10-min segment 需 1967s vs 正常的~170s）。原因推測是該段大量 silence/稀疏語音導致 VAD 耗時暴增。監控時若發現某段卡住很久不必驚慌，給時間完成。**mlx-whisper 不受影響，建議直接用 mlx 取代。**

### background process 狀態不可靠
即使 `process(action='poll')` 顯示 output_lines=0，進程仍可能在正常跑（200% CPU）。用 status file 追蹤比依賴 process 輸出更可靠。

### 清理暫存
- `/tmp` 下的暫存檔（`.m4a`、`.py`）轉錄完成後直接刪除，不必問使用者
- 切片後的 segment 檔案 (`seg_*.m4a`) 轉錄完成後可清理

## 注意事項
- 轉錄完成後，在對話中呈現結構化摘要（含時長、字數、轉錄方式、儲存位置）
- .txt 與 .md 都推送至 GitHub repo `re4388/audio_transcript_0`，**且必須放進當天日期資料夾 `<YYYYMMDD>_<N>/`（不可散在 repo 根目錄）**
- 每支影片最終步驟：用 `scripts/md_to_apple_note.py` 為該支影片新增一則 Apple 筆記（一支一則，放 iCloud 資料夾「YT 稍後觀看」；詳見步驟 10）
- 清理暫存檔案（`.m4a`、`.py` 腳本）直接刪除即可，不必先取得使用者確認
- 原始音訊檔案 (.m4a/.mp3) 保留與否由使用者決定
