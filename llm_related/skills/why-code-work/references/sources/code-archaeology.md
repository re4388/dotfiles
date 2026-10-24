# 程式碼考古（git + 倉庫內）

## 這個來源裡有什麼

- 提交歷史（說明、日期、作者、diff）
- PR 描述、評審評論、討論串（透過 `gh`）
- 行內程式碼註釋、TODO、FIXME、棄用說明
- ADR（架構決策記錄），如果倉庫裡有
- 測試。名字和斷言常常記下了促使這次改動的邊界情況
- 同一次提交裡一起改過的相關檔案（同改訊號）
- 倉庫裡的 CHANGELOG 條目和釋出說明
- 提交說明和 PR 正文裡的工單 ID

這是最可信的來源，直接綁在程式碼上，也最完整。凡是進過倉庫的，這裡都該有。

## 怎麼搜

把種子提交列表再擴開：

```bash
# History through renames
git log --follow --oneline -- <file>

# Pickaxe: commits that added or removed this exact text
git log -S '<exact_string_from_code>' -- <file>

# Or for patterns:
git log -G '<regex>' -- <file>

# Who wrote each line and when
git blame -L <start>,<end> <file>

# One commit's full diff
git show <hash>

# Commits between two points affecting this file
git log <old>..<new> -p -- <file>
```

再找提交記錄之外的文件：

```bash
# ADRs often live in docs/adr/ or similar
rg -l -i 'architecture.decision' --glob '*.md'

# TODOs and FIXMEs near the target
rg -n -C2 '(TODO|FIXME|HACK|XXX|NOTE)' <target_file>

# Related tests
rg -l '<symbol>' --glob '*test*'
```
