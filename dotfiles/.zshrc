# ~/.zhsrc - interactive shell
# Copyright (c) 2021 Matthew Rankin. All rights reserved.
# Project site: https://github.com/matthewrankin/dotfiles
# Use of this source code is governed by a MIT-style license that
# can be found in the LICENSE file for the project.

################################
##### OS Agnostic Settings #####
################################

# shell options
setopt autocd
setopt nocaseglob

# Setup aliases
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# history file
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=20000
HISTSIZE=50000

# Setup the path
path+=~/bin

### Add Go
export GOPATH=$HOME/development/go
path+="$GOPATH/bin"

#######################
##### Completions #####
#######################
zstyle :compinstall filename '/Users/matthew/.zshrc'

# load zsh completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# load bashcompinit for some old bash completions 
autoload bashcompinit && bashcompinit
[[ -r ~/Projects/autopkg_complete/autopkg ]] && source ~/Projects/autopkg_complete/autopkg 

# case insensitive path-completion 
zstyle ':completion:*' matcher-list \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
  'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

############################
##### Configure Prompt #####
############################
eval "$(starship init zsh)"

################################
##### OS Agnostic Settings #####
################################

# Load nvm if it exists
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

###################################
##### macOS Specific Settings #####
###################################
case $(uname) in
  Darwin)
    # Add fuzzy finder.
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

    PATH="/usr/local/sbin:$PATH"
    PATH="$HOME/.luarocks/bin:$PATH"

    # Setup gmake as make
    PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

    ## Python stuff starts here
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
esac

# Set the editor to vim regardless of OS
export EDITOR='vim'
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

[ -f "/Users/matthew/.ghcup/env" ] && source "/Users/matthew/.ghcup/env" # ghcup-env
