#!/usr/bin/env bash
# Cloud sessions: move onto claude/* so git push origin HEAD is accepted.
set -uo pipefail

# #region agent log
_debug() {
  python3 - "$1" "$2" "$3" <<'PY' || true
import json, os, sys, time
from pathlib import Path
hyp, loc, msg = sys.argv[1], sys.argv[2], sys.argv[3]
path = Path("/Users/Kaito_1/ghq/github.com/kit1132/06_ai-glossary/.cursor/debug-67b489.log")
payload = {
    "sessionId": "67b489",
    "runId": os.environ.get("GLOSSARY_DEBUG_RUN", "session-start"),
    "hypothesisId": hyp,
    "location": loc,
    "message": msg,
    "data": {
        "CLAUDE_CODE_REMOTE": os.environ.get("CLAUDE_CODE_REMOTE"),
        "CLAUDE_CODE_REMOTE_SESSION_ID": os.environ.get("CLAUDE_CODE_REMOTE_SESSION_ID"),
        "HEAD": os.environ.get("GLOSSARY_HEAD_BEFORE"),
    },
    "timestamp": int(time.time() * 1000),
}
try:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.open("a", encoding="utf-8").write(json.dumps(payload, ensure_ascii=False) + "\n")
except OSError:
    pass
PY
}
# #endregion

remote="${CLAUDE_CODE_REMOTE:-unset}"
session_id="${CLAUDE_CODE_REMOTE_SESSION_ID:-unset}"
is_cloud=0
if [ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || [ -n "${CLAUDE_CODE_REMOTE_SESSION_ID:-}" ]; then
  is_cloud=1
fi

echo "[glossary-routine] CLAUDE_CODE_REMOTE=${remote} SESSION_ID=${session_id} is_cloud=${is_cloud}"

if [ "$is_cloud" -ne 1 ]; then
  echo "[glossary-routine] local session: skip claude/ checkout"
  # #region agent log
  _debug M "ensure-claude-branch.sh" "skipped local session"
  # #endregion
  exit 0
fi

if [ ! -d .git ]; then
  echo "[glossary-routine] no .git; skip"
  exit 0
fi

current=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)
export GLOSSARY_HEAD_BEFORE="$current"
case "$current" in
  claude/*)
    echo "[glossary-routine] already on $current. After commit: git push origin HEAD (never HEAD:main)."
    # #region agent log
    _debug L "ensure-claude-branch.sh" "already on claude branch"
    # #endregion
    ;;
  *)
    branch="claude/glossary-$(TZ=Asia/Tokyo date +%Y%m%d)"
    if git checkout -B "$branch"; then
      echo "[glossary-routine] now on $branch. After commit: git push origin HEAD. Never git push origin HEAD:main."
      # #region agent log
      _debug L "ensure-claude-branch.sh" "created claude branch"
      # #endregion
    else
      echo "[glossary-routine] ERROR: git checkout -B $branch failed (was on $current)" >&2
      # #region agent log
      _debug M "ensure-claude-branch.sh" "checkout failed"
      # #endregion
    fi
    ;;
esac
exit 0
