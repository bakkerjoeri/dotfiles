export PATH="$HOME/.local/bin:$PATH"
export NOTES="$HOME/Notes"
export DOTFILES="$HOME/.dotfiles"
export EDITOR="nvim"

. "$HOME/.cargo/env"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_AVD_HOME=$HOME/.var/app/com.google.AndroidStudio/config/.android/avd
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tool
