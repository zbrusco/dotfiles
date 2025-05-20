FROM ubuntu:24.04

# Basic setup
RUN apt-get update && apt-get install -y \
    git \
    curl \
    sudo \
    wget \
    build-essential \
    nodejs \
    npm \
    python3 \
    python3-pip \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

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

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

# Default command
CMD ["/bin/bash"]
