export PATH="$HOME/.local/bin:$PATH"
export NOTES="$HOME/Notes"
export DOTFILES="$HOME/.dotfiles"
export EDITOR="nvim"

. "$HOME/.cargo/env"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
