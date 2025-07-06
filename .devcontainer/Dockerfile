FROM ubuntu:22.04

# Basic setup
RUN apt-get update && apt-get install -y \
    git \
    curl \
    sudo \
    locales \
    lsb-release \
    wget \
    build-essential \
    nano \
    zsh \
    libssl-dev \
    zlib1g-dev \
    libncurses-dev \
    libffi-dev \
    libsqlite3-dev \
    libreadline-dev \
    libbz2-dev \
    liblzma-dev \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Install Python from source
ARG PYTHON_VERSION=3.13.3
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar xzf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall && \
    cd .. && rm -rf Python-${PYTHON_VERSION}*

# Set python and pip to point to Python
RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python${PYTHON_VERSION%.*} 1 && \
    update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip${PYTHON_VERSION%.*} 1 && \
    /usr/local/bin/python${PYTHON_VERSION%.*} -m pip install --upgrade pip

# Install Node.js from NodeSource
ARG NODEJS_VERSION=22.x
RUN curl -fsSL https://deb.nodesource.com/setup_${NODEJS_VERSION} | bash - && \
    apt-get install -y nodejs

# Create a non-root user
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set up starship prompt if needed
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Switch to the user
USER $USERNAME
WORKDIR /home/$USERNAME

# --- Copy setup script (does not run during build) ---
COPY --chown=$USERNAME:$USERNAME setup.sh /home/$USERNAME/setup.sh
RUN chmod +x /home/dev/setup.sh

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

# Default command
CMD ["/bin/bash"]
