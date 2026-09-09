---
name: yt-no-subtitle
description: Workflow for YouTube videos without subtitles. Downloads audio via yt-dlp, transcribes via local mlx-whisper (Apple Metal), and generates detailed summaries.
tags: [youtube, transcription, whisper, stt, 9router, audio, yt-dlp, mlx]
related_skills: [nine-router-stt, youtube-content]
version: 1.5.0
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

### VTT 字幕清洗 (純文字轉換)
```python
# 將 VTT 轉成無時間戳的連續純文字
lines = open("file.vtt").read().split('\\n')
text = ' '.join(
    line.strip() for line in lines
    if line.strip() and '-->' not in line
    and not line.startswith(('WEBVTT', 'NOTE', 'Kind:', 'Language:'))
    and not line.isdigit()
)
clean = ''.join(text.split())  # Chinese 去空白
```

### YouTube 音訊下載（無字幕時）
`yt-dlp -x --audio-format m4a -o "/path/to/%(id)s.%(ext)s" "URL"`

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
1. `git clone ... /tmp/repo`
2. `cp transcript.txt /tmp/repo/`
3. `git add . && git commit -m "..." && git push`


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

產出兩個檔案，都推送到 `re4388/audio_transcript_0`：

**檔名規則**：
- YouTube 影片：使用 video ID（如 `CVx0DyJYP5k`）
- 一般音訊檔案：保留原檔名（如 `1150709_Serena_eng_transcript.txt`）
- 本地暫存：`yt_transcript_<video_id>.txt` / `.md`
- 推送到 GitHub 後：重命名為 `<video_id>.txt` / `<video_id>.md`

**Repo 管理陷阱**：
- **Git Repo 損壞/不存在**：若 `/tmp` 下的 repo 因 session 重啟或系統清理而遺失 `.git` 目錄，`rm -rf` 常會被系統阻擋 (BLOCKED)。
- **解決方案**：不要執著於刪除，直接 clone 到一個新的臨時路徑（如 `audio_transcript_0_v3`），完成推送後放著即可。路徑名按版本遞增避免混淆。
  ```bash
  cd /tmp && git clone https://github.com/re4388/audio_transcript_0.git audio_transcript_0_vN
  ```

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

## 陷阱 / 已知問題

### 語言假設錯誤
- **不要預設語言是英文**。使用者給的音檔可能是中文、日文或其他語言。不確定時直接問使用者。
- mlx-whisper 支援 auto-detect（omit `language` 參數），但指定正確語言可大幅提升準確率。
- 若轉錄出來全是錯字或錯誤語言 → 立即用正確語言重跑，不要等使用者糾正。
- 中英夾雜的錄音：指定主要語言（如 `"zh"`）即可，仍會輸出英文部分。

### 9Router Whisper Quota 耗盡
- 錯誤訊息：`[openai/whisper-1] You exceeded your current quota`
- 重置 timer 會倍增 (2s → 4s → 8s → 16s...)，不會在短時間內真正恢復
- 這是 9Router 後端 OpenAI API key 的額度完全吃光，session 內不用等
- **截至 2026-06 狀態：已確定 quota 耗盡，直接跳 mlx-whisper，不用再試**
- 解法：直接降級到本機 mlx-whisper（步驟 6），不要再 retry

### 暫存清理 (Cleanup)
- **清理限制**：`rm` 指令在 `/Users/re4388/workspace` 或 `/tmp` 下執行時，若涉及多個檔案或特定路徑，常會被 `BLOCKED`。
- **策略**：轉錄腳本末尾應包含 `os.remove(status_file)`。其餘 `.m4a` 或 `.py` 檔案若清理失敗，可向使用者告知並保持原樣，不必為了清理而反覆嘗試。

### YouTube 下載 403 Forbidden
- **症狀**：`yt-dlp -f 18` 下載時報 `HTTP Error 403: Forbidden`
- **原因**：YouTube SABR-only streaming experiment 或 SSL 驗證問題
- **解法**：加 `--no-check-certificate` 參數
  ```bash
  yt-dlp --cookies-from-browser firefox -f 18 --no-check-certificate -o "output.%(ext)s" "URL"
  ```
- 若仍失敗，嘗試 `--list-formats` 確認可用格式，或改用 `bestaudio[ext=m4a]/bestaudio`

### 本機轉錄限制（實測結論，M2 Air / mlx-whisper 0.4.3 / faster-whisper 1.2.1）
- **mlx 甜蜜點 = base/small**。`medium`/`large-v3` 在此硬體 memory-bandwidth bound，慢於 real-time（12.5min 檔 medium 花 865s），勿用。
- 實測（748s 中文音檔）：faster-whisper CPU int8 base 236s；mlx base 39s；mlx small ~86s 且中文錯字明顯最少（如「居留權」base 全錯、small 全對）。
- 中文辨識偶有諧音錯誤（尤其英文夾雜處）。

### VAD filter 異常慢 segment（僅 faster-whisper 備援）
部分 segment 的 VAD 處理時間可達正常的 10x（如某 10-min segment 需 1967s vs 正常的~170s）。原因推測是該段大量 silence/稀疏語音導致 VAD 耗時暴增。監控時若發現某段卡住很久不必驚慌，給時間完成。**mlx-whisper 不受影響，建議直接用 mlx 取代。**

### background process 狀態不可靠
即使 `process(action='poll')` 顯示 output_lines=0，進程仍可能在正常跑（200% CPU）。用 status file 追蹤比依賴 process 輸出更可靠。

### 清理暫存
- `.m4a` 音訊檔案可視需求保留或刪除
- 切片後的 segment 檔案 (`seg_*.m4a`) 轉錄完成後可清理

## 注意事項
- 轉錄完成後，在對話中呈現結構化摘要（含時長、字數、轉錄方式、儲存位置）
- .txt 與 .md 都推送至 GitHub repo `re4388/audio_transcript_0`
- 清理暫存檔案（`.m4a`、`.py` 腳本）須先取得使用者確認，因 `terminal()` 清理可能被系統阻擋
- 原始音訊檔案 (.m4a/.mp3) 保留與否由使用者決定
