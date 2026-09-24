---
name: manga-loader
description: 用 CopyManga（拷貝漫畫，簡中翻譯日漫）搜尋、下載漫畫並做成 EPUB（單章／合訂本／分冊）、驗證品質與訂閱更新。當使用者說「下載漫畫」「抓漫畫」「把某部漫畫做成 epub」「訂閱漫畫更新」「manga download」時使用。
---

# Manga Loader（本機封裝）

這個 skill 目錄**只有這份 SKILL.md**。實際程式在上游 repo，本機資料在 `~/Downloads/manga`。

## 位置對照（先看這個）

| 用途 | 路徑 |
| --- | --- |
| 實作 repo（scripts / vendor / 上游規則） | `/Users/re4388/project/personal/git-clone-pjt/manga-loader-skill` |
| 漫畫成品與過程資料 | `/Users/re4388/Downloads/manga/{library,runs}`（已 symlink 進 repo） |
| 上游完整規則（簡中，權威） | `<repo>/SKILL.md`、`<repo>/AGENTS.md`、`<repo>/README.md` |

以下 `<repo>` = `/Users/re4388/project/personal/git-clone-pjt/manga-loader-skill`。

## 唯一入口

```bash
cd <repo>
.runtime/python-venv/bin/python3 scripts/manga_loader.py <subcommand> ...
```

**不要用系統 `python3`**：系統 python 沒有 Pillow，會直接 `ModuleNotFoundError: No module named 'PIL'`。

## 常見指令

```bash
cd <repo>

# 搜尋（使用者只給書名時先做這個，不要猜 comic_id）
.runtime/python-venv/bin/python3 scripts/manga_loader.py search --query "藍箱"

# 一次性下載（長篇一定加 --split-chapters-per-volume，不要做成一個巨大合訂本）
.runtime/python-venv/bin/python3 scripts/manga_loader.py download-full \
  --query "藍箱" --split-chapters-per-volume 40

# 只從某一話開始（含該話）下載，例如第 80 話到下載清單結尾
.runtime/python-venv/bin/python3 scripts/manga_loader.py download-full \
  --query "更衣人偶坠入爱河" --from-chapter 80

# 斷線後續傳（已下載章節不重抓）
.runtime/python-venv/bin/python3 scripts/manga_loader.py download-full --query "藍箱" --resume

# 訂閱並立刻跑一次
.runtime/python-venv/bin/python3 scripts/manga_loader.py subscribe --query "藍箱" --run-now

# 環境體檢（含網路探測 + 稽核 library 產物）
.runtime/python-venv/bin/python3 scripts/manga_loader.py doctor --check-network
```

## 產物位置

- 單章：`<repo>/library/<漫畫名>/chapters/`
- 合訂本：`<repo>/library/<漫畫名>/merged/<漫畫名> 合订版.epub`
- 分冊：`<repo>/library/<漫畫名>/volumes/<漫畫名> 第XX册.epub`
- 過程與報告：`<repo>/runs/<job-name>/report.json`

`library/`、`runs/` 實際落在 `~/Downloads/manga/`，repo 內只是 symlink。交付時引用 `library/`，**不要把 `runs/` 當最終閱讀目錄**。

## 清理中間產物

確認成品 OK（`library/<漫畫名>/` 的 chapters/merged/volumes 都在，且 `validate-epub` 回 `"valid": true`）後，就可以刪掉 `~/Downloads/manga/runs/`（章節圖、KCC 中間產物、`report.json`），只留成品可省下大量空間（實測 254 話省 11GB）。

```bash
rm -rf ~/Downloads/manga/runs/*      # 保留 runs 目錄本身
```

- `runs/` 是 symlink 目標，**目錄本身要留著**，否則 repo 內 `runs` 會變 dangling symlink，之後 `download-full` 會建不出 job。
- 刪完後 `doctor` 會出現 `no_audit_targets_found` warning，那是預期的，不是壞掉。
- 想保留紀錄就別刪 `report.json`；要重建合訂本／分冊就得留著 `runs/<job>/epubs/`（用 `rebuild-merged` / `rebuild-split`）。

## macOS 本機設定（這次踩過的雷）

1. **host python 要先有 Pillow**。本機已建好 `<repo>/.runtime/python-venv`。若不存在，重建：
   ```bash
   cd <repo>
   /opt/homebrew/bin/python3.12 -m venv .runtime/python-venv
   .runtime/python-venv/bin/python -m pip install -r requirements.txt
   ```
2. **vendor 附的 downloader 是 Linux aarch64，macOS 跑不動**，要自己編：
   ```bash
   cd <repo>
   cargo build --release --manifest-path vendor/copymanga-headless-rs-src/Cargo.toml
   cp vendor/copymanga-headless-rs-src/target/release/copymanga-headless-rs .runtime/bin/
   ```
   編好的 macOS 版已在 `<repo>/.runtime/bin/`。
   **不要跑 `bootstrap --force`**，它會把 macOS binary 蓋回不能跑的 Linux 版。
3. **API 網域**：上游預設 `api.2025copy.com` 已失效。`<repo>/config/settings.json` 已改成可用的 `api.mangacopy.com`。這個檔被 repo 的 `.gitignore` 忽略，只存在本機，重 clone 要再改一次。
4. **搬家遺毒**：`runs/*/report.json`、`library/*/series.json` 內存**絕對路徑**。若再次搬動 repo，要同步改這些字串，否則 `doctor` 會誤報 `epub_audit_failed`。

## 已知量級

254 話的長篇（例：藍箱）約 10 分鐘下載 + 15 分鐘 KCC 打包／分冊，`library/` 約 8GB。

## 驗收標準

一次任務算完成，至少要：
- 指令 exit code 0
- `<repo>/runs/<job-name>/report.json` 存在且含目標產物路徑
- 產物檔真的存在
- `validate-epub --path <epub>` 回 `"valid": true`

## 衝突時的權威順序

上游 `<repo>/SKILL.md` 的**流程與驗證規則**為準（含它寫死的 `/mnt/ssd/...` 主機段落，那在本機不適用）；**路徑與 macOS 例外以本檔為準**。
