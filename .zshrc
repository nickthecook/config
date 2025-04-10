# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Created by newuser for 5.9
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# zinit plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# zinit snippets
#zinit snippet OMZP::git
#zinit snippet OMZP::sudo
#zinit snippet OMZP::command-not-found

autoload -U compinit && compinit -u

#zinit cdreplay -q

## CUSTOM

# bindings
#bindkey '^[[5~' history-search-backward
#bindkey '^[[6~' history-search-forward
bindkey '[1;5C' forward-word
bindkey '[1;5D' backward-word

# bind PgUp and PgDown to history-based completion
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "[5~" up-line-or-beginning-search # Up
bindkey "[6~" down-line-or-beginning-search # Down
#bindkey "	" complete-word

# history
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no-select
#zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zinit light Aloxaf/fzf-tab

# aliases
alias ls="ls --color"
alias ll="ls -lh"
alias la="ls -a"
alias grep="grep --color=auto"

# shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# this causes infinite recursion in the cd command
#eval "$(zoxide init --cmd cd zsh)"

## custom
#
DEFAULT_USER=nickthecook

export EJSON_KEYDIR="$HOME/.ejson"

export PATH="$HOME/bin:/home/linuxbrew/.linuxbrew/bin:$PATH:/opt/android-platform-tools"

alias dev="ops -f ~/src/ops.yml"
alias rmtly="ops -f ~/src/rmtly/ops.yml"
alias rails="ops rails"
alias docker=podman

# python
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PATH="$PATH:$HOME/versions/3.7.7/bin"

source "$HOME/.ruby.zsh"

export THOR_MERGE="code -d $1 $2"
export EDITOR="vim"
# end custom

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#source "$HOME/.cargo/env"
## end custom

fpath+=${ZDOTDIR:-~}/.zsh_functions

eval "$(starship init zsh)"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

