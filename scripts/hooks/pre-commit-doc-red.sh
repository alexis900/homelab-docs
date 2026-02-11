#!/usr/bin/env bash
# Regenera Doc-Red-full.md si se modifica alguna sección de Doc-Red
# Úsalo como hook: ln -s ../../scripts/hooks/pre-commit-doc-red.sh .git/hooks/pre-commit

set -euo pipefail

changed=$(git diff --cached --name-only)

needs_build=false
while IFS= read -r path; do
  case "$path" in
    Doc-Red.md|Doc-Red/*)
      needs_build=true
      break
      ;;
  esac
done <<< "$changed"

if [[ "$needs_build" == "true" ]]; then
  echo "[hook] Regenerando Doc-Red-full.md..."
  ./scripts/build-doc-red.sh
  git add Doc-Red-full.md
fi
