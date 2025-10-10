# ============================================================
#  ComfyUI - Chapter 1: AI Influencer Base Setup (Ubuntu base)
# ============================================================

FROM ubuntu:22.04

# Set working directory
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && \
    apt-get install -y wget git python3 python3-venv python3-pip ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Copy workflow and startup script
COPY workflows /workspace/workflows
COPY start.sh /workspace/start.sh
RUN chmod +x /workspace/start.sh

# Expose ComfyUI web port
EXPOSE 8188

# Run the start script
CMD ["/bin/bash", "/workspace/start.sh"]
