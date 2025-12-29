# InfiniteTalk ComfyUI - RunPod Template

Ready-to-deploy RunPod template for InfiniteTalk audio-driven talking head video generation.

## Quick Deploy

### Option A: GitHub Actions (Recommended - No Local Download)

1. **Create GitHub repo** and push this folder
2. **Add Docker Hub token**: `Settings > Secrets > Actions > New secret`
   - Name: `DOCKERHUB_TOKEN`
   - Value: Your Docker Hub access token
3. **Push to `main` branch** → Automatically builds and pushes to Docker Hub
4. **Create RunPod template** with `livielx/infinitetalk-comfyui:latest`

### Option B: Local Build
```bash
docker build --platform linux/amd64 -t livielx/infinitetalk-comfyui:latest .
docker push livielx/infinitetalk-comfyui:latest
```

---

## Create RunPod Template

| Setting | Value |
|---------|-------|
| **Container Image** | `livielx/infinitetalk-comfyui:latest` |
| **Container Disk** | 60 GB |
| **HTTP Port** | 8188 (ComfyUI) |

### Deploy Pod
Select GPU with 24GB+ VRAM (RTX 4090, A100, etc.)

---

## Included Models (~35GB)

### Base Models
- `wan2.1-i2v-14b-480p-Q8_0.gguf` (GGUF Q8)
- `wan2.1_i2v_480p_14B_fp8_e4m3fn.safetensors` (fp8)

### InfiniteTalk
- `Wan2_1-InfiniteTalk_Single_Q8.gguf`
- `Wan2_1-InfiniteTalk-Multi_fp8_e4m3fn_scaled_KJ.safetensors`

### Supporting
- VAE, Text Encoder, CLIP Vision, Vocal Separator, Lightning LoRA
