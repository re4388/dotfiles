# 來源 playbook

why skill 為每個可用的證據類別派一名調查員，每人只讀下面自己那一類的 playbook。這些 playbook 是常見 MCP 的具體例子。同一類裡換一個 MCP，就照著改。

| 類別 | Playbook | 對應的示例 MCP |
|---|---|---|
| 原始碼控制歷史 | [`code-archaeology.md`](./sources/code-archaeology.md) | git、`gh` |
| 工單 / ticket 跟蹤 | [`linear.md`](./sources/linear.md) | Linear（可改寫成 Jira、GitHub Issues、Plane、Shortcut） |
| 長文文件 | [`notion.md`](./sources/notion.md) | Notion（可改寫成 Confluence、Google Docs、Coda） |
| 實時團隊聊天 | [`slack.md`](./sources/slack.md) | Slack（可改寫成 Discord、Microsoft Teams、Mattermost） |
| 基礎設施可觀測性 | [`datadog.md`](./sources/datadog.md) | Datadog（可改寫成 New Relic、Honeycomb、Grafana、Splunk） |
| 錯誤 / 異常跟蹤 | [`sentry.md`](./sources/sentry.md) | Sentry（可改寫成 Rollbar、Bugsnag、Airbrake） |
| 產品分析數倉 | [`databricks.md`](./sources/databricks.md) | Databricks SQL（可改寫成 Snowflake、BigQuery、ClickHouse、dbt） |

跨類別：

- [`incident-postmortem.md`](./sources/incident-postmortem.md)。如果目的碼看起來是防禦性的（空值檢查、重試、超時、限流、功能開關、出口守衛、OOM 處理），把這份也加上。
