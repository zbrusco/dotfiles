#!/bin/bash

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

# Run /bin/bash
exec "$@"
