#!/usr/bin/env python3
"""Add one video's summary <id>.md as ONE Apple Note.

Usage:
    python3 md_to_apple_note.py <id>.md [--force]

Rules learned the hard way:
  - Notes derives the note title from the FIRST line of the body. So the md's
    first "# Title" line becomes the note title (nothing else needed).
  - Notes scales incoming HTML font-size by ~2/3, with a 9px floor. So to show
    output size O, we must give input O*1.5. Without this, body text shrinks to
    9px.
  - `whose name is "..."` filtering is broken in Notes; match names in a loop.
"""
import os
import re
import subprocess
import sys
import tempfile

ACCOUNT = "iCloud"
FOLDER = "YT 稍後觀看"

# displayed px -> input px (Notes scales by ~2/3)
def px(out):
    return round(out * 1.5)

BODY, H3, H2, H1 = 24, 26, 26, 28


def esc(s):
    return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")


def inline(s):
    s = esc(s)
    s = re.sub(r"\*\*(.+?)\*\*", r"<b>\1</b>", s)
    s = re.sub(r"`(.+?)`", r"<b>\1</b>", s)
    return s


def line(out, content):
    return '<div><span style="font-size: %dpx">%s</span></div>' % (px(out), content)


def md_to_html(md):
    out = []
    for raw in md.split("\n"):
        s = raw.rstrip()
        if s.strip().startswith("<!--"):
            continue
        if not s.strip():
            out.append("<div><br></div>")
            continue
        m = re.match(r"^# (.*)$", s)
        if m:
            out.append(line(H1, "<b>%s</b>" % inline(m.group(1)))); continue
        m = re.match(r"^## (.*)$", s)
        if m:
            out.append(line(H2, "<b>%s</b>" % inline(m.group(1)))); continue
        m = re.match(r"^### (.*)$", s)
        if m:
            out.append(line(H3, "<b>%s</b>" % inline(m.group(1)))); continue
        m = re.match(r"^> (.*)$", s)
        if m:
            out.append(line(BODY, "「%s」" % inline(m.group(1)))); continue
        m = re.match(r"^[-*] (.*)$", s)
        if m:
            out.append(line(BODY, "• " + inline(m.group(1)))); continue
        m = re.match(r"^(\d+)[.)] (.*)$", s)
        if m:
            out.append(line(BODY, "%s. %s" % (m.group(1), inline(m.group(2))))); continue
        out.append(line(BODY, inline(s)))
    return "\n".join(out)


def first_heading(md):
    for ln in md.split("\n"):
        m = re.match(r"^# (.+)$", ln.strip())
        if m:
            return m.group(1).strip()
    return None


def existing_titles():
    script = (
        'tell application "Notes"\n'
        '  set AppleScript\'s text item delimiters to "\n"\n'
        '  try\n'
        '    return (name of notes of folder "%s" of account "%s") as string\n'
        '  on error\n'
        '    return ""\n'
        '  end try\n'
        'end tell\n' % (FOLDER, ACCOUNT)
    )
    r = subprocess.run(["osascript"], input=script, capture_output=True, text=True)
    return set(r.stdout.split("\n")) if r.stdout.strip() else set()


def make_note(title, body_html, force):
    d = tempfile.mkdtemp(prefix="notesync")
    tpath = os.path.join(d, "title.txt")
    bpath = os.path.join(d, "body.html")
    open(tpath, "w", encoding="utf-8").write(title)
    open(bpath, "w", encoding="utf-8").write(body_html)
    force_lit = "true" if force else "false"
    script = (
        'set d to "%s/"\n'
        'set theTitle to read (POSIX file (d & "title.txt")) as «class utf8»\n'
        'set theBody to read (POSIX file (d & "body.html")) as «class utf8»\n'
        'set force to %s\n'
        'tell application "Notes"\n'
        '  if not (exists folder "%s" of account "%s") then\n'
        '    make new folder at account "%s" with properties {name:"%s"}\n'
        '  end if\n'
        '  tell account "%s"\n'
        '    tell folder "%s"\n'
        '      set hit to missing value\n'
        '      repeat with n in (every note)\n'
        '        if (name of n) is theTitle then set hit to n\n'
        '      end repeat\n'
        '      if hit is not missing value then\n'
        '        if force then\n'
        '          set body of hit to theBody\n'
        '          return "updated"\n'
        '        else\n'
        '          return "skipped"\n'
        '        end if\n'
        '      end if\n'
        '      make new note with properties {body:theBody}\n'
        '      return "created"\n'
        '    end tell\n'
        '  end tell\n'
        'end tell\n'
    ) % (d, force_lit, FOLDER, ACCOUNT, ACCOUNT, FOLDER, ACCOUNT, FOLDER)
    r = subprocess.run(["osascript"], input=script, capture_output=True, text=True)
    import shutil
    shutil.rmtree(d, ignore_errors=True)
    if r.returncode != 0:
        sys.exit("osascript failed: " + r.stderr.strip())
    return r.stdout.strip()


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    if not args:
        sys.exit("usage: md_to_apple_note.py <id>.md [--force]")
    path = args[0]
    force = "--force" in sys.argv
    md = open(path, encoding="utf-8").read()
    title = first_heading(md) or os.path.splitext(os.path.basename(path))[0]
    body = md_to_html(md)
    if first_heading(md) is None:
        body = line(H1, "<b>%s</b>" % esc(title)) + "\n" + body
    if not force and title in existing_titles():
        print("skipped (already exists):", title)
        return
    print(make_note(title, body, force) + ":", title)


if __name__ == "__main__":
    main()
