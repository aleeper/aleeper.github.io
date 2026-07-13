#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

SOURCE_DIR="${1:-$REPO_ROOT}"
CV_DIR="${2:-$REPO_ROOT/_cv_build}"
OUTPUT_DIR="${3:-$REPO_ROOT/_site}"

rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

RSYNC_ARGS=(
  -a
  --delete
  --exclude '.git/'
  --exclude '.github/'
  --exclude '_site/'
  --exclude '_cv_build/'
)

if [[ "$OUTPUT_DIR" == "$SOURCE_DIR"/* ]]; then
  OUTPUT_SUBPATH="${OUTPUT_DIR#"$SOURCE_DIR"/}"
  RSYNC_ARGS+=(--exclude "$OUTPUT_SUBPATH/")
fi

rsync "${RSYNC_ARGS[@]}" "$SOURCE_DIR"/ "$OUTPUT_DIR"/

mkdir -p "$OUTPUT_DIR/CV"
cp "$CV_DIR/LeeperResume.pdf" "$OUTPUT_DIR/CV/LeeperResume.pdf"
cp "$CV_DIR/LeeperCV.pdf" "$OUTPUT_DIR/CV/LeeperCV.pdf"

# Prevent GitHub Pages from running Jekyll against the raw static artifact.
touch "$OUTPUT_DIR/.nojekyll"
