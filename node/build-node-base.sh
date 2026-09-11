#!/usr/bin/env sh

IMAGE_NAME="localhost/golang-node-dev:latest"

echo "Building base image: ${IMAGE_NAME}..."
podman build --squash -t "${IMAGE_NAME}" -f Containerfile .
echo "Complete"
