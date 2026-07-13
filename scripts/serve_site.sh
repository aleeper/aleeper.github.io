#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SITE_DIR="${1:-$REPO_ROOT/_site}"
PORT="${PORT:-8888}"

python3 -m http.server "$PORT" --directory "$SITE_DIR"
