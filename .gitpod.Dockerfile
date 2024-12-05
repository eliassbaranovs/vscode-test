# Use the base image
FROM mcr.microsoft.com/devcontainers/typescript-node:20-bookworm

# Add install script
ADD install-vscode.sh /root/
RUN /root/install-vscode.sh

# Configure git
RUN git config --system codespaces-theme.hide-status 1

# Switch to node user
USER node

# Install node-gyp globally
RUN npm install -g node-gyp

# Set up npm cache
RUN NPM_CACHE="$(npm config get cache)" && rm -rf "$NPM_CACHE" && ln -s /vscode-dev/npm-cache "$NPM_CACHE"

# Set DISPLAY environment variable
RUN echo 'export DISPLAY="${DISPLAY:-:1}"' | tee -a ~/.bashrc >> ~/.zshrc

# Switch back to root user
USER root

# Install Python and build dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-distutils \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Set permissions and create npm cache directory
CMD chown node:node /vscode-dev && sudo -u node mkdir -p /vscode-dev/npm-cache && sleep inf

# Copy the application code
COPY . /app/.

# Run npm ci with cache
RUN --mount=type=cache,id=s/4a11c9d5-94c6-453a-8cc4-dfb18a469183-/root/npm,target=/root/.npm npm ci
