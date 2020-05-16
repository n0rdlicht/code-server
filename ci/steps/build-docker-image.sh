#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."
  source ./ci/lib.sh

  ./ci/release-container/build.sh

  mkdir -p release-images
  docker save "codercom/code-server:$VERSION-$ARCH" > "release-images/$ARCH.tar"
}

main "$@"
