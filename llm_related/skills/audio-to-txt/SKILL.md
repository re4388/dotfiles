---
name: audio-to-txt
description: Convert a local audio/video file (user-provided path) into transcript files (.txt/.md) plus a structured content summary (_摘要.md) via local mlx-whisper, then push to the GitHub repo. Use when the user hands you an audio or video file path (.m4a/.mp3/.wav/.aac/.flac/.ogg/.mp4/.mov) and wants a transcript. Do not use for YouTube/other URLs — that is yt-no-subtitle's job.
tags: [transcription, whisper, mlx, stt, audio, summary, github]
related_skills: [yt-no-subtitle]
version: 1.0.0
---

# Audio-to-Text Transcript & Summary

將本機音訊/影片檔案轉成逐字稿(.txt + .md)並自動產生內容摘要(_摘要.md),然後推到 GitHub repo `re4388/audio_transcript_0`。

**範圍**:只處理本機檔案路徑。若使用者給的是 YouTube / Bilibili / 其他 URL → 改走 `yt-no-subtitle` skill。

## 處理流程

### 1. 取得檔案
- 向使用者確認**單一檔案路徑**。
- 支援格式：`.m4a .mp3 .wav .aac .flac .ogg .mp4 .mov`。
- 若是 `.mp4/.mov`(含影像)：先用 ffmpeg 抽出音軌再轉錄：
  ```bash
  ffmpeg -i "input.mp4" -vn -ac 1 -ar 16000 "/tmp/<basename>_extract.m4a"
  ```
  (輸出檔名仍用原 basename，抽出的音軌屬暫存檔)
- 檔案不存在或路徑不明 → 停下問清楚，不要猜。

### 2. 問語言(起手必問一次)
`這檔案主要語言? zh/en/ja/auto(預設 zh)`
- 指定正確語言大幅提升準確率；不確定用 auto。
- 轉完若整篇錯字或錯語言 → 立即換正確語言重跑，不等使用者糾正。

### 3. 轉錄(mlx-whisper / Metal)
- 環境：`~/.venvs/whisper-bench/bin/python`(內含 mlx-whisper；faster-whisper 1.2.1 作備援)。
- **模型預設 small**(中文錯字最少)，求快可降 base。
- 實測(M2 Air)：mlx small ~8.7x real-time；`medium`/`large-v3` 在此硬體慢於 real-time，**勿用**。

```python
# transcribe.py
import mlx_whisper
text = mlx_whisper.transcribe(
    "/path/to/audio.m4a",
    path_or_hf_repo="mlx-community/whisper-small-mlx",
    language="zh",  # 依步驟 2
)["text"]
with open("/path/to/output.txt", "w") as f:
    f.write(text)
```

執行：
```bash
~/.venvs/whisper-bench/bin/python transcribe.py
```
- 模型已快取於 `~/.cache/huggingface`，勿重複下載。
- **>30 分鐘長檔**：foreground timeout 上限 600s，超過須背景執行
  `terminal("...python script.py", background=True, notify_on_complete=True)`，
  完成後 read_file 看結果。mlx 是整檔一次跑完，無 per-segment 進度；跑在 GPU 上時 %cpu 低是正常的。
- 無須 ffmpeg 切片，單檔直接餵即可。

**faster-whisper 備援(僅 mlx 不可用時)：**
```python
from faster_whisper import WhisperModel
model = WhisperModel("base", device="cpu", compute_type="int8")
segs, _ = model.transcribe("audio.m4a", beam_size=5, language="zh")
text = " ".join(s.text for s in segs)
```
注意：CPU int8 慢很多(~3.2x real-time)，且 VAD filter 某些 segment 可異常慢 10x，勿開。

### 4. 產出檔案(同目錄、同 basename)
原檔位於 `~/Downloads/foo.m4a` → 輸出 `~/Downloads/foo.txt`、`~/Downloads/foo.md`、`~/Downloads/foo_摘要.md`。

