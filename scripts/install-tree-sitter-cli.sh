#!/usr/bin/env bash
set -euo pipefail

if ! command -v cargo >/dev/null 2>&1; then
  echo "cargo not found. Run scripts/install-rustup.sh first." >&2
  exit 1
fi

if command -v tree-sitter >/dev/null 2>&1; then
  echo "tree-sitter already installed: $(tree-sitter --version)"
  exit 0
fi

cargo install --locked tree-sitter-cli

if command -v tree-sitter >/dev/null 2>&1; then
  echo "tree-sitter installed: $(tree-sitter --version)"
else
  echo "tree-sitter was installed, but is not on PATH in this shell. Restart shell and retry." >&2
  exit 1
fi
