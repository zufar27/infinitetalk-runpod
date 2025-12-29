# 🎬 InfiniteTalk ComfyUI

Audio-driven Talking Head Video Generation dengan Wan2.1 + InfiniteTalk.

## ✨ Features
- **InfiniteTalk**: Unlimited-length talking video dari audio + gambar/video
- **ComfyUI**: Node-based workflow interface
- **VS Code**: Built-in code editor untuk customization
- **Pre-loaded Models**: Semua model sudah terinstall, langsung pakai!

---

## 🌐 Access URLs

| Service | Port | URL |
|---------|------|-----|
| **ComfyUI** | 8188 | `https://[POD_ID]-8188.proxy.runpod.net` |
| **VS Code** | 8080 | `https://[POD_ID]-8080.proxy.runpod.net` |
| **SSH** | 22 | `ssh root@[POD_IP] -p [PORT]` |

---

## 📦 Pre-loaded Models (~35GB)

### Wan2.1 Base (480p)
- `wan2.1-i2v-14b-480p-Q8_0.gguf` - GGUF Q8 format
- `wan2.1_i2v_480p_14B_fp8_e4m3fn.safetensors` - fp8 format

### InfiniteTalk
- `Wan2_1-InfiniteTalk_Single_Q8.gguf` - Single speaker
- `Wan2_1-InfiniteTalk-Multi_fp8_e4m3fn_scaled_KJ.safetensors` - Multi speaker

### Supporting Models
- VAE: `Wan2_1_VAE_bf16.safetensors`
- Text Encoder: `umt5-xxl-enc-bf16.safetensors`
- CLIP Vision: `clip_vision_h.safetensors`
- Vocal Separator: `MelBandRoformer_fp16.safetensors`
- Lightning LoRA: `lightx2v_I2V_14B_480p_cfg_step_distill_rank64_bf16.safetensors`

---

## 🚀 Quick Start

1. **Deploy Pod** dengan GPU 24GB+ (RTX 4090, A100, H100)
2. **Buka ComfyUI** via HTTP Port 8188
3. **Import Workflow** dari [InfiniteTalk Repo](https://github.com/MeiGen-AI/InfiniteTalk)
4. **Run!** Semua model sudah ready

---

## 📂 Directory Structure

```
/ComfyUI/
├── models/
│   ├── diffusion_models/WanVideo/        # Base + InfiniteTalk models
│   ├── vae/wanvideo/                      # VAE
│   ├── text_encoders/                     # Text encoder
│   ├── clip_vision/                       # CLIP Vision
│   └── loras/WanVideo/Lightx2v/          # Lightning LoRA
├── custom_nodes/
│   ├── ComfyUI-WanVideoWrapper/          # InfiniteTalk support
│   └── ComfyUI-VideoHelperSuite/         # Video tools
└── output/                                # Generated videos
```

---

## 💡 Tips

- **VRAM Usage**: ~20GB untuk 480p generation
- **Output**: Saved di `/ComfyUI/output/`
- **Persistent Storage**: Mount volume ke `/workspace` untuk save outputs

---

## 🔗 Resources

- [InfiniteTalk GitHub](https://github.com/MeiGen-AI/InfiniteTalk)
- [ComfyUI Docs](https://docs.comfy.org/)
- [Tutorial Video](https://youtu.be/2yeo3D76a4s)

---

*Built by [@zufar27](https://github.com/zufar27)*
