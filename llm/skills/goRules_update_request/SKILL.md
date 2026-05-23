---
name: goRules_update_request
description: Update the request body in GoRules editor simulator via Playwright CLI. Use when user wants to modify the simulator request payload in the GoRules decision editor, or mentions updating/editing the request in GoRules.
---

# GoRules Update Request

更新 GoRules 編輯器中 Simulator 的 request body。

## Quick start

```bash
# 1. 打開 GoRules 編輯器（用 --headed --persistent 可保持瀏覽器狀態）
playwright-cli open https://localhost:5173/ --headed --persistent

# 2. 點擊 play-circle 按鈕打開 Simulator 面板
playwright-cli click e48
# 注意：ref 可能因頁面狀態改變，若失敗請先用 playwright-cli snapshot 確認 play-circle 按鈕的 ref

# 3. 填入新的 request body（JSON 字串）
playwright-cli fill "getByRole('textbox', { name: 'Editor content' }).first()" '{"key": "value"}'
```

## Workflow

目標：在 GoRules 編輯器的 Simulator 中設定 request body。

步驟：

1. **開啟頁面**：用 `playwright-cli open` 打開 GoRules 編輯器 URL
   - 使用 `--headed` 可以看到瀏覽器 UI
   - 使用 `--persistent` 保持 profile 跨 session

2. **開啟 Simulator**：點擊 play-circle 按鈕（快照中的 ref，通常是 e48）
   - 若找不到按鈕，先 `playwright-cli snapshot` 確認最新的 ref

3. **修改 request body**：用 `playwright-cli fill` 將 JSON 寫入第一個 `Editor content` textbox
   - Locator: `getByRole('textbox', { name: 'Editor content' }).first()`
   - 有兩個 Editor content textbox（Request 和 Output），`.first()` 選取 Request 那個

4. **驗證**（可選）：`playwright-cli snapshot` 確認內容已更新
