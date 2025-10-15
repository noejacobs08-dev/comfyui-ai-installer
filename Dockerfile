# ============================================================
#  ComfyUI - Base Installer (fast startup, manual model install)
# ============================================================

FROM ubuntu:22.04

# Set working directory
WORKDIR /opt/comfy

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget git python3 python3-venv python3-pip ffmpeg && \
    pip install jupyterlab && \
    rm -rf /var/lib/apt/lists/*

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Copy your scripts and workflows
COPY install_models.sh /opt/comfy/install_models.sh
COPY workflows /opt/comfy/workflows

RUN chmod +x /opt/comfy/install_models.sh

# Expose ports
EXPOSE 8188
EXPOSE 8888

# Default startup (no model install)
CMD bash -c "\
  echo '🚀 Starting JupyterLab (manual model installation enabled)...'; \
  jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='' --NotebookApp.password='' & \
  echo '🚀 Starting ComfyUI...'; \
  cd /opt/comfy/ComfyUI && python3 main.py --listen 0.0.0.0 --port 8188"
