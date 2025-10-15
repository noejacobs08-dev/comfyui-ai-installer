# ============================================================
#  ComfyUI - Fast Startup Base (manual model installation)
# ============================================================

FROM ubuntu:22.04

# Set working directory (persistent on RunPod)
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && \
    apt-get install -y wget git python3 python3-venv python3-pip ffmpeg && \
    pip install jupyterlab && \
    rm -rf /var/lib/apt/lists/*

# Copy scripts and workflows
COPY install_models.sh /workspace/install_models.sh
COPY workflows /workspace/workflows

RUN chmod +x /workspace/install_models.sh

# Expose ComfyUI and JupyterLab ports
EXPOSE 8188
EXPOSE 8888

# Start both JupyterLab and ComfyUI (clone on first launch)
CMD bash -c '\
  if [ ! -d /workspace/ComfyUI ]; then \
    echo "📦 Cloning ComfyUI repository..."; \
    ( \
      git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI & \
      pid=$!; \
      sp="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"; \
      echo -n "   "; \
      while kill -0 $pid 2>/dev/null; do \
        for i in $(seq 0 9); do \
          printf "\b${sp:$i:1}"; \
          sleep 0.1; \
        done; \
      done; \
      wait $pid; \
    ); \
    echo "✅ ComfyUI cloned successfully!"; \
  else \
    echo "✅ ComfyUI already exists — skipping clone."; \
  fi; \
  echo "🚀 Starting JupyterLab..."; \
  jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token="" --NotebookApp.password="" & \
  echo "🚀 Starting ComfyUI..."; \
  cd /workspace/ComfyUI && python3 main.py --listen 0.0.0.0 --port 8188'
