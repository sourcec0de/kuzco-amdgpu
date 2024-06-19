FROM ubuntu:22.04

# Prevents interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update -y 
RUN apt upgrade -y 
RUN apt install -y \
    wget \
    gnupg2 \
    lsb-release \
    software-properties-common \
    build-essential \
    g++ \
    make \
    libelf1 \
    kmod \
    file \
    curl \
    python3-dev \
    python3-pip

# download amd installer packages
RUN wget https://repo.radeon.com/amdgpu-install/6.1.3/ubuntu/jammy/amdgpu-install_6.1.60103-1_all.deb
RUN apt install -y ./amdgpu-install_6.1.60103-1_all.deb

# install kernal drivers and rocm
RUN amdgpu-install -y --usecase=dkms,rocm

# Set up environment variables for ROCm
ENV PATH="/opt/rocm/bin:${PATH}"
ENV LD_LIBRARY_PATH="/opt/rocm/lib:${LD_LIBRARY_PATH}"
ENV ROCM_PATH="/opt/rocm"

# Determine the architecture
# TODO: read this from docker
ARG ARCH="amd64"
ARG BUCKET_URL="https://sg.kuzco.xyz"
ARG CLI_VERSION="0.0.6-32e10a8"

# Download and install the Kuzco CLI
RUN curl --fail --show-error --location --progress-bar -o ./kuzco "${BUCKET_URL}/cli/release/${ARCH}/kuzco-linux-${ARCH}-${CLI_VERSION}"
RUN curl --fail --show-error --location --progress-bar -o ./kuzco-runtime "${BUCKET_URL}/cli/runtime/${ARCH}/kuzco-runtime-linux-${ARCH}-${CLI_VERSION}"
RUN install -o0 -g0 -m755 ./kuzco /usr/local/bin/kuzco
RUN install -o0 -g0 -m755 ./kuzco-runtime /usr/local/bin/kuzco-runtime

# Verify installation (optional)
RUN kuzco --version
