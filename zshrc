# Plugins
## Load plugin manager
source <(antibody init)

## Setup env var for oh-my-zsh plugins
antibody bundle ohmyzsh/ohmyzsh
antibody bundle ohmyzsh/ohmyzsh path:plugins/cp
antibody bundle ohmyzsh/ohmyzsh path:plugins/git
antibody bundle ohmyzsh/ohmyzsh path:plugins/npm
antibody bundle ohmyzsh/ohmyzsh path:plugins/nvm
antibody bundle ohmyzsh/ohmyzsh path:plugins/ssh-agent
antibody bundle ohmyzsh/ohmyzsh path:plugins/vi-mode
antibody bundle ohmyzsh/ohmyzsh path:plugins/z
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle dracula/zsh

# Plugin config
zstyle :omz:plugins:ssh-agent quiet yes

# Configuration
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Aliases
alias vim="nvim"

# Open vim with z argument
v() {
    if [ -n "$1" ]; then
        z $1
    fi

    nvim
}

# Use open as an alias for xdg-open
open () {
    xdg-open $* > /dev/null 2>&1
}

# pnpm
export PNPM_HOME="/home/joeri/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
