# ============================================================
#  ComfyUI - Chapter 1: AI Influencer Base Setup (Ubuntu base)
# ============================================================

FROM ubuntu:22.04

WORKDIR /workspace

# Install system dependencies + JupyterLab
RUN apt-get update && \
    apt-get install -y wget git python3 python3-venv python3-pip ffmpeg && \
    pip install --upgrade pip && \
    pip install jupyterlab && \
    rm -rf /var/lib/apt/lists/*

# Clone ComfyUI from GitHub
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI

# Copy your installer + workflows into container
COPY install_models.sh /workspace/install_models.sh
COPY workflows /workspace/workflows

RUN chmod +x /workspace/install_models.sh

# 🔍 Debug: list everything inside /workspace before running anything
RUN echo "=== /workspace after COPY ===" && ls -R /workspace

# Expose ports
EXPOSE 8188
EXPOSE 8888

# Combined startup command
CMD bash -c "\
  if [ ! -f /workspace/ComfyUI/models/.installed ]; then \
    echo '🚀 First-time setup: installing models...'; \
    bash /workspace/install_models.sh && touch /workspace/ComfyUI/models/.installed; \
  else \
    echo '✅ Models already installed, skipping download.'; \
  fi; \
  jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='' --NotebookApp.password='' & \
  cd /workspace/ComfyUI && python3 main.py --listen 0.0.0.0 --port 8188"
