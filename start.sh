#!/bin/bash
# =============================================================================
# InfiniteTalk ComfyUI Startup Script
# =============================================================================

echo "=========================================="
echo "  InfiniteTalk ComfyUI - RunPod Edition"
echo "=========================================="
echo ""

# Navigate to ComfyUI directory
cd /ComfyUI

# Display GPU info
echo "🖥️  GPU Information:"
nvidia-smi --query-gpu=name,memory.total --format=csv,noheader
echo ""

# Display model status
echo "📦 Checking models..."
echo "  - Wan2.1 480p GGUF: $(ls -lh /ComfyUI/models/diffusion_models/WanVideo/wan2.1-i2v-14b-480p-Q8_0.gguf 2>/dev/null | awk '{print $5}' || echo 'Missing')"
echo "  - Wan2.1 480p fp8:  $(ls -lh /ComfyUI/models/diffusion_models/WanVideo/wan2.1_i2v_480p_14B_fp8_e4m3fn.safetensors 2>/dev/null | awk '{print $5}' || echo 'Missing')"
echo "  - InfiniteTalk:     $(ls /ComfyUI/models/diffusion_models/WanVideo/InfiniteTalk/ 2>/dev/null | wc -l) files"
echo "  - VAE:              $(ls -lh /ComfyUI/models/vae/wanvideo/Wan2_1_VAE_bf16.safetensors 2>/dev/null | awk '{print $5}' || echo 'Missing')"
echo "  - Text Encoder:     $(ls -lh /ComfyUI/models/text_encoders/umt5-xxl-enc-bf16.safetensors 2>/dev/null | awk '{print $5}' || echo 'Missing')"
echo "  - CLIP Vision:      $(ls -lh /ComfyUI/models/clip_vision/clip_vision_h.safetensors 2>/dev/null | awk '{print $5}' || echo 'Missing')"
echo ""

echo "🚀 Starting ComfyUI on port 8188..."
echo "   Access via: https://[POD_ID]-8188.proxy.runpod.net"
echo ""

# Start ComfyUI
python main.py --listen 0.0.0.0 --port 8188 --enable-cors-header
