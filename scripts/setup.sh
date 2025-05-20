#!/bin/bash
# Setup script for dotfiles

# Create symlinks
echo "Setting up dotfiles..."

# Symlink .bashrc
ln -sf ~/dotfiles/.bashrc ~/.bashrc

# Symlink .gitconfig
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

echo "Setup complete"

# Source bashrc to apply changes
source ~/.bashrc
