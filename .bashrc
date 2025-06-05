# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# === History ===
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# === Bash Options ===
# Enable case-insensitive tab completion
bind "set completion-ignore-case on"
# Update window size after each command
shopt -s checkwinsize

# === Prompt ===
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
else
    # Fallback PS1
    export PS1="\u:\w \$ "
fi

# === Aliases ===
alias rm="rm -i"
alias purge="rm -ri"
alias ..="cd .."
alias ...="cd ../.."

# === WSL Integration ===
export BROWSER="wslview"
alias explorer='explorer.exe'
alias code='code'
if command -v clip.exe >/dev/null 2>&1; then
    alias pbcopy='clip.exe'
    alias pbpaste='powershell.exe -command "Get-Clipboard"'
fi
[[ "$PWD" == "/mnt/c/Windows/System32" ]] && cd ~/projects

# === PATHs ===
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# === Git Config ===
[[ -f ~/.gitconfig.local ]] && git config --global include.path ~/.gitconfig.local

# === Environment ===
export EDITOR=nvim
export VISUAL=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# === Completion ===
if ! shopt -oq posix; then
  [[ -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion
fi

# echo "WSL Ubuntu $(lsb_release -rs)!"
