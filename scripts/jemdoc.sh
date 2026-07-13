#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
LATEX_IMAGE="${LATEX_DOCKER_IMAGE:-ghcr.io/xu-cheng/texlive-debian:latest}"
DOCKER_PLATFORM="${LATEX_DOCKER_PLATFORM:-linux/amd64}"

if ! command -v docker >/dev/null 2>&1; then
  echo "docker is required for 'npm run jemdoc'." >&2
  echo "Install Docker Desktop or set up another Docker runtime, then try again." >&2
  exit 1
fi

docker run --rm \
  --platform "$DOCKER_PLATFORM" \
  -v "$REPO_ROOT:/workdir" \
  -w /workdir \
  "$LATEX_IMAGE" \
  make
