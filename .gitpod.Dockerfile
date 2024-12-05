# Use the base image
FROM ghcr.io/railwayapp/nixpacks:ubuntu-1731369831

# Set the working directory
WORKDIR /app/

# Copy the Nixpacks configuration
COPY .nixpacks/nixpkgs-e05605ec414618eab4a7a6aea8b38f6fbbcc8f08.nix .nixpacks/nixpkgs-e05605ec414618eab4a7a6aea8b38f6fbbcc8f08.nix

# Install Nixpacks dependencies
RUN nix-env -if .nixpacks/nixpkgs-e05605ec414618eab4a7a6aea8b38f6fbbcc8f08.nix && nix-collect-garbage -d

# Copy the application code
COPY . /app/.

# Install Python and build dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-distutils \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Run npm ci with cache
RUN --mount=type=cache,id=s/4a11c9d5-94c6-453a-8cc4-dfb18a469183-/root/npm,target=/root/.npm npm ci

# Start the application
CMD ["./openvscode-server", "--port", "$PORT", "--host", "0.0.0.0"]
