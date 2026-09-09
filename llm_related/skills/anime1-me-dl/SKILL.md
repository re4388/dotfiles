---
name: anime1-me-dl
version: "1.0.0"
description: Download anime episodes from anime1.me / anime1.pw using the globally-installed anime1-cli (npm package anime1-cli). Use when the user wants to download an anime episode or series from anime1.me, search the catalogue, or resolve a video URL from that domain.
argument-hint: "<anime title or URL> [episode range] [output dir]"
allowed-tools: Bash
user-invocable: true
---

# /anime1-me-dl

Downloads anime from anime1.me / anime1.pw via the `anime1` CLI (`npm i -g anime1-cli`, Node 20+ only; no ffmpeg/yt-dlp/Python). Files land in `<--out dir>/<series-title>/<series> [NN].mp4`. If `anime1` is missing, install it with `npm install -g anime1-cli`.

## Two flows

**A. From an episode/category URL** (works for both anime1.me and anime1.pw):

```bash
# single episode
anime1 https://anime1.me/15651

# whole category/season, every episode, into a folder
anime1 "https://anime1.pw/?cat=60" --all --out /path/to/dir

# multiple URLs at once
anime1 https://anime1.me/15651 https://anime1.pw/349
```

**B. Browse/search the catalogue first** (anime1.me only — it publishes the whole catalogue as JSON; anime1.pw has no catalogue, use flow A):

```bash
# find the series and its [cat-id]
anime1 --search "<title keyword>" --list
# →  [874] 86－不存在的戰區－ — 1-23

# download every episode
anime1 --cat 874 --all --out /path/to/dir

# download with year/season filters
anime1 --year 2025 --season summer --search "frieren" --all
```

## Useful flags

| Flag | Effect |
|------|--------|
| `--all` | download all episodes without prompting (required for non-interactive use) |
| `--out <dir>` | output dir (default `./downloads`) |
| `--cat <id>` | jump straight to a category id, skip browsing |
| `--year` / `--season` | filter by spring\|summer\|autumn\|winter (or 春/夏/秋/冬) |
| `--search <text>` | filter series list by title |
| `--extract` | print resolved video URLs + cookies only, no download |
| `--list` | print catalogue and exit |
| `--connections <n>` | connections per file (default 6, max 8; CDN throttles ~1MB/s per connection) |
| `--concurrency <n>` | episodes in parallel (default 1, max 4) |
| `--min-interval <ms>` | min delay between requests (default 250) |
| `--user-agent <ua>` / `--cf-clearance <cookie>` | fix Cloudflare 403 — copy both from the user's browser |

## Rules

- Non-interactive: always pass `--all` (the interactive prompts need a TTY the agent doesn't have).
- Resolve the cat id via `--search <title> --list` instead of guessing URLs.
- Note the series name may include full-width dashes and specials (e.g. `11.5`); don't "fix" filenames.
- HLS `.m3u8` streams are handled automatically (segments fetched, AES-128 decrypted, stitched) — no ffmpeg needed.
- If Cloudflare 403s, ask the user for a browser User-Agent and `cf_clearance` cookie, then retry with `--user-agent` and `--cf-clearance`.
