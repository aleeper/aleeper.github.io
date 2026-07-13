#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUTPUT_DIR="${1:-$REPO_ROOT/_site}"

make -C "$REPO_ROOT"
"${SCRIPT_DIR}/assemble_site.sh" "$REPO_ROOT" "$OUTPUT_DIR"
