#!/bin/bash
set -e

PROJECTS_DIR="${HOME:-/home/$USER}/projects"
PYTHON_BIN=$(which python)
PIP_BIN=$(which pip)

# === Python Projects ===
echo "Searching for Python dependencies..."
mapfile -t requirements_files < <(find "$PROJECTS_DIR" -type f -name "requirements.txt")
for reqfile in "${requirements_files[@]}"; do
    echo "Installing Python packages from $reqfile"
    sudo $PIP_BIN install -r "$reqfile"
done

# === Node.js Projects ===
echo "Searching for Node.js dependencies..."
mapfile -t package_files < <(find "$PROJECTS_DIR" -type f -name "package.json")
for package_file in "${package_files[@]}"; do
    package_dir=$(dirname "$package_file")
    echo "Installing Node.js packages from $package_file"
    npm install --prefix "$package_dir"
done

# Symlink dotfiles from ~/dotfiles to home directory
DOTFILES_DIR="$HOME/dotfiles"
dotfiles=(.bashrc .bash_profile .gitconfig .config .vscode)

for file in "${dotfiles[@]}"; do
    target="$HOME/$file"
    source="$DOTFILES_DIR/$file"

    if [ -e "$target" ] || [ -L "$target" ]; then
        rm -rf "$target"
    fi

    if [ -e "$source" ]; then
        ln -s "$source" "$target"
    fi
done

source ~/.bashrc
