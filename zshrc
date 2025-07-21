. "$HOME/.profile"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Plugins
## Load plugin manager
source <(antibody init)

## Setup env var for oh-my-zsh plugins
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle romkatv/powerlevel10k

# Aliases
alias vim="nvim"
alias ncspot="flatpak run io.github.hrkfdn.ncspot"

# Autocompletion
autoload -U compinit && compinit

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '\e[A' history-beginning-search-backward-end
bindkey '\e[B' history-beginning-search-forward-end


# Use open as an alias for xdg-open
open () {
    xdg-open $* > /dev/null 2>&1
}

# Import pywal theme
(cat ~/.cache/wal/sequences &)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Starts ssh-agent
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	echo "Successfully initialized new SSH agent"
	chmod 600 "${SSH_ENV}"
	. "${SSH_ENV}" > /dev/null
	/usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
	. "${SSH_ENV}" > /dev/null
	#ps ${SSH_AGENT_PID} doesn't work under cywgin
	ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
		start_agent;
	}
else
	start_agent;
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/joeri/google-cloud-sdk/path.zsh.inc' ]; then . '/home/joeri/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/joeri/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/joeri/google-cloud-sdk/completion.zsh.inc'; fi
