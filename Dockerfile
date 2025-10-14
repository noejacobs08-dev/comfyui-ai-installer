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

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Copy workflows and install script
COPY workflows /workspace/workflows
COPY install_models.sh /workspace/install_models.sh
RUN chmod +x /workspace/install_models.sh

# Copy model installer but run it only when container starts
COPY install_models.sh /workspace/install_models.sh
RUN chmod +x /workspace/install_models.sh

# Expose both ComfyUI and JupyterLab ports
EXPOSE 8188
EXPOSE 8888

# Launch JupyterLab + ComfyUI
CMD bash -c "\
  jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='' --NotebookApp.password='' & \
  cd /workspace/ComfyUI && python3 main.py --listen 0.0.0.0 --port 8188"
