#!/usr/bin/env python3
"""Weekly routine cadence: FULL official check vs HEARTBEAT only.

隔週は ISO 奇数週では決めていない。前回本調査日から 13 日未満なら HEARTBEAT。
（ISO W53→W01 の連続奇数、bash の %V=08 八進エラーを避ける）
"""
from __future__ import annotations

import os
import re
import sys
from datetime import datetime
from pathlib import Path
from zoneinfo import ZoneInfo

JST = ZoneInfo("Asia/Tokyo")
MIN_GAP_DAYS = 13


def parse_last_full(state_text: str) -> str | None:
    for line in state_text.splitlines():
        m = re.match(r"^- 前回本調査日（JST）:\s*(.+)$", line)
        if not m:
            continue
        raw = m.group(1).strip()
        if re.fullmatch(r"\d{4}-\d{2}-\d{2}", raw):
            return raw
        return None
    return None


def main() -> int:
    root = Path(__file__).resolve().parents[1]
    state_path = Path(sys.argv[1]) if len(sys.argv) > 1 else root / ".last-check-state.md"
    claude_md = root / "CLAUDE.md"
    command_md = root / ".claude/commands/biweekly-glossary-update.md"

    today_s = os.environ.get("GLOSSARY_TODAY")
    today = datetime.strptime(today_s, "%Y-%m-%d").date() if today_s else datetime.now(JST).date()
    iso_week = today.isocalendar().week
    files_ok = claude_md.is_file() and command_md.is_file()

    last_full = None
    if state_path.is_file():
        last_full = parse_last_full(state_path.read_text(encoding="utf-8"))

    gap = None
    decision = "FULL"
    if last_full:
        last_d = datetime.strptime(last_full, "%Y-%m-%d").date()
        gap = (today - last_d).days
        if gap < MIN_GAP_DAYS:
            decision = "HEARTBEAT"

    print(f"TODAY={today.isoformat()}")
    print(f"ISO_WEEK={iso_week}")
    print(f"LAST_FULL={last_full or 'none'}")
    print(f"GAP_DAYS={gap if gap is not None else 'none'}")
    print(f"FILES_OK={str(files_ok).lower()}")
    print(f"DECISION={decision}")
    if not files_ok:
        print("ERROR=procedure files missing; this clone is not the glossary routine default branch", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
