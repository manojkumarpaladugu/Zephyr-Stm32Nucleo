ARG IMAGE_BASE="ubuntu:24.04"
ARG ZEPHYR_SDK="0.17.0"

FROM ${IMAGE_BASE}

ARG DEBIAN_FRONTEND=noninteractive

# Update the system
RUN apt-get update     && \
    apt-get upgrade -y

# Install packages via apt
RUN apt-get install -y   \
    vim                  \
    wget                 \
    git                  \
    ninja-build gperf    \
    ccache               \
    dfu-util             \
    device-tree-compiler \
    python3-dev          \
    python3-pip          \
    python3-setuptools   \
    python3-tk           \
    python3-wheel        \
    pipx                 \
    xz-utils             \
    file                 \
    make                 \
    gcc                  \
    gcc-multilib         \
    g++-multilib         \
    libsdl2-dev          \
    libmagic1

# Install packages via pip
RUN pipx install pre-commit cmake west patool

# Update environment variable
ENV PATH="/root/.local/bin:$PATH"

# Get the zephyr source code
RUN west init ~/zephyrproject && \
    cd ~/zephyrproject        && \
    west update

# Install Zephyr SDK
ARG ZEPHYR_SDK
# 1. Download Zephyr SDK
RUN wget "https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZEPHYR_SDK}/zephyr-sdk-${ZEPHYR_SDK}_linux-x86_64_minimal.tar.xz"
# 2. Extract Zephyr SDK
RUN tar xvf zephyr-sdk-${ZEPHYR_SDK}_linux-x86_64_minimal.tar.xz -C /opt
# 3. Run the zephyr SDK bundle setup script
RUN /opt/zephyr-sdk-${ZEPHYR_SDK}/setup.sh -t all -h -c
RUN rm -f zephyr-sdk-${ZEPHYR_SDK}_linux-x86_64_minimal.tar.xz
