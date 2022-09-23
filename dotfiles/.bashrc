# ~/.bashrc: executed by bash(1) for non-login shells.
#
# Created by Matthew D. Rankin
# Copyright (c) 2010-2019 Matthew D. Rankin. All rights reserved.

################################
##### OS Agnostic Settings #####
################################

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Setup tmuxinator if it exists
if [ -f "${HOME}/.bin/tmuxinator.bash" ]; then
  . "${HOME}/.bin/tmuxinator.bash"
fi

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  PS1='\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w\[\e[m\]\n» '
  alias nvim='echo "No nesting!"'
fi

# Load nvm if it exists
export NVM_DIR="${HOME}/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

##################################
##### OS X Specific Settings #####
##################################
if [ "${os_name}" = 'Darwin' ]; then

  # Set the command prompt
  if [ -n "$PS1" ]; then
    PS1='\[\e[01;32m\]\u@\h\[\e[m\]:\[\e[01;34m\]\w\[\e[m\]\n$ '
  fi

  # Add fuzzy finder.
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash

  # Setup IBM Cloud CLI autocomplete if available.
  if [ -f /usr/local/ibmcloud/autocomplete/bash_autocomplete ]; then
    source /usr/local/ibmcloud/autocomplete/bash_autocomplete
  fi

###################################
##### Linux Specific Settings #####
###################################
elif [ "${os_name}" = 'Linux' ]; then
  # ~/.bashrc: executed by bash(1) for non-login shells.
  # see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
  # for examples

  # If not running interactively, don't do anything
  [ -z "$PS1" ] && return

  # don't put duplicate lines in the history. See bash(1) for more options
  export HISTCONTROL=ignoredups

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # make less more friendly for non-text input files, see lesspipe(1)[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
  fi

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
  xterm-color|xterm-256color)
      PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
      ;;
    *)
      PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
      ;;
  esac

  PATH=/usr/local/pgsql/bin:$PATH

  # Comment in the above and uncomment this below for a color prompt
  #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm*|rxvt*)
      PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
      ;;
  *)
      ;;
  esac

  # FIXME(mdr): Should check to see if Go is intalled
  PATH=$PATH:/usr/local/go/bin

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi

fi
#######################################
##### End of OS Specific Settings #####
#######################################

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/matthew/.nvm/versions/node/v10.15.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /Users/matthew/.nvm/versions/node/v10.15.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/matthew/.nvm/versions/node/v10.15.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /Users/matthew/.nvm/versions/node/v10.15.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Users/matthew/.nvm/versions/node/v10.15.3/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /Users/matthew/.nvm/versions/node/v10.15.3/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash
alias ic="ibmcloud"
