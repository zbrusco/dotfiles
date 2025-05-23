#!/bin/bash
set -e

PROJECTS_DIR="${HOME:-/home/$USER}/projects"
PYTHON_BIN=$(which python)
PIP_BIN=$(which pip)

# === Python Projects ===
echo "Searching for Python dependencies..."
find "$PROJECTS_DIR" -type f -name "requirements.txt" | while read -r reqfile; do
    echo "Installing Python packages from $reqfile"
    sudo $PIP_BIN install -r "$reqfile"
done

# === Node.js Projects ===
echo "Searching for Node.js dependencies..."
find "$PROJECTS_DIR" -type f -name "package.json" | while read -r packagefile; do
    projdir=$(dirname "$packagefile")
    echo "Installing Node packages in $projdir"
    (cd "$projdir" && npm install)
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
