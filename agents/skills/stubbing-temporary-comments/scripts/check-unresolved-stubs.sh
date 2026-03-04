#!/usr/bin/env bash
set -euo pipefail

search_root="${1:-.}"

if command -v rg >/dev/null 2>&1; then
  matches="$(rg --line-number --color=never \
    --glob '!**/*.md' \
    --glob '!**/node_modules/**' \
    --glob '!**/.next/**' \
    --glob '!**/dist/**' \
    "STUB\\[" "$search_root" || true)"
else
  matches="$(grep -R -n \
    --exclude='*.md' \
    --exclude-dir='node_modules' \
    --exclude-dir='.next' \
    --exclude-dir='dist' \
    "STUB\\[" "$search_root" || true)"
fi

if [[ -n "$matches" ]]; then
  echo "Unresolved STUB markers found:"
  echo "$matches"
  exit 1
fi

echo "No unresolved STUB markers found."
