# ============================================================
#  ComfyUI - Chapter 1: AI Influencer Base Setup (WAN 2.2)
# ============================================================

# 1️⃣ Use the official ComfyUI base image
FROM ghcr.io/comfyanonymous/comfyui:latest

# 2️⃣ Set the working directory
WORKDIR /workspace

# 3️⃣ Install small utilities (for wget/git)
RUN apt-get update && apt-get install -y wget git && rm -rf /var/lib/apt/lists/*

# 4️⃣ Copy workflow and startup script
COPY workflows /workspace/workflows
COPY start.sh /workspace/start.sh
RUN chmod +x /workspace/start.sh

# 5️⃣ Expose ComfyUI's port
EXPOSE 8188

# 6️⃣ Run the start script
CMD ["/bin/bash", "/workspace/start.sh"]
