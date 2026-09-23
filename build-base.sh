#!/usr/bin/env sh

IMAGE_NAME="localhost/golang-boot-dev:latest"

echo "Building base image: ${IMAGE_NAME}..."
podman build --no-cache --squash -t "${IMAGE_NAME}" -f Containerfile .
echo "Complete"
