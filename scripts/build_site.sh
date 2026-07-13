#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
DEFAULT_CV_DIR="${REPO_ROOT}/../cv"
DEFAULT_OUTPUT_DIR="${REPO_ROOT}/_site"

CV_DIR="${1:-$DEFAULT_CV_DIR}"
OUTPUT_DIR="${2:-$DEFAULT_OUTPUT_DIR}"

make -C "$REPO_ROOT"
"${SCRIPT_DIR}/assemble_site.sh" "$REPO_ROOT" "$CV_DIR" "$OUTPUT_DIR"
