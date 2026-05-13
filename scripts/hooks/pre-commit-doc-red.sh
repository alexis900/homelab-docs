#!/usr/bin/env bash
# Regenera Doc-Red/legacy/Doc-Red-full.md si se modifica la documentación legacy
# Úsalo como hook: ln -s ../../scripts/hooks/pre-commit-doc-red.sh .git/hooks/pre-commit

set -euo pipefail

changed=$(git diff --cached --name-only)

needs_build=false
while IFS= read -r path; do
case "$path" in
    Doc-Red/legacy/*)
      needs_build=true
      break
      ;;
  esac
done <<< "$changed"

if [[ "$needs_build" == "true" ]]; then
  echo "[hook] Regenerando Doc-Red/legacy/Doc-Red-full.md..."
  ./scripts/build-doc-red.sh
  git add Doc-Red/legacy/Doc-Red-full.md
fi
