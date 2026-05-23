---
name: goRules_edit_decision_table
description: Edit GoRules decision table nodes via Playwright CLI. Use when user wants to add/modify rules in a decision table, edit input/output columns, add rows, or configure decision table fields in the GoRules editor. Also use when user mentions "decision table", "edit table", or adding rules to a GoRules graph node.
---

# GoRules Edit Decision Table

透過 Playwright CLI 在 GoRules 編輯器中編輯 decision table 節點的 input/output columns 和 rules。

線上參考文件：[Building decision tables - GoRules Documentation](https://docs.gorules.io/learn/authoring/decision-tables)

## Quick start

```bash
# 1. 點擊 decision table node 上的 "Edit Table" 按鈕
playwright-cli click <edit-table-ref>

# 2. 設定 input column field（targeted mode：直接寫 field path，如 a1）
playwright-cli click <input-field-dropdown-ref>
playwright-cli fill <tooltip-textbox-ref> "a1"
playwright-cli click <update-button-ref>

# 3. 設定 output column field
playwright-cli click <output-field-dropdown-ref>
playwright-cli fill <tooltip-textbox-ref> "result"
playwright-cli click <update-button-ref>

# 4. 新增 rule row
playwright-cli click <add-row-button-ref>

# 5. 填入 input cell 值
playwright-cli click <input-cell-ref>
playwright-cli fill <cell-textbox-ref> "99" --submit

# 6. 填入 output cell 值
playwright-cli click <output-cell-ref>
playwright-cli fill <cell-textbox-ref> '"good"' --submit
```

注意：ref 值會因頁面狀態而變化，每次操作前應先 `playwright-cli snapshot` 確認最新的 ref。

## Workflow

目標：在 GoRules 編輯器中的 decision table node 設定 columns 和 rules。

### 步驟 1：進入 Edit Table

確保 decision table node 存在於 graph 中，找到該 node 上的 "Edit Table" 按鈕並點擊。
- 按鈕文字為 "Edit Table"，通常在 node 下方
- 點擊後會開啟 decisionTable tab

### 步驟 2：設定 Input Column Field

每個 input column 有兩種模式：
- **Targeted (unary) mode**：設定 field path（如 `a1`），cell 內只需填 comparison value（如 `99`）
- **Generic mode**：field 設為 `-`，cell 內需寫完整 expression（如 `a1 == 99`）

操作方式：
1. 點擊 input column header 中的 field name（dropdown）
2. 在彈出的 tooltip 中找到 textbox，填入 field path
3. 點擊 "Update" 確認

### 步驟 3：設定 Output Column Field

與 input 類似，但設定的是輸出的 field name：
1. 點擊 output column header 中的 field name
2. 在 tooltip 的 textbox 中填入 field path（如 `result`）
3. 點擊 "Update" 確認

### 步驟 4：新增 Rule Row

點擊 table 底部的 "Add row" 按鈕（plus-circle icon），會產生一個新的 empty row。

### 步驟 5：填入 Cell 值

- **Input cell**：點擊 cell 後出現 textbox，填入 condition value（targeted mode 只需值），`--submit` 按 Enter 確認
- **Output cell**：點擊 cell 後填入輸出值，字串需用雙引號 `"value"`
- **Description cell**（可選）：同上操作

### 步驟 6：驗證

用 `playwright-cli snapshot` 確認 table 內容正確。

## Hit Policy

預設為 **First**（回傳第一個匹配的 row）。可透過 node 的 "Settings" 按鈕修改為 **Collect** 等其他 policy。詳見線上文件。

## 附加欄位

可透過 Inputs/Outputs header 旁的 "plus" 按鈕新增更多 input 或 output column。
