#!/bin/bash
set -e

echo "=== Setting up ComfyUI – Module 1 ==="

# 1️⃣ Folders
cd /workspace/ComfyUI
mkdir -p models/checkpoints models/clip models/vae models/loras custom_nodes

# 2️⃣ Models
echo "=== Downloading models from Hugging Face ==="

# --- UNet models ---
cd models/checkpoints
wget -q --show-progress -O wan2.2_t2v_low_noise_14B_fp16.safetensors \
  https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_low_noise_14B_fp16.safetensors
wget -q --show-progress -O wan2.2_t2v_high_noise_14B_fp16.safetensors \
  https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_high_noise_14B_fp16.safetensors

# --- CLIP ---
cd ../clip
wget -q --show-progress -O umt5_xxl_fp8_e4m3fn_scaled.safetensors \
  https://huggingface.co/chatpig/encoder/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors

# --- VAE ---
cd ../vae
wget -q --show-progress -O Wan2_1_VAE_bf16.safetensors \
  https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_bf16.safetensors

# --- LoRAs ---
cd ../loras
wget -q --show-progress -O WAN2.2_Instagirl_HighNoise_V2.5.safetensors \
  https://huggingface.co/Njacobs1992/Instagirl2.5/resolve/main/Instagirlv2.5-HIGH.safetensors
wget -q --show-progress -O WAN2.2_Instagirl_LowNoise_V2.5.safetensors \
  https://huggingface.co/Njacobs1992/Instagirl2.5/resolve/main/Instagirlv2.5-LOW.safetensors
wget -q --show-progress -O Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors \
  https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors
wget -q --show-progress -O l3n0v0.safetensors \
  https://huggingface.co/Njacobs1992/lenovo/resolve/main/Lenovo.safetensors

# 3️⃣ Custom nodes (KJNodes)
echo "=== Installing KJNodes ==="
cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/kijai/ComfyUI-KJNodes.git || true

# 4️⃣ Workflow
echo "=== Copying Chapter 1 workflow ==="
mkdir -p /workspace/ComfyUI/user/default
cp /workspace/workflows/chapter1_workflow.json /workspace/ComfyUI/user/default/workflow.json

# 5️⃣ Launch
echo "=== Launching ComfyUI on port 8188 ==="
cd /workspace/ComfyUI
python main.py --listen 0.0.0.0 --port 8188
