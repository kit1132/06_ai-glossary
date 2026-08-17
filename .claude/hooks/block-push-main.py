#!/usr/bin/env python3
"""Deny git push to main. Cloud proxy and Routines only accept the current claude/ branch."""
from __future__ import annotations

import json
import os
import re
import sys
import time
from pathlib import Path

DEBUG_LOG = Path("/Users/Kaito_1/ghq/github.com/kit1132/06_ai-glossary/.cursor/debug-67b489.log")


def _debug(blocked: bool, command: str) -> None:
    # #region agent log
    payload = {
        "sessionId": "67b489",
        "runId": os.environ.get("GLOSSARY_DEBUG_RUN", "pretool"),
        "hypothesisId": "L",
        "location": ".claude/hooks/block-push-main.py",
        "message": "git push inspect",
        "data": {"blocked": blocked, "command": command[:300]},
        "timestamp": int(time.time() * 1000),
    }
    try:
        DEBUG_LOG.parent.mkdir(parents=True, exist_ok=True)
        DEBUG_LOG.open("a", encoding="utf-8").write(json.dumps(payload, ensure_ascii=False) + "\n")
    except OSError:
        pass
    # #endregion


def main() -> int:
    try:
        data = json.load(sys.stdin)
    except json.JSONDecodeError:
        return 0
    command = str((data.get("tool_input") or {}).get("command") or "")
    blocked = bool(
        re.search(r"git\s+push\b[^\n]*HEAD:main\b", command)
        or re.search(r"git\s+push\b[^\n]*\borigin\s+main\b", command)
        or re.search(r"git\s+push\b[^\n]*\brefs/heads/main\b", command)
    )
    _debug(blocked, command)
    if blocked:
        json.dump(
            {
                "hookSpecificOutput": {
                    "hookEventName": "PreToolUse",
                    "permissionDecision": "deny",
                    "permissionDecisionReason": "Do not push to main. Commit on claude/* and run git push origin HEAD. The workflow merges to main.",
                }
            },
            sys.stdout,
        )
        sys.stdout.write("\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
