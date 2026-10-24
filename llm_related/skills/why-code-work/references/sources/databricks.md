# Databricks 分析與系統表

## 這個來源裡有什麼

Databricks 是產品分析、資料管道和數倉遙測這一層。它和 Datadog 互補。Datadog 是*基礎設施 / 執行時*視角，Databricks 是*產品 / 資料*視角（使用者做了什麼、哪些實驗在跑、功能使用怎麼變、某個閾值常量從哪來）。

- **產品分析事件。** `your_warehouse.events.analytics_track_event`（原始）以及 `<your_analytics_db>.<schema>.<table>` 裡帶型別、去過重、按事件拆開的 dbt 模型。使用者行為：功能呼叫、點選、接受 / 拒絕、提交、客戶端上報的錯誤。
- **使用與計費事件。** `your_warehouse.events.usage_event` / `<your_analytics_db>.<schema>.stg_usage_events`，`your_warehouse.events.raw_model_event` / `<your_analytics_db>.<schema>.stg_raw_model_events`。要看成本或流量推動的決定時，用這些。
- **實驗 / 功能開關資料。** 曝光表和結果表。**Schema 因公司而異。** 在假設表名之前，先用 `SHOW TABLES` 探一下。
- **系統表。** `system.query.history`、`system.compute.warehouses`、`system.billing.*`、`system.access.audit`。用來回答「這條查詢貴嗎」「有人跑過幾次」「數倉負載什麼時候衝高」。
- **dbt 血緣。** `<your_analytics_db>.<schema>` 裡的模型能看出哪些管道依賴某張表或某個欄位。上游一變，讀這些表的程式碼常常也得改。
- **Databricks notebook。** 工程師改程式碼之前寫的探索分析。**SQL MCP 查不到。** 如果你懷疑理由在 notebook 裡，把它記成缺口。

## 怎麼搜

使用 Databricks SQL MCP。主工具是 `execute_sql_read_only`。如果它返回 `statement_id`，用 `poll_sql_result` 去輪詢，不要重新跑。

**先定向，再查詢。** Schema 因公司而異。先探明，再信一個表名：

```sql
SHOW TABLES IN <your_analytics_db>.<schema> LIKE '*<keyword>*';
DESCRIBE TABLE <your_analytics_db>.<schema>.stg_<event>;
```

**每條查詢都要限時間。** 這些表很大，不設限的掃描會超時。在 `_timestamp`（事件）或 `start_time`（`system.query.history`）上過濾，視窗框住釋出日期，一般前後各約 30 天，只有很強的理由才放寬。

**優先用帶型別的 dbt 模型，不要用原始表。** `<your_analytics_db>.<schema>.<table>` 去過重、帶型別，並且是 liquid-clustered。`your_warehouse.events.analytics_track_event` 有重複，而且 `properties_json` 沒有型別。模型名的模式是 `stg_<source>_<event_name_with_underscores>`，其中 `<source>` 是 `app`、`backend`、`website` 或 `cli`。光靠模式定不下來時，用 `SHOW TABLES` 確認確切的模型名。只有還沒有 dbt 模型，或者你要的是 dbt 重新整理延遲之內的事件時，才退回原始表。

**帶型別的 dbt 模型有一套列約定**（記住這些，就不用再跑一趟 `DESCRIBE`）：

- `_timestamp`、`_id`、`_auth_id`、`_request_id`、`event_name`。每個模型都有的標準欄位
- `properties_<name>`。帶型別、下劃線形式的事件屬性（`properties_entrypoint`、`properties_size_bytes` 等）
- `context_team_id`、`context_client_version`、`context_country`、`context_client_os`。預先抽好的客戶端上下文

### 通常值得做的查法

按目標選表和列：

1. **事件使用軌跡。** 在 PR 合併前後各約 30 天的視窗裡，看相關 `stg_*` 模型的每日計數。合併後一兩天內從零跳到穩定流量，是這條 PR 釋出了該功能的強旁證。掉到零，像是棄用或刪除。
2. **護欄 / 防禦檢查從哪來。** 看 PR *之前* 14 天裡，相關 `properties_<name>` 列的分佈（median / p99 / max）。如果 p99 對得上目標裡的閾值常量，說明這個數字多半是按資料選的。
3. **查實驗 / 功能開關。** 用 `SHOW TABLES ... LIKE '*experiment*'` 找到曝光表，再按相關的 flag key，把 PR 日期附近各 variant 的曝光計數拉出來。
4. **遷移、回填或效能重寫的查詢歷史。** 在 `system.query.history` 裡用 `statement_text ILIKE '%<table_or_symbol>%'` 過濾，再配一個收緊的 `start_time` 視窗，就能把可能推動這次改動的貴查詢翻出來（按 `total_duration_ms` 排序，或聚合 `SUM(read_bytes)`、`COUNT(*)`）。
5. **dbt 血緣。** 如果目標讀或寫某個 `<your_analytics_db>.<schema>` 模型，這個模型自己的 git 歷史（在本倉庫裡）常常帶著理由。把這條線索交還給 git 調查員，不要自己追。

## 怎樣算好證據

除了上面這些模式：

- 一條用來給錯誤分類的事件，計數在防禦性程式碼的 PR 之後幾天裡掉到接近零。這暗示該 PR 把這類錯誤消掉了
- 曝光表裡有一行寫著目標的 feature-flag 鍵，並在 PR 釋出日期附近有 "shipped" / "concluded"（已釋出 / 已結束）的決定

## 常見陷阱

- **有埋點不等於因此而存在。** 有一條事件，只說明有人在意到願意去記它，不能說明目的碼*因為*它才存在。先和 git 調查員的 PR 或 commit 引用對上，再聲稱有因果關係。
- **埋點會悄悄變。** 事件量的階躍，可能是一條新事件開始被記錄，不是使用者行為變了。把上升讀成功能釋出的訊號之前，先在同一視窗裡查有沒有埋點相關的 PR。
- **Schema 會漂。** 事件屬性會變。帶型別的 dbt 模型上今天有的列，目標寫出來的時候可能還沒有。更老的資料裡，這個屬性可能只在原始的 `properties_json` 裡。
- **dbt 重新整理有延遲。** `<your_analytics_db>.<schema>.*` 按計劃重建（常常是按小時或按天）。最近幾小時的事件，退回 `your_warehouse.events.*`，並按 `_id` 去重。
- **表是公司自己的。** 實驗、功能開關、計費、使用這些表，各家不一樣。用一張你從沒確認存在的表去報結果，是典型的失敗。先用 `SHOW TABLES` / `DESCRIBE TABLE` 探一下。
- **過了保留期。** 相關視窗如果早於這張表的保留期，或者早於 dbt 模型的建立日期，那是*缺口*，不是空結果。明確寫出來，免得合成器把「沒有結果」讀成「沒有活動」。
- **Notebook 查不到。** SQL MCP 看不到 Databricks notebook。如果你懷疑理由在某份 notebook 裡，就返回一個缺口。

## 要返回什麼

每項相關發現：

- 型別（產品事件 / 實驗曝光 / 使用或計費事件 / 系統表的行 / dbt 模型）
- 全限定表名，以及你實際跑的那條查詢
- 查詢的時間視窗
- 緊湊的數值摘要（計數、分位數、首次 / 末次出現的時間戳）。**不要倒出原始行。**
- 和目標釋出日期的時間關係（例如「首行 2024-08-15，PR #49074 在 2024-08-14 合併」）
- 相關程度 + 強度：直接 / 旁證 / 弱
