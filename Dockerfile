# 使用基础镜像
FROM python:3.10-slim

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制当前目录中的所有文件到工作目录
COPY . /app

# 安装所需的 Python 包
RUN pip install --no-cache-dir torch torchvision torchaudio tensorflow flax
RUN pip install --no-cache-dir git+https://github.com/thammegowda/nllb-serve

# 设置环境变量（如果需要）
ENV SERVER_PORT=7860 \
    OMP_NUM_THREADS=1 \
    CT2_USE_EXPERIMENTAL_PACKED_GEMM=1 \
    CT2_FORCE_CPU_ISA=AVX512 \
    TRANSLATOR_THREADS=4

# 设置容器启动时运行的默认命令
CMD ["nllb-serve"]
