---
name: yt-watch-later-to-md
description: Export a YouTube Watch Later playlist (or any YouTube playlist) to a Markdown file containing each video's title and link, using playwright-cli attached to a logged-in Chrome. Optionally categorize all videos by title into themed sections. Use when the user says "export watch later", "get YT watch later list", "把稍後觀看清單存成 md", "整理 YT 播放清單", or wants a playlist dumped to Markdown.
tags: [youtube, playlist, watch-later, playwright, playwright-cli, markdown, export, categorize]
related_skills: [playwright-cli]
version: 1.0.0
---

# YT Watch Later → Markdown

把 YouTube「稍後觀看」(Watch Later) 或其他播放清單，匯出成 Markdown（標題 + 連結），可依主題分類。

> 核心教訓：**playwright-cli 本身不會卡，卡在 YouTube 的虛擬滾動清單。** 純 CLI 指令（`snapshot`）一次只渲染約 100 筆，抓不完長清單，必須用 `run-code` 跑自訂 JS 滾動 + DOM 抽取。本 skill 把該流程固化。

## 何時使用

- 使用者要匯出 Watch Later / 任一 YT 播放清單成 md。
- 使用者要「根據標題分類」清單內容。
- 任何需要登入態（私人清單）的 YouTube 清單抓取。

## 前置條件

- `playwright-cli` 已安裝（否則 `npm install -g @playwright/cli@latest`）。
- 已有一個登入 YouTube 的 Chrome。**Watch Later 是私人清單，必須用登入態瀏覽器**，用 `attach --extension` 接上使用者自己的 Chrome。
- Extension token：使用使用者提供的 `PLAYWRIGHT_MCP_EXTENSION_TOKEN`。**不要把 token 值寫進本檔或 git**，一律從環境變數／當次指令帶入。

## 流程

### 1. 接上登入中的 Chrome

```bash
PLAYWRIGHT_MCP_EXTENSION_TOKEN=<TOKEN> playwright-cli attach --extension=chrome
```

成功會建立名為 `chrome` 的 session，之後指令都要帶 `-s=chrome`。

### 2. 導覽到清單

Watch Later 的固定 playlist id 是 `WL`：

```bash
playwright-cli -s=chrome goto "https://www.youtube.com/playlist?list=WL"
```

其他清單把 `WL` 換成該 playlist id（`.../playlist?list=<ID>`）。

### 3. 滾動 + 抽取（重點步驟）

寫一支 `run-code` 腳本 `scripts/extract.js`，一次完成「滾到全部載入」+「抽 title/href」。**關鍵：用 `scrollIntoView` 捲動最後一項，不要用 `window.scrollTo(0, docHeight)`**——後者在 YT 上不會觸發下一批載入（這是先前只抓到 187/191 的根因）。

```js
// scripts/extract.js  — 用: playwright-cli -s=chrome --raw run-code --filename=scripts/extract.js
async page => {
  const sel = 'ytd-playlist-video-renderer';
  const total = await page.evaluate(() => {
    const t = document.body.innerText;
    const m = t.match(/(\d+)\s*部影片/) || t.match(/(\d+)\s*videos/);
    return m ? parseInt(m[1], 10) : 0;
  });
  for (let i = 0; i < 300; i++) {
    const n = await page.locator(sel).count();
    if (total && n >= total) break;
    await page.evaluate(() => {
      const els = document.querySelectorAll('ytd-playlist-video-renderer');
      els[els.length - 1]?.scrollIntoView({ block: 'end' });
    });
    await page.waitForTimeout(1000);
  }
  const items = await page.evaluate(() => {
    const seen = new Set();
    return [...document.querySelectorAll('ytd-playlist-video-renderer')].map(el => {
      const a = el.querySelector('a#video-title') || el.querySelector('h3 a');
      const title = (a?.getAttribute('title') || a?.textContent || '').trim();
      const href = a?.getAttribute('href') || '';
      const id = new URL(href, location.origin).searchParams.get('v');
      return { title, url: id ? 'https://www.youtube.com/watch?v=' + id : '' };
    }).filter(x => x.url && !seen.has(x.url) && seen.add(x.url));
  });
  return JSON.stringify({ declaredTotal: total, loaded: items.length, items });
}
```

