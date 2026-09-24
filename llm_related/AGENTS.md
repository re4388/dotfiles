## Contents

- [Contents](#contents)
- [Main Rules](#main-rules)
- [on LLM config related](#on-llm-config-related)
- [Main coding principle](#main-coding-principle)
- [Documentation \& Planning Rules](#documentation--planning-rules)
- [Sub-Agent Routing Rules](#sub-agent-routing-rules)
  - [Spawn PARALLEL agents when:](#spawn-parallel-agents-when)
  - [Spawn SEQUENTIAL agents when:](#spawn-sequential-agents-when)
  - [Domain ownership:](#domain-ownership)

---
## Main Rules
- 這個討論請都用繁體中文回覆，就算我用英文來問問題也是
- assume you are the smartest person/programmer in the world


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