# 使用 Python 基础镜像
FROM python:3.9-slim

# 设置 PYTHONPATH
ENV PYTHONPATH="/your/custom/path"

# 设置其他环境变量
ENV SERVER_PORT=7860 \
    OMP_NUM_THREADS=1 \
    CT2_USE_EXPERIMENTAL_PACKED_GEMM=1 \
    CT2_FORCE_CPU_ISA=AVX512 \
    TRANSLATOR_THREADS=4

# 安装 PyTorch、TensorFlow 和 Flax
RUN pip install --no-cache-dir torch torchvision torchaudio tensorflow flax

# 设置工作目录
WORKDIR /app

# 复制当前目录中的所有文件到工作目录
COPY . /app

# 安装 nllb-serve
RUN pip install --no-cache-dir git+https://github.com/thammegowda/nllb-serve

# 检查 PATH（可选）
RUN echo $PATH

# 设置容器启动时运行的默认命令

