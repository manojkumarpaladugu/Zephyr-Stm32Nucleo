ARG IMAGE_BASE="ubuntu:24.04"
ARG ZEPHYR_SDK="0.17.0"
ARG ZEPHYR_SOURCE_INSTALL_DIR="/opt/zephyrproject"
ARG ZEPHYR_SDK_INSTALL_DIR="/opt/zephyr-sdk-${ZEPHYR_SDK}"

FROM ${IMAGE_BASE}

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

# Update the system
RUN apt-get update     && \
    apt-get upgrade -y

# Install the packages via apt
RUN apt-get install --no-install-recommends -y   \
    vim                  \
    git                  \
    cmake                \
    ninja-build gperf    \
    ccache               \
    dfu-util             \
    device-tree-compiler \
    wget                 \
    python3-dev          \
    python3-pip          \
    python3-setuptools   \
    python3-tk           \
    python3-wheel        \
    python3-venv         \
    xz-utils             \
    file                 \
    build-essential      \
    libsdl2-dev          \
    libmagic1

# Create python virtual environment
ARG ZEPHYR_SOURCE_INSTALL_DIR
RUN python3 -m venv ${ZEPHYR_SOURCE_INSTALL_DIR}/.venv
ENV VIRTUAL_ENV ${ZEPHYR_SOURCE_INSTALL_DIR}/.venv
ENV PATH ${ZEPHYR_SOURCE_INSTALL_DIR}/.venv/bin:$PATH

# Install the packages via pip
RUN pip install pre-commit west patool

# Install the zephyr source code
WORKDIR ${ZEPHYR_SOURCE_INSTALL_DIR}
RUN west init .                                      && \
    west update                                      && \
    west zephyr-export                               && \
    pip install -r ./zephyr/scripts/requirements.txt

# Install the Zephyr SDK
ARG ZEPHYR_SDK
RUN wget "https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZEPHYR_SDK}/zephyr-sdk-${ZEPHYR_SDK}_linux-x86_64_minimal.tar.xz" && \
    tar xvf zephyr-sdk-${ZEPHYR_SDK}_linux-x86_64_minimal.tar.xz -C /opt                                                                      && \
    rm -f zephyr-sdk-${ZEPHYR_SDK}_linux-x86_64_minimal.tar.xz

ARG ZEPHYR_SDK_INSTALL_DIR
WORKDIR ${ZEPHYR_SDK_INSTALL_DIR}
RUN ./setup.sh -t aarch64-zephyr-elf && \
    ./setup.sh -t arm-zephyr-eabi    && \
    ./setup.sh -t x86_64-zephyr-elf  && \
    ./setup.sh -h -c

# Install QEMU
RUN apt-get install -y qemu-system-arm
