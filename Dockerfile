# Use the official ComfyUI Docker image
FROM ghcr.io/comfyanonymous/comfyui:latest

# Switch to workspace directory
WORKDIR /workspace

# Install useful tools
RUN apt-get update && apt-get install -y wget git && rm -rf /var/lib/apt/lists/*

# Copy the start script into the container
COPY start.sh /workspace/start.sh
RUN chmod +x /workspace/start.sh

# Expose ComfyUI's web port
EXPOSE 8188

# Run the start script when the container starts
CMD ["/bin/bash", "/workspace/start.sh"]
