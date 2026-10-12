#!/usr/bin/env python3
"""Group a watch-later.md by category using an explicit index mapping.

Usage: categorize.py watch-later.md categories.json watch-later-categorized.md

categories.json format (indices refer to the numbers in the source md):
  {"職場・溝通・領導": [4, 8, 29], "心理・思維・自我成長": [1, 3, 5]}

The script lists any uncategorized indices so the mapping can be completed;
verify it prints missing [].
"""
import json
import re
import sys


def main():
    src, cat_path, out = sys.argv[1], sys.argv[2], sys.argv[3]
    items = {}
    for line in open(src):
        m = re.match(r"^(\d+)\.\s+\[(.*)\]\((.*)\)$", line.rstrip("\n"))
        if m:
            items[int(m.group(1))] = (m.group(2), m.group(3))
    cats = json.load(open(cat_path))

    seen, lines = set(), ["# YouTube 稍後觀看 — 依主題分類", "", f"共 {len(items)} 部影片", "", "## 分類索引"]
    for c, idxs in cats.items():
        lines.append(f"- **{c}**（{len(idxs)}）")
    lines.append("")
    for c, idxs in cats.items():
        lines += [f"## {c}", ""]
        for i in sorted(idxs):
            if i in items:
                t, u = items[i]
                lines.append(f"{i}. [{t}]({u})")
                seen.add(i)
        lines.append("")
    missing = sorted(set(items) - seen)
    if missing:
        lines += ["## 未分類", ""]
        lines += [f"{i}. [{items[i][0]}]({items[i][1]})" for i in missing]
    open(out, "w").write("\n".join(lines) + "\n")
    print(f"total {len(items)} categorized {len(seen)} missing {missing}")


if __name__ == "__main__":
    main()
