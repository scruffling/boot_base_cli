FROM golang:1.25-trixie

# Install dependencies needed for nvm
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create app user and /app directory
RUN useradd -m -s /bin/bash app && \
    mkdir -p /app && \
    chown -R app:app /app

# Switch to app user
USER app
WORKDIR /home/app

# Install nvm as app user
ENV NVM_DIR=/home/app/.nvm
ENV NODE_VERSION=21.7.0

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install ${NODE_VERSION} \
    && nvm alias default ${NODE_VERSION} \
    && nvm use default

# Add node and npm to path
ENV NODE_PATH=$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Verify installations
RUN node --version && npm --version && go version

WORKDIR /app
