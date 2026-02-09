# Boot.dev Development Container

This repository contains Docker/Podman container configurations for a development environment with Go, Node.js, and the Boot.dev CLI.

## Container Images

### Base Image (golang-node-dev)

The base image includes:
- Go 1.25 (from golang:1.25-trixie)
- Node.js v21.7.0 (via nvm)
- npm

**File:** `Containerfile`

### Boot.dev CLI Image (bootdev-cli)

Extends the base image with:
- Boot.dev CLI tool (github.com/bootdotdev/bootdev)

**File:** `Containerfile.bootdev`

## Usage

### Building and Running with Docker Compose

```bash
# Build and start the bootdev container
docker-compose -f docker-compose.bootdev.yml up -d --build

# Execute a shell in the container
docker-compose -f docker-compose.bootdev.yml exec bootdev bash

# Stop the container
docker-compose -f docker-compose.bootdev.yml down
```

### Building Manually with Podman/Docker

```bash
# Build the base image
podman build -t golang-node-dev:latest -f Containerfile .

# Build the bootdev image
podman build -t bootdev-cli:latest -f Containerfile.bootdev .

# Run the bootdev container
podman run -it -v .:/app -p 3000:3000 -p 8080:8080 bootdev-cli:latest bash
```

## Container Features

- **Working Directory:** `/app`
- **Volume Mount:** Current directory mounted to `/app`
- **Exposed Ports:**
  - 3000: Node.js applications
  - 8080: Go applications
- **Environment Variables:**
  - `NODE_ENV=development`
  - `GO111MODULE=on`

## Available Tools

Inside the container, you have access to:
- `go` - Go compiler and tools
- `node` - Node.js runtime
- `npm` - Node package manager
- `nvm` - Node Version Manager
- `bootdev` - Boot.dev CLI tool

## Requirements

- Podman or Docker installed
- podman-docker package (if using Podman with docker-compose)
