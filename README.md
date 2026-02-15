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

## Working with Files (Rootless Podman)

When using rootless Podman, the container runs as a non-root user (UID 1000) for security. Due to user namespace mapping, files created by the container will appear with a different UID (like 100999) on your host.

To work with these files from your host, use `podman unshare`:

```bash
# View files created by the container
podman unshare ls -la app/

# Edit a file created by the container
podman unshare vim app/somefile.txt

# Remove files created by the container
podman unshare rm -rf app/build/

# Change ownership back to your host user (if needed)
podman unshare chown -R 1000:1000 app/
```

This is a security feature that keeps the container isolated from your host user while still allowing both to work with the same files.

## Requirements

- Podman or Docker installed
- podman-docker package (if using Podman with docker-compose)

# boot.dev

In the running container:

```bash
bootdev login
```

This will prompt to visit <https://boot.dev/cli/login> 

## Babel

To install and use Babel in the app:

``` bash
npm i -D @babel/core @babel/cli @babel/preset-env
```

Ensure a `.babelrc` file is present

``` json
{
  "presets": ["@babel/preset-env"]
}
```

Transpile, e.g.:

``` bash
npx babel main.js --out-file main.compiled.js
```



