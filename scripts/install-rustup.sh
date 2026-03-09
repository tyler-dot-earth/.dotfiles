#!/usr/bin/env bash
set -euo pipefail

if ! command -v curl >/dev/null 2>&1; then
  echo "Missing required command: curl" >&2
  exit 1
fi

curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path --default-toolchain stable

# shellcheck disable=SC1091
source "$HOME/.cargo/env"

cargo --version
