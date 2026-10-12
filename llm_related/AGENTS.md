## Main Rules
- explain to me and MUST using plain language
- 都用繁體中文回覆，就算我用英文來問問題也是
- 回覆的中文盡量依照 "中文 STE" (see below section: what is "中文 STE")


###  what is "中文 STE"
中文 STE = 白話、短句、主動、一詞一義、禁成語與虛詞。
是**受控語言（controlled language）**——限制詞彙、限制句長、限制句式，換來零歧義。


| STE 原則 | 中文對應做法 |
|---|---|
| 一句一指令 | 一句一事，逗號不要串三個動作 |
| 主動語態 | 少用「被／由／經／予以／加以」 |
| 一詞一義 | 全程用同一個詞，不准「拆卸／取下／卸除」輪替 |
| 句長上限 | 指令句 ≤20 字、敘述句 ≤25 字 |
| 少從句、少套疊修飾 | 把「的…的…的」拆成獨立短句 |
| 避免名詞化 | 「進行檢查」→「檢查」 |

### 中文特有的三個坑

1. **虛詞偽裝**：「予以」「加以」「之虞」「恐有」「俾利」——這些是中文被動語態與模糊性的來源。
2. **成語**：對母語者親切，對非母語者與機器是歧義（「差強人意」到底好不好？）。技術文件應禁。
3. **主詞省略**：中文本來常省略主詞，但 STE 要求補主詞，否則「誰做」不明。

### 範例

**例 1：多指令 + 被動 + 長句**

- ❌ 非簡明：
  > 「在拆卸泵浦之前，請務必確認系統壓力已確實洩除完畢，否則在高溫狀態下殘餘液體恐有噴濺之虞，進而對人員造成灼傷。」

- ✅ 簡明中文：
  > 「先洩掉系統壓力，再拆泵浦。液體很燙。液體噴出來會燙傷人。」

  （拆成三句，一句一事，主動，去虛詞）

**例 2：一詞多義**

- ❌ 非簡明：同一顆 pump，一下「拆卸」、一下「取下」、一下「卸除」。
- ✅ 簡明：全程只用「拆卸」。

**例 3：被動 + 名詞化**

- ❌ 非簡明：
  > 「線路的檢查應由技術人員於恢復供電之前予以執行。」

- ✅ 簡明：
  > 「技術人員必須先檢查線路，再送電。」

**例 4：從句套疊**

- ❌ 非簡明：
  > 「位於引擎左側、負責控制通往燃燒室燃油流量的那顆閥門，在環境溫度超過維修手冊所載限值時，必須予以關閉。」

- ✅ 簡明：
  > 「閥門在引擎左側。它控制通往燃燒室的燃油流量。環境溫度超過限值時，關閉閥門。限值寫在維修手冊裡。」



## 表格使用規則

Markdown 表格只適合「短內容」。當儲存格內容太長時,表格在純文字編輯器裡會很難閱讀,所以請遵守以下規則:

**可以用表格的情況(必須全部符合):**
- 欄位數 ≤ 4¡
- 每個儲存格 ≤ 10 個字(或一個短語)
- 內容是簡單的對照,例如名稱 / 數值 / 狀態

**不要用表格,改用其他格式的情況(符合任一即可):**
- 任一儲存格包含完整句子、多個句子或程式碼
- 需要在儲存格內換行或放清單
- 欄位數 ≥ 5
- 比較的項目有大量說明文字

**替代格式(依情況選擇):**
1. **詳細清單**:每個項目一個小標題,底下用子項目列出各屬性

   - **項目 A**
     - 優點:...
     - 缺點:...
     - 適用情境:...

2. **標題 + 段落**:每個項目用 `###` 小標題,再接簡短說明
3. **Key: Value 清單**:適合屬性對照
4. **先給一個極簡表格(只放短關鍵字),詳細說明另外用清單補充**

預設以「純文字編輯器也能順暢閱讀」為原則,不確定時選清單而非表格。



## on LLM config related
- when I ask to install the LLM skill, install in this path: 
  - /Users/re4388/project/personal/my-github-pjt/dotfiles/llm_related/skills/
- when we need to update the AGENTS.md, update in this path: 
  - /Users/re4388/project/personal/my-github-pjt/dotfiles/llm_related/AGENTS.md
- when we need to update the opencode config, update this path: 
  - /Users/re4388/project/personal/my-github-pjt/dotfiles/llm_related/opencode.jsonc
- in short, i manage these config in /Users/re4388/project/personal/my-github-pjt/dotfiles/llm_related folder, so I can use git to manage thhese config.


## Main coding principle
Tradeoff: These guidelines bias toward caution over speed. For trivial tasks, use judgment.

1. Think Before Coding
Don't assume. Don't hide confusion. Surface tradeoffs.

Before implementing:

State your assumptions explicitly. If uncertain, ask.
If multiple interpretations exist, present them - don't pick silently.
If a simpler approach exists, say so. Push back when warranted.
If something is unclear, stop. Name what's confusing. Ask.
2. Simplicity First
Minimum code that solves the problem. Nothing speculative.

No features beyond what was asked.
No abstractions for single-use code.
No "flexibility" or "configurability" that wasn't requested.
No error handling for impossible scenarios.
If you write 200 lines and it could be 50, rewrite it.
Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

3. Surgical Changes
Touch only what you must. Clean up only your own mess.

When editing existing code:

Don't "improve" adjacent code, comments, or formatting.
Don't refactor things that aren't broken.
Match existing style, even if you'd do it differently.
If you notice unrelated dead code, mention it - don't delete it.
When your changes create orphans:

Remove imports/variables/functions that YOUR changes made unused.
Don't remove pre-existing dead code unless asked.
The test: Every changed line should trace directly to the user's request.

4. Goal-Driven Execution
Define success criteria. Loop until verified.

Transform tasks into verifiable goals:

"Add validation" → "Write tests for invalid inputs, then make them pass"
"Fix the bug" → "Write a test that reproduces it, then make it pass"
"Refactor X" → "Ensure tests pass before and after"
For multi-step tasks, state a brief plan:

1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

These guidelines are working if: fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

## Documentation & Planning Rules
1. 每次當使用者確認了一個新的實作計畫，必須將其記錄在 `docs/` 目錄下的相關設計文件中。
2. 每次實作內容有調整或優化時，必須同步更新對應的實作文件，確保文件與程式碼一致。
3. 每次只要有新增程式碼，就一定要有對應的單元測試。


## Sub-Agent Routing Rules

### Spawn PARALLEL agents when:
- Changes span independent domains (frontend/backend/DB)
- Multiple file analyses with no interdependency
- Research tasks that don't modify files

### Spawn SEQUENTIAL agents when:
- Output of step N is input of step N+1
- DB migration must precede service implementation

### Domain ownership:
- Frontend agent: React components, UI state
- Backend agent: API routes, business logic
- Database agent: Schema, migrations, queries