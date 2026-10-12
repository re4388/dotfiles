#!/usr/bin/env python3
"""Convert extract.js JSON output to a Markdown link list.

Usage: to_md.py /tmp/wl.json ~/watch-later.md "YouTube 稍後觀看 (Watch Later)"
"""
import json
import sys


def main():
    src, out = sys.argv[1], sys.argv[2]
    title = sys.argv[3] if len(sys.argv) > 3 else "YouTube 稍後觀看 (Watch Later)"
    d = json.loads(json.loads(open(src).read().strip()))  # --raw wraps the JSON string once
    items = d["items"]
    lines = [f"# {title}", "", f"共 {len(items)} 部影片", ""]
    for i, it in enumerate(items, 1):
        lines.append(f'{i}. [{it["title"]}]({it["url"]})')
    open(out, "w").write("\n".join(lines) + "\n")
    assert items and all(it["url"].startswith("https://www.youtube.com/watch?v=") for it in items)
    print(f"written {len(items)} -> {out} (declaredTotal={d.get('declaredTotal')}, loaded={d.get('loaded')})")


if __name__ == "__main__":
    main()
