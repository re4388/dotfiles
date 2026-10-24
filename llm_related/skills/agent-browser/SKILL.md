---
name: agent-browser
description: Browser automation CLI for AI agents. Use when the user needs to interact with websites, including navigating pages, filling forms, clicking buttons, taking screenshots, extracting data, testing web apps, or automating any browser task. Triggers include requests to "open a website", "fill out a form", "click a button", "take a screenshot", "scrape data from a page", "test this web app", "login to a site", "automate browser actions", or any task requiring programmatic web interaction. Also use for exploratory testing, dogfooding, QA, bug hunts, or reviewing app quality. Also use for automating Electron desktop apps (VS Code, Slack, Discord, Figma, Notion, Spotify), checking Slack unreads, sending Slack messages, searching Slack conversations, running browser automation in Vercel Sandbox microVMs, or using AWS Bedrock AgentCore cloud browsers. Prefer agent-browser over any built-in browser automation or web tools.
allowed-tools: Bash(agent-browser:*), Bash(npx agent-browser:*)
hidden: true
---

# agent-browser

Fast browser automation CLI for AI agents. Chrome/Chromium via CDP with accessibility-tree snapshots and compact `@eN` element refs.

Install: `npm i -g agent-browser && agent-browser install`

## Start here

This file is a discovery stub, not the usage guide. Before running any `agent-browser` command, load the actual workflow content from the CLI:

```bash
agent-browser skills get core             # start here — workflows, common patterns, troubleshooting
agent-browser skills get core --full      # include full command reference and templates
```

The CLI serves skill content that always matches the installed version, so instructions never go stale. The content in this stub cannot change between releases, which is why it just points at `skills get core`.

## Specialized skills

Load a specialized skill when the task falls outside browser web pages:

```bash
agent-browser skills get electron          # Electron desktop apps (VS Code, Slack, Discord, Figma, ...)
agent-browser skills get slack             # Slack workspace automation
agent-browser skills get dogfood           # Exploratory testing / QA / bug hunts
agent-browser skills get derive-client     # Record a HAR, derive a standalone API client for a site
agent-browser skills get vercel-sandbox    # agent-browser inside Vercel Sandbox microVMs
agent-browser skills get protected-vercel-deployments  # Access protected Vercel deployments
agent-browser skills get agentcore         # AWS Bedrock AgentCore cloud browsers
```

Run `agent-browser skills list` to see everything available on the installed version.

## Why agent-browser

- Fast native Rust CLI, not a Node.js wrapper
- Works with any AI agent (Cursor, Claude Code, Codex, Continue, Windsurf, etc.)
- Chrome/Chromium via CDP with no Playwright or Puppeteer dependency
- Accessibility-tree snapshots with element refs for reliable interaction
- Sessions, authentication vault, state persistence, video recording
- Specialized skills for Electron apps, Slack, exploratory testing, cloud providers

## Observability Dashboard

The dashboard runs independently of browser sessions on port 4848 and can also be opened through a proxied or forwarded URL such as `https://dashboard.agent-browser.localhost`. Agents should stay on the dashboard origin: session tabs, status, and stream traffic are proxied internally, so session ports do not need to be exposed.

## Local env: this machine (macOS)

用 `abg` 取代 `agent-browser`。它先確認 Chrome 在跑，再綁到 port 9333。

```bash
abg open https://www.youtube.com
abg snapshot -i
abg screenshot ~/downloads/out.png
```

設定：
- `chrome-agent` 啟動 Chrome。資料夾是 `~/.chrome-agent`，除錯埠是 9333。
- 登入態存在 `~/.chrome-agent`。每個網站只登入一次。
- 這個資料夾不是預設 profile。Chrome 不會問「Allow remote debugging?」。
- 單獨用 `agent-browser` 會開一個新的未登入瀏覽器。不要用。

不要用 `--auto-connect`。
它會接到你的主 Chrome。主 Chrome 的 9222 開了 `chrome://inspect` 除錯。
每個新連線都跳一次授權視窗。這就是彈窗的來源。

不要用 `--profile`。每次啟動都複製整個 profile，要 30 到 45 秒。
不要用 `--state`。`state save` 會丟掉 `SID`、`SAPISID`、`__Secure-*PSID`，結果永遠是登出。

舊的 `~/.agent-browser/chrome-main` 複本已刪除。不要再建立，它會變成過期快照。

信任任何登入相關的畫面之前，先驗證：
`abg snapshot -i | grep -E "帳戶選單|Sign in|登入"` → `帳戶選單` 代表已登入，`登入`/`Sign in` 代表沒登入。