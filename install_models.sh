#!/bin/bash
echo "🚀 Installing models for Chapter 1: Base Image Creation..."

# Create model directories
mkdir -p /workspace/ComfyUI/models/vae
mkdir -p /workspace/ComfyUI/models/loras
mkdir -p /workspace/ComfyUI/models/unet
mkdir -p /workspace/ComfyUI/models/clip

# ========== VAE ==========
echo "⬇️ Downloading VAE..."
wget -O /workspace/ComfyUI/models/vae/Wan2_1_VAE_bf16.safetensors \
https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_bf16.safetensors

# ========== UNET ==========
echo "⬇️ Downloading UNET models..."
wget -O /workspace/ComfyUI/models/unet/wan2.2_t2v_low_noise_14B_fp16.safetensors \
https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_low_noise_14B_fp16.safetensors

wget -O /workspace/ComfyUI/models/unet/wan2.2_t2v_high_noise_14B_fp16.safetensors \
https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_high_noise_14B_fp16.safetensors

# ========== CLIP ==========
echo "⬇️ Downloading CLIP..."
wget -O /workspace/ComfyUI/models/clip/umt5_xxl_fp8_e4m3fn_scaled.safetensors \
https://huggingface.co/chatpig/encoder/resolve/main/umt5_xxl_fp8_e4m3fn_scaled.safetensors

# ========== LORAs ==========
echo "⬇️ Downloading LoRAs..."
wget -O /workspace/ComfyUI/models/loras/WAN2.2_Instagirl_HighNoise_V2.5.safetensors \
https://huggingface.co/Njacobs1992/Instagirl2.5/resolve/main/Instagirlv2.5-HIGH.safetensors

wget -O /workspace/ComfyUI/models/loras/WAN2.2_Instagirl_LowNoise_V2.5.safetensors \
https://huggingface.co/Njacobs1992/Instagirl2.5/resolve/main/Instagirlv2.5-LOW.safetensors

wget -O /workspace/ComfyUI/models/loras/Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors \
https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan21_T2V_14B_lightx2v_cfg_step_distill_lora_rank32.safetensors

wget -O /workspace/ComfyUI/models/loras/l3n0v0.safetensors \
https://huggingface.co/Njacobs1992/lenovo/resolve/main/Lenovo.safetensors

echo "✅ All models for Chapter 1 installed successfully!"
