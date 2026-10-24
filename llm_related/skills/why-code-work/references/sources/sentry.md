# Sentry 錯誤歷史

## 怎麼搜

使用 Sentry MCP。

1. **先摸清。** 如果不知道 project slug 和 organization：

   ```
   find_organizations
   find_projects
   ```

2. **搜和目標相關的 issue。**

   ```
   search_issues (natural language, e.g., "errors in PaymentService timeout", "unhandled exceptions in uploadFile")
   ```

   查詢用這些來拼：目的碼處理的異常類名、它的函式或類名、它要檢查的錯誤訊息字串，以及它的檔案路徑。

3. **按 release 和時間視窗收窄。**

   ```
   search_issue_events (filter by release, time, environment, trace ID, tags)
   get_issue_tag_values (for an issue, see distribution across versions, users, environments)
   ```

   對懷疑相關的 issue，核對**首次出現**和**末次出現**（停下來的時間是否對得上目標的釋出日期）、**受影響的 release**（哪些版本見過，哪個是修復版），以及**頻率軌跡**（是不是先衝高，然後被解決）。

4. **把完整 event 拉下來看上下文。**

   ```
   get_sentry_resource (pass a Sentry URL or type+ID)
   ```

   堆疊有沒有經過目的碼？標籤和 breadcrumb 是否對得上目標要防的那些條件？

5. **查目標附近落地的 release。**

   ```
   find_releases (around the commit date of the target)
   ```

   拿 release 版本和 PR 的合併日期對一下。

6. **Seer 少用。**

   ```
   analyze_issue_with_seer
   ```

   Seer 的 AI 根因分析是用來提假設的。把它當成推斷，不要當成定論。真正的 event 和堆疊才是主要證據。

## 要返回什麼

每個相關 issue：

- Issue ID 和標題
- 專案和 organization
- 首次出現 / 末次出現的時間戳
- Event 計數（知道取樣率就寫上）
- 受影響的 release
- 一段能看出和目標有關的代表性堆疊（逐字摘錄，不要摘要）
- 首次 / 末次出現和目標釋出日期的時間關係
- issue 的連結
- 作者的評論，或解決時的說明