執行並存檔（**先寫到暫存再搬移**，避免中途 abort 把結果檔截成 0 byte）：

```bash
OUT=/tmp/wl.json
playwright-cli -s=chrome --raw run-code --filename=scripts/extract.js > "$OUT"
python3 -c "import json;d=json.loads(json.loads(open('$OUT').read()));print(d['declaredTotal'],d['loaded'])"
```

**驗證成功條件**：`loaded == declaredTotal`（或差距 < 幾筆且已停止成長）。若 `loaded < declaredTotal`，再跑一次步驟 3（頁面狀態還在，重跑很便宜）。

### 4. 轉 Markdown

```bash
python3 scripts/to_md.py "$OUT" "$HOME/watch-later.md"
```

`to_md.py` 會讀取 `{declaredTotal, loaded, items}` 並輸出：

```markdown
# YouTube 稍後觀看 (Watch Later)

共 N 部影片

1. [標題](https://www.youtube.com/watch?v=ID)
2. ...
```

### 5. 分類（可選，使用者要求「根據標題分類」時）

分類沒有 API，靠**讀標題人工/LLM 判斷**。做法：

1. 讀出 `watch-later.md` 的所有行。
2. LLM 依標題內容決定一組類別（建議 10–15 類，見下方）。
3. 把「類別 → 原始編號列表」寫成 `categories.json`：

```json
{ "職場・溝通・領導": [4, 8, 29], "心理・思維・自我成長": [1, 3, 5] }
```

4. 產生分類檔：

```bash
python3 scripts/categorize.py watch-later.md categories.json watch-later-categorized.md
```

`categorize.py` 以原始編號分組，並在結尾列出「未分類」項目，**必須檢查輸出的 `missing == []`**（先前漏了 #81、#124 兩筆，靠這個檢查補回）。

建議類別（依實際內容調整，勿硬套）：

```
職場・溝通・領導 / 心理・思維・自我成長 / 學習方法・記憶・閱讀 / 理財・財富
AI・程式・科技 / 數學・科學・科普 / 哲學・思想・佛學 / 電影解說・影評
劇集・日劇・美劇・動畫・漫畫 / 旅遊・美食・生活 / 健康・運動・健身
教育・教養 / 藝術・音樂・寫作 / 社會・時事・歷史・喜劇
```

跨類項目（如「電影+心理」「書評+心理」）就近擇一，別為了完美分類糾結。

## 已知陷阱

| 陷阱 | 症狀 | 解法 |
|---|---|---|
| 虛擬滾動 | `snapshot` 只顯示 ~100 筆 | 用 `run-code` 跑滾動+抽取腳本 |
| `scrollTo` 無效 | 只載入部分（如 187/191）就停 | 改用最後一項 `scrollIntoView({block:'end'})` |
| 結果檔被截成 0 byte | 中途 abort 或中斷 | 寫到 `/tmp` 再搬移；或直接重跑抽取（頁面狀態仍在） |
| 私人清單抓不到 | 開起來是空白/未登入 | 必須 `attach --extension` 用登入中的 Chrome，不能用預設 in-memory 瀏覽器 |
| `--raw` 包一層 JSON 字串 | `json.loads` 一層不夠 | 內容是 `json.dumps(str)`，需 `json.loads(json.loads(s))` |
| 分類漏項 | 有些影片沒歸到類 | `categorize.py` 印出 `missing`，逐一補回 |

## 注意事項

- **不要 hardcode extension token** 到檔案或 git；從環境變數／使用者當次輸入取得。
- 抽出的連結統一用 `https://www.youtube.com/watch?v=<id>`，去掉 `list=/index=/t=/pp=` 等追蹤參數。
- 完成後在回覆中給出：檔案路徑、影片總數、分類數量（若有分類）。
- 若使用者只要清單不要分類，跳過步驟 5。
