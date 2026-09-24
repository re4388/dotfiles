---
name: anime1-me-dl
version: "1.0.0"
description: Download anime episodes from anime1.me / anime1.pw using the globally-installed anime1-cli (npm package anime1-cli). Use when the user wants to download an anime episode or series from anime1.me, search the catalogue, or resolve a video URL from that domain.
argument-hint: "<anime title or URL> [episode range] [output dir]"
allowed-tools: Bash
user-invocable: true
---

# /anime1-me-dl

Downloads anime from anime1.me / anime1.pw via the `anime1` CLI (`npm i -g anime1-cli`, Node 20+ only; the CLI itself needs no ffmpeg/yt-dlp/Python). Files land in `<--out dir>/<series-title>/<series> [NN].mp4`. If `anime1` is missing, install it with `npm install -g anime1-cli`. The mirror-site path below does use `ffmpeg` (only to remux HLS output to mp4).

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

## Other sites the CLI cannot parse (anime1.in, mmov.io)

`anime1-cli` only accepts anime1.me / anime1.pw. For other mirrors, extract the m3u8 yourself and download it with `scripts/hls-to-mp4.mjs` (parallel segments, retries, resume, optional `--mp4`).

```bash
# anime1.in: series page lists episodes as /<slug>-<8digits>; each episode page
# has <iframe src="/_player_x_/<id>">, and that player page has
# <source src="https://.../index.m3u8"> (AES-128, handled automatically).
PID=$(curl -sS -A "$UA" "<episode-url>" | rg -o '/_player_x_/[0-9]+' | head -1)
M3U8=$(curl -sS -A "$UA" "https://anime1.in$PID" | rg -o 'https://[^"]+\.m3u8' | head -1)
node scripts/hls-to-mp4.mjs "$M3U8" "$OUT/<title>/<title> [01]" --mp4

# mmov.io is behind Cloudflare → headless browsers get 403. Use headed real Chrome:
playwright-cli open --browser=chrome --headed "https://hk.mmov.io/vodplay/<id>/3-1.html"
# the m3u8 is in the page HTML as:  videoSrc = 'https://.../index.m3u8'
playwright-cli --raw eval "() => { const s=[...document.querySelectorAll('script')].map(x=>x.textContent).find(t=>t&&t.includes('videoSrc')); return s.match(/videoSrc = '([^']+)'/)?.[1]; }"
# source slug in the URL is the line: /3-<N>.html = 飛快雲, etc. Episode dir is 第01集..第NN集.
playwright-cli close
```

- Both sites: dead/round-robin CDN IPs make single segments fail; `hls-to-mp4.mjs` retries, and re-running resumes from cached parts. Wrap per-episode in a retry loop for a whole season.
- anime1.in marks dead episodes with the text `播放失效` (no player) — check before trying.
- If a mirror is dead, don't stop: try another source line on the same page (不同線路: `/3-`=飛快雲, `/8-`=高清, `/7-`=快車, `/5-`=櫻花, `/6-`=閃電, `/4-`=非凡, …), then another mirror entirely. (This run: anime1.in's S2 was all `播放失效` → mmov.io had it.)

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
- `✗ fetch failed` on every episode of a series (others fine): the CDN host has an AAAA record but the machine has no working IPv6, and Node's IPv6 auto-fallback times out at the 250ms default. Rerun with `NODE_OPTIONS='--network-family-autoselection-attempt-timeout=1000'`.
- Always verify the result, not just the "✓ saved"/exit 0: file count must match the episode count; `ffprobe -v error -show_entries format=duration -of default=nw=1 <file>` should be non-empty/sane; a raw `.ts` must start with sync byte `0x47` (`xxd -l 1 -p <file>`). A single stalled segment can leave a short, playable-looking file.
