# 事故與事後覆盤上下文

- **Linear**：找標了 `incident`、`sev-*`、`postmortem-action-item`、`reliability` 的工單
- **Slack**：在目的碼加進去的那些日期附近，搜 `#sev-*` 和 `#incident-*` 頻道
- **Git**：提交資訊裡出現 "fix for incident"（為事故而修）、"add defensive check"（加防禦檢查），以及 "revert" 後面跟著 "re-apply with..."（回退之後又用……重新加上），都是強訊號
