FROM golang:1.26-trixie

# Install dependencies needed for nvm
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create app user with UID 1000 and /app directory
RUN useradd -m -u 1000 -s /bin/bash app && \
    mkdir -p /app && \
    chown -R app:app /app

# Switch to app user
WORKDIR /home/app

# Install bootdev CLI
RUN go install github.com/bootdotdev/bootdev@latest

# Ensure user's GOPATH/bin is in PATH
ENV PATH=$PATH:/home/app/go/bin

# Verify installation
RUN bootdev --version || bootdev version || echo "bootdev installed successfully"

WORKDIR /app
