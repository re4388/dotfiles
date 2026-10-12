#!/usr/bin/env python3
"""yt-no-subtitle pipeline (subs-first, Whisper fallback).

Usage:
  # 1) 抓字幕 + 清洗（輸出 <workdir>/txt/<id>.txt，並列出缺字幕的 id）
  python pipeline.py urls.txt --workdir /tmp/ytpipe

  # 2) 對缺字幕的 id 下載音訊並用 mlx-whisper 轉錄（須用 whisper venv 執行）
  ~/.venvs/whisper-bench/bin/python pipeline.py urls.txt --workdir /tmp/ytpipe --whisper --lang zh

urls.txt: 每行一個 YouTube 影片 ID 或完整 URL。
輸出逐字稿一律在 <workdir>/txt/<id>.txt（字幕清洗或 Whisper 皆同）。
之後再由 agent 產出 <id>.md 摘要、推送 GitHub、附加到個人筆記。
"""
import argparse
import collections
import glob
import os
import re
import subprocess

SUBS_DIRNAME = "subs"
AUDIO_DIRNAME = "audio"
TXT_DIRNAME = "txt"
LANGS = "zh-TW,zh-Hant,zh-Hans,zh-CN,en,en-orig"
# 多軌字幕語言優先序
PRIORITY = ["en-orig", "zh-TW", "zh-Hant", "zh-Hans", "en", "zh-CN"]


def vid_of(line):
    line = line.strip()
    if not line:
        return ""
    m = re.search(r"(?:v=|youtu\.be/|/shorts/|/embed/)([A-Za-z0-9_-]{11})", line)
    if m:
        return m.group(1)
    return line if re.fullmatch(r"[A-Za-z0-9_-]{11}", line) else line


def read_ids(path):
    return [v for v in (vid_of(l) for l in open(path, encoding="utf-8")) if v]


def run(cmd):
    subprocess.run(cmd, check=False)


def download_subs(urls_file, subs_dir):
    os.makedirs(subs_dir, exist_ok=True)
    run(["yt-dlp", "--cookies-from-browser", "firefox", "--skip-download",
         "--write-subs", "--write-auto-subs", "--sub-langs", LANGS,
         "--convert-subs", "vtt", "-a", urls_file,
         "-o", os.path.join(subs_dir, "%(id)s.%(ext)s")])


def clean_vtt(text):
    kept = []
    for ln in text.split("\n"):
        s = ln.strip()
        if not s or "-->" in s:
            continue
        if s.startswith(("WEBVTT", "NOTE", "Kind:", "Language:", "X-TIMESTAMP")):
            continue
        s = re.sub(r"<[^>]*>", "", s).strip().replace("\u200b", "")
        if s:
            kept.append(s)
    cjk = any("\u4e00" <= c <= "\u9fff" for c in "".join(kept))
    out = []
    for s in kept:
        if not out:
            out.append(s)
            continue
        if cjk:
            if s == out[-1] or s in out[-1]:
                continue
        else:
            if s == out[-1] or out[-1].endswith(s):
                continue
        out.append(s)
    return ("".join(out) if cjk else " ".join(out)).strip()


def clean_all(subs_dir, txt_dir):
    groups = collections.defaultdict(dict)
    for p in glob.glob(os.path.join(subs_dir, "*.vtt")):
        vid, _, lang = os.path.basename(p)[:-4].partition(".")
        groups[vid][lang] = p
    os.makedirs(txt_dir, exist_ok=True)
    for vid, langs in groups.items():
        chosen = next((p for p in PRIORITY if p in langs), sorted(langs)[0])
        text = clean_vtt(open(langs[chosen], encoding="utf-8").read())
        open(os.path.join(txt_dir, vid + ".txt"), "w", encoding="utf-8").write(text)
        print(f"{vid} <- {chosen} ({len(text)} chars)")
    return set(groups)


def download_audio(urls_file, audio_dir):
    os.makedirs(audio_dir, exist_ok=True)
    run(["yt-dlp", "--cookies-from-browser", "firefox", "-x", "--audio-format", "m4a",
         "-a", urls_file, "-o", os.path.join(audio_dir, "%(id)s.%(ext)s")])


def transcribe_missing(ids, audio_dir, txt_dir, lang):
    import mlx_whisper  # 需在 venv 執行：~/.venvs/whisper-bench/bin/python
    for vid in ids:
        dst = os.path.join(txt_dir, vid + ".txt")
        if os.path.exists(dst) and os.path.getsize(dst) > 0:
            continue
        src = os.path.join(audio_dir, vid + ".m4a")
        if not os.path.exists(src):
            print(f"MISSING AUDIO {vid}")
            continue
        text = mlx_whisper.transcribe(
            src, path_or_hf_repo="mlx-community/whisper-small-mlx", language=lang
        )["text"]
        open(dst, "w", encoding="utf-8").write(text)
        print(f"{vid} <- whisper/{lang} ({len(text)} chars)")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("urls_file")
    ap.add_argument("--workdir", default="/tmp/ytpipe")
    ap.add_argument("--whisper", action="store_true", help="對缺字幕者下載音訊並轉錄")
    ap.add_argument("--lang", default="zh", help="Whisper 語言（中文 zh、英文 en）")
    args = ap.parse_args()

    ids = read_ids(args.urls_file)
    subs_dir = os.path.join(args.workdir, SUBS_DIRNAME)
    txt_dir = os.path.join(args.workdir, TXT_DIRNAME)
    audio_dir = os.path.join(args.workdir, AUDIO_DIRNAME)

    download_subs(args.urls_file, subs_dir)
    subbed = clean_all(subs_dir, txt_dir)
    missing = [v for v in ids if v not in subbed]
    print(f"\nsubbed={len(subbed)} missing={len(missing)}: {missing}")

    if args.whisper and missing:
        download_audio(args.urls_file, audio_dir)
        transcribe_missing(missing, audio_dir, txt_dir, args.lang)


if __name__ == "__main__":
    main()
