# =============================================================================
# InfiniteTalk ComfyUI - RunPod Template
# Audio-driven Talking Head Video Generation with Wan2.1 + InfiniteTalk
# Includes: ComfyUI + VS Code (code-server)
# =============================================================================

FROM runpod/pytorch:2.4.0-py3.11-cuda12.4.1-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    wget \
    curl \
    ffmpeg \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# =============================================================================
# Install code-server (VS Code Web)
# =============================================================================
RUN curl -fsSL https://code-server.dev/install.sh | sh

# =============================================================================
# Install ComfyUI
# =============================================================================
WORKDIR /
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /ComfyUI

WORKDIR /ComfyUI
RUN pip install --no-cache-dir -r requirements.txt

# =============================================================================
# Install Custom Nodes
# =============================================================================
WORKDIR /ComfyUI/custom_nodes

# WanVideo Wrapper (includes InfiniteTalk support)
RUN git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git && \
    cd ComfyUI-WanVideoWrapper && \
    pip install --no-cache-dir -r requirements.txt

# Video Helper Suite (for video output)
RUN git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git && \
    cd ComfyUI-VideoHelperSuite && \
    pip install --no-cache-dir -r requirements.txt

# =============================================================================
# Create Model Directories
# =============================================================================
RUN mkdir -p /ComfyUI/models/diffusion_models/WanVideo/InfiniteTalk \
    && mkdir -p /ComfyUI/models/vae/wanvideo \
    && mkdir -p /ComfyUI/models/text_encoders \
    && mkdir -p /ComfyUI/models/clip_vision \
    && mkdir -p /ComfyUI/models/diffusion_models/MelBandRoformer \
    && mkdir -p /ComfyUI/models/loras/WanVideo/Lightx2v

# =============================================================================
# Download Models (~35GB total for 480p)
# =============================================================================

# --- Wan2.1 Base Models (480p only) ---
# GGUF Q8 480p (~15GB)
RUN wget -q --show-progress -O /ComfyUI/models/diffusion_models/WanVideo/wan2.1-i2v-14b-480p-Q8_0.gguf \
    "https://huggingface.co/city96/Wan2.1-I2V-14B-480P-gguf/resolve/main/wan2.1-i2v-14b-480p-Q8_0.gguf"

# fp8 480p (~14GB)
RUN wget -q --show-progress -O /ComfyUI/models/diffusion_models/WanVideo/wan2.1_i2v_480p_14B_fp8_e4m3fn.safetensors \
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_i2v_480p_14B_fp8_e4m3fn.safetensors"

# --- InfiniteTalk Models ---
# GGUF Q8 (~2GB)
RUN wget -q --show-progress -O /ComfyUI/models/diffusion_models/WanVideo/InfiniteTalk/Wan2_1-InfiniteTalk_Single_Q8.gguf \
    "https://huggingface.co/Kijai/WanVideo_comfy_GGUF/resolve/main/InfiniteTalk/Wan2_1-InfiniteTalk_Single_Q8.gguf"

# fp8 Multi (~2GB)
RUN wget -q --show-progress -O /ComfyUI/models/diffusion_models/WanVideo/InfiniteTalk/Wan2_1-InfiniteTalk-Multi_fp8_e4m3fn_scaled_KJ.safetensors \
    "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/InfiniteTalk/Wan2_1-InfiniteTalk-Multi_fp8_e4m3fn_scaled_KJ.safetensors"

# --- VAE ---
RUN wget -q --show-progress -O /ComfyUI/models/vae/wanvideo/Wan2_1_VAE_bf16.safetensors \
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_bf16.safetensors"

# --- Text Encoder (~5GB) ---
RUN wget -q --show-progress -O /ComfyUI/models/text_encoders/umt5-xxl-enc-bf16.safetensors \
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-bf16.safetensors"

# --- CLIP Vision (~2GB) ---
RUN wget -q --show-progress -O /ComfyUI/models/clip_vision/clip_vision_h.safetensors \
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors"

# --- Vocal Separator ---
RUN wget -q --show-progress -O /ComfyUI/models/diffusion_models/MelBandRoformer/MelBandRoformer_fp16.safetensors \
    "https://huggingface.co/Kijai/MelBandRoFormer_comfy/resolve/main/MelBandRoformer_fp16.safetensors"

# --- Lightning LoRA ---
RUN wget -q --show-progress -O /ComfyUI/models/loras/WanVideo/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors \
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors"

# =============================================================================
# Startup Configuration
# =============================================================================
WORKDIR /ComfyUI

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose ports: ComfyUI (8188) + VS Code (8080)
EXPOSE 8188 8080

CMD ["/start.sh"]
