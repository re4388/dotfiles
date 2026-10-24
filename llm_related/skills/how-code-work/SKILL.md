---
name: how-code-work
description: "用於 \"how does X work\"、改動前的程式碼走讀，以及放哪、誰管、哪一層（\"where should this live\"、\"which package owns this\"、\"is this the right layer\"）。講清子系統架構、執行流程和心智模型。問動機、取捨、歷史原因用 why-code-work。"
disable-model-invocation: true
---

# How

探索程式碼庫，回答 "how does X work?" 這類問題。給出架構層面的解釋，達到一位資深工程師剛接手某個子系統時的水平——足以建立可用的心智模型，又不至於讀起來像逐行註釋的原始碼。

問題問的是動機、取捨、歷史原因，不是運作方式，那就不是這個 skill 的工作，是 `why-code-work` 的工作。那個 skill 只能由使用者顯式叫，你叫不動；先說明這一點，別用走讀硬答。

## 派生子代理

用 `subagent` 工具，**不要指定 `model`**，一律沿用目前對話的模型。

- **explorer** 用 `agent: "explore"`。這個 subagent 唯讀。
- **explainer** 用 `agent: "general"`。提示詞裡明確寫「只讀，不要修改或建立任何檔案」。

提示詞按 `references/explorer-prompt.md` 和 `references/explainer-prompt.md` 組出來，佔位符填滿。這兩個路徑相對於本 `SKILL.md` 所在目錄。

要並行的 explorer 放在同一則訊息裡一起送出，否則會一個等一個。

## 1. Assess complexity

若範圍含糊，先說出你的理解，再去探索。使用者可以糾正。

- **Simple**（單個模組、一個小工具，或某個很窄的問題，例如 "how does function X work"）：不要 explorer。派生一個 explainer，一趟就完成探索和講解，基於 `references/explainer-prompt.md` 構建，但不含 explorer-findings 一節。進入第 4 步。
- **Complex**（跨多個檔案或服務的子系統、橫切多個模組的功能、完整的架構概覽）：進入第 2 步。

拿不準時，走簡單那條路。

## 2. Explore (complex only)

把問題拆成 2 到 4 個角度，每個角度是子系統的一塊獨立切片。在單條訊息裡派生所有 explorer，每個都帶上 `references/explorer-prompt.md`，並填好各自的角度。

## 3. Synthesize (complex only)

等所有 explorer 都返回後，派生一個 explainer，帶上 `references/explainer-prompt.md`，並填入每個 explorer 的發現。

## 4. Present

呈現 explainer 的輸出。為了講清楚，或補上對話裡的上下文，做點小修改可以。不要大幅重寫。

## Output format

解釋使用 `references/explainer-prompt.md` 裡定義的幾節，不適用的就丟掉：概覽、核心概念、工作原理、各部分所在位置、易踩的坑。
