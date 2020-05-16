#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."
  source ./ci/lib.sh

  docker build -t "codercom/code-server:$VERSION-$ARCH" -f ./ci/release-container/Dockerfile .
}

main "$@"
