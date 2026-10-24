# Datadog 遙測

## 這個來源裡有什麼

Datadog 記下的是執行時記錄：生產裡實際發生了什麼。計劃和討論裡說的，不在這份記錄裡。

- **指標。** 團隊埋進去的計數器、gauge、直方圖。一條指標的*存在*本身就是證據：有人覺得這個數字值得看。
- **Monitor 與告警。** 團隊認定值得把人叫醒的條件。一條在 `rate_limit_hit > 10/min` 上觸發的 monitor，是直接證據：團隊擔心這個閾值。
- **儀表盤。** 整理過的檢視，能看出團隊覺得這個子系統裡什麼重要。
- **APM trace 與 span。** 請求一級的執行時資料，用來回答「為什麼慢」「為什麼這裡會超時」。
- **日誌。** 量大的事件記錄，裡面常常就是促使人寫下防禦程式碼的那些錯誤條件。
- **事故。** 正式的事故記錄，帶時間線和連結的事後覆盤。
- **Notebook。** 團隊自己做的探索調查，裡面常常有假設和分析。

## 怎麼搜

使用 Datadog MCP。先廣，再收窄。

1. **找出負責的服務。**

   ```
   search_datadog_services (filter by name or team)
   search_datadog_service_dependencies (see upstream/downstream)
   ```

2. **先看儀表盤和 monitor。**

   ```
   search_datadog_dashboards (query: feature name, service name, symbol)
   search_datadog_monitors   (same queries)
   ```

   儀表盤或 monitor 覆蓋了目標時，記下它的查詢和它盯著的閾值。這個閾值常常就是「為什麼卡在 N」的答案。

3. **目標周圍的指標。**

   ```
   search_datadog_metrics (by name pattern, e.g., the feature or symbol)
   get_datadog_metric_context (metadata: description, units, tags)
   get_datadog_metric (timeseries; "was there a spike around the PR date?")
   ```

   把一條指標的軌跡和目標新增或改動的日期對上，是很強的旁證：「`payment_timeout` 在 2023-11-03 衝高，重試邏輯在 2023-11-06 合併。」

4. **日誌。收窄，不要倒出來。**

   ```
   search_datadog_logs (raw log patterns near the target, set use_log_patterns=true)
   analyze_datadog_logs (SQL-style aggregations, only when you need counts)
   ```

   用符號、錯誤字串或功能名來搜。**強烈優先使用帶時間範圍的查詢**（例如改動前後各 30 天）。

5. **APM span 和 trace。**

   ```
   aggregate_spans    (stats: "how often does this endpoint fail?")
   search_datadog_spans (inspect individual spans)
   get_datadog_trace  (a specific trace ID)
   ```

   適合看超時、重試、慢路徑，以及跨服務的行為。

6. **事故。**

   ```
   search_datadog_incidents (by title, team, date range)
   get_datadog_incident     (full detail for a specific incident)
   ```

   如果目標看起來是防禦性的，就搜它加進去前後的事故。時間線裡寫著 "added defensive check for X"（為 X 加了防禦檢查）的事故，幾乎就是直接證據。

## 怎樣算好證據

- 一條 monitor，它的查詢和閾值對得上程式碼強制的那條約束（程式碼卡在 100，monitor 在請求超過 100/min 時告警）
- 目標作者建的儀表盤，上面的圖對得上程式碼在測量或在防禦的東西
- 一條指標在程式碼合併前的生產環境裡衝高，合併之後穩住
- 一份事故記錄提到目的碼、同樣的符號，或同樣的錯誤字串
- 日誌裡有防禦程式碼會攔住的某種錯誤模式，時間戳落在改動之前的視窗裡

## 常見陷阱

- **相關不是因果。** PR 之前衝高、之後穩住，這只是提示，不是定論，因為同一視窗裡可能還有別的改動落地。去看相鄰的 PR。
- **過度貼合你找到的那張圖。** 圖反映的是做圖人自己的框法。一張名叫 "retry success rate" 的圖，說明團隊在意重試是否成功，不能說明某一行程式碼就是因此存在的。
- **遙測沒了。** 指標可能改了名、刪了，或保留期很短。相關時間視窗裡找不到資料，這是缺口，不是空結果。
- **量大之後全是噪聲。** 搜日誌時按 service、tag 和時間視窗使勁收窄。用 `analyze_datadog_logs` 做聚合，不要把原始日誌倒出來。
- **有埋點不等於因此而加。** 有一條指標，只說明有人在意到願意去量，不能說明程式碼是*因為*它才加上的。和 commit、PR 的日期對一下。

## 要返回什麼

每項相關的：

- 型別（dashboard / monitor / metric / log pattern / trace / incident / notebook）
- 標題或名稱
- 連結或標識（dashboard ID、monitor ID、指標名、incident ID）
- 所有者 / 作者，以及建立 / 修改日期
- 和問題有關的具體條件、查詢或引文（能逐字就逐字）
- 相關性：這對目的碼說明什麼，連線有多強
