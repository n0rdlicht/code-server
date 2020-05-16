#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."
  source ./ci/lib.sh

  download_artifact release-images ./release-images
  if [[ ${CI-} ]]; then
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
  fi

  for img in ./release-images/*; do
    docker load -i "$img"
  done

  export DOCKER_CLI_EXPERIMENTAL=enabled
  docker manifest create "codercom/code-server:$VERSION" \
    "codercom/code-server:$VERSION-amd64" \
    "codercom/code-server:$VERSION-arm64"
  docker manifest push "codercom/code-server:$VERSION"

  docker manifest create "codercom/code-server:latest" \
    "codercom/code-server:$VERSION-amd64" \
    "codercom/code-server:$VERSION-arm64"
  #  docker manifest push "codercom/code-server:latest"
}

main "$@"
