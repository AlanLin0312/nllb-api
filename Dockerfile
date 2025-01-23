# 使用 nllb-api 作为基础镜像
FROM ghcr.io/winstxnhdw/nllb-api:main

# 设置环境变量
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

RUN pip install --no-cache-dir git+https://github.com/thammegowda/nllb-serve

RUN echo $PATH

# 设置容器启动时运行的默认命令
CMD ["nllb-serve"]

