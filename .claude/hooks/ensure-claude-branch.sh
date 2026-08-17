#!/usr/bin/env bash
# Cloud sessions: move onto claude/* so git push origin HEAD is accepted.
set -uo pipefail

is_cloud=0
if [ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || [ -n "${CLAUDE_CODE_REMOTE_SESSION_ID:-}" ]; then
  is_cloud=1
fi

if [ "$is_cloud" -ne 1 ]; then
  echo "[glossary-routine] local session: skip claude/ checkout"
  exit 0
fi

if [ ! -d .git ]; then
  echo "[glossary-routine] no .git; skip"
  exit 0
fi

current=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unknown)
case "$current" in
  claude/*)
    echo "[glossary-routine] already on $current. After commit: git push origin HEAD (never HEAD:main)."
    ;;
  *)
    branch="claude/glossary-$(TZ=Asia/Tokyo date +%Y%m%d)"
    if git checkout -B "$branch"; then
      echo "[glossary-routine] now on $branch. After commit: git push origin HEAD. Never git push origin HEAD:main."
    else
      echo "[glossary-routine] ERROR: git checkout -B $branch failed (was on $current)" >&2
    fi
    ;;
esac
exit 0
