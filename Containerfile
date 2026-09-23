FROM golang:1.27-trixie

# Install dependencies
# coreutils needed for cat
RUN apt-get update && apt-get install -y \
    coreutils \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Create app user with UID 1000 and /app directory
RUN useradd -m -u 1000 -s /bin/bash app && \
    mkdir -p /app && \
    chown -R app:app /app

# Switch to app user
WORKDIR /home/app
USER app

# Install bootdev CLI
RUN go install github.com/bootdotdev/bootdev@latest

# Ensure user's GOPATH/bin is in PATH
ENV PATH=$PATH:/home/app/go/bin

# Verify installation
RUN bootdev --version || bootdev version || echo "bootdev installed successfully"

WORKDIR /app