**`<basename>.txt`** — 純逐字稿，無時間戳、無 header：
```
<逐字稿純文字>
```

**`<basename>.md`** — header + 逐字稿 + footer(注意：**不寫入完整本機路徑**，只有檔名)：
```markdown
# <basename> 轉錄稿

> 轉錄日期：<YYYY-MM-DD>
> 轉錄模型：mlx-whisper (small, <lang>)

---

<逐字稿>

---

*轉錄自 <basename>*
```

**`<basename>_摘要.md`** — 每次自動產生的結構化摘要：
```markdown
# <basename> 內容摘要

> 轉錄日期：<YYYY-MM-DD>
> 來源：<basename>
> 摘要模型：<current LLM>

---

## 一句話總結
<一句話>

## 核心論點
- <論點 1>
- <論點 2>

## 時間軸 / 討論脈絡
- <時間或段落 1>：<重點>
- <時間或段落 2>：<重點>
(訪談/演講用時間軸；純閒聊/會議用「討論脈絡」列段落重點)

## 關鍵洞察
- <洞察>

## 金句摘錄
> 「<原句>」
```
- 摘要由 agent 依逐字稿內容產出，不需使用者再要求。
- 摘要品質取決於轉錄品質；逐字稿若明顯殘缺，摘要照實反映。

### 5. GitHub 推送(一律自動)
三檔(`.txt`、`.md`、`_摘要.md`)都推到 `https://github.com/re4388/audio_transcript_0.git`。

- 檔名規則：保留原 basename(中文/空格檔名直接沿用，repo 已有中文檔名前例)。
- 同名已存在 → **直接覆蓋**。
- commit message：`<basename> 轉錄稿+摘要 <YYYY-MM-DD>`
- Repo 管理陷阱：session 重啟或系統清理常讓 `/tmp` 下的 clone 遺失 `.git`，`rm -rf` 又常被系統擋。
  不要執著刪除，直接 clone 到新路徑（`/tmp/audio_transcript_0_vN`，版本遞增）。

### 6. 回覆
給結構化摘要表：檔名、時長、字數、轉錄耗時、模型、輸出位置、是否有 push。原始音檔永不刪除、保留原地。

## 陷阱 / 已知問題

### 語言假設錯誤
- 不要預設語言是英文。使用者給的可能是中文/日文/英文/中英夾雜。
- 中英夾雜：指定主要語言(如 zh)即可，仍會輸出英文部分。
- 整篇錯字或錯語言 → 立即換語言重跑，不要等使用者糾正。

### 純音樂 / 無人聲內容
- 音樂檔(人聲很少或無)會產出大量無意義文字。轉錄前若檔名/副檔名看起來像音樂(如單曲下載)，先提醒使用者「這可能是音樂，逐字稿會很糟」，確認仍要轉再轉。

### 多人對話品質上限
- 本流程**無 speaker diarization**。多人同時講話、遠場會議錄音品質會明顯變差。轉錄前提示使用者，讓其降低期待；若使用者明確要求分 speaker，告知此 skill 不支援。

### 本機轉錄限制
- mlx 甜蜜點 = base/small。medium/large-v3 在此硬體 memory-bandwidth bound，慢於 real-time，勿用。
- 長檔(>30 min)務必背景執行；不要同時開多個 mlx 進程(搶 GPU memory 更慢)，循序跑。

### 暫存清理
- `.py` 腳本、ffmpeg 抽出的 `_extract.m4a` 等暫存檔：**先取得使用者確認再刪**，`rm` 常被系統擋，清理失敗就告知使用者並保持原樣。
- 原始音檔是使用者資產，永不主動刪除。

### 輸入不是本機檔案
- 使用者給 URL(YouTube/Bilibili/一般連結)→ 明確轉介 `yt-no-subtitle` skill，不要自己用 yt-dlp 或猜。
