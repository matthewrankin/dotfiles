# ~/.bash_profile: executed by bash(2) for login shells
#
# Created by Matthew D. Rankin
# Copyright (c) 2010-2018 Matthew D. Rankin. All rights reserved.

################################
##### OS Agnostic Settings #####
################################

# Determine the operating system (used in bashrc)
os_name=`uname -s`

# Include the non-login shell settings if running bash
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
  fi
fi

# Add the user's bin to the PATH if dir exists and it's not already on the path.
[ -d "$HOME/bin" ] && [[ ":$PATH:" != *":$HOME/bin:"* ]] && PATH="$HOME/bin:${PATH}"

# Set the editor to vim regardless of OS
export EDITOR='vim'

# Set Vim and Neovim variables
# TODO(mdr): I should probably check to see if Vim and Neovim exist prior to
# doing this.
export VIMCONFIG=~/.vim
export VIMDATA=~/.vim
export NVIMCONFIG=~/.config/nvim
export NVIMDATA=~/.local/share/nvim

### Add Go
export GOPATH=$HOME/development/go
PATH="$GOPATH/bin:$PATH"

## Ruby stuff starts here
# If RVM is installed, load it into a shell session
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  . "$HOME/.rvm/scripts/rvm"
  # Setup RVM BASH completion
  if [[ -r $rvm_path/scripts/completion ]]; then
    . $rvm_path/scripts/completion
  fi
fi

##################################
##### OS X Specific Settings #####
##################################

# Note: OS X Terminal.app runs a login shell by default
# (i.e., shells open with the default login shell (/usr/bin/login)
# Also, the paths found in /etc/paths are added by /etc/profile.

if [ ${os_name} == 'Darwin' ]; then

  PATH="/usr/local/sbin:$PATH"

  # Enable bash completion per Homebrew
  [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

  ## Python stuff starts here
  py_bin_dir="$(brew --prefix)/bin"

  # Enable virtualenvwrapper
  if [ -x ${py_bin_dir}/virtualenvwrapper.sh ]; then
    export VIRTUALENVWRAPPER_PYTHON=${py_bin_dir}/python3
    export WORKON_HOME=$HOME/.virtualenvs
    if [ -x ${py_bin_dir}/pip ]; then
      export PIP_VIRTUALENV_BASE=$WORKON_HOME
    fi
    . ${py_bin_dir}/virtualenvwrapper.sh
  else
    echo "WARNING: Can't find virtualenvwrapper"
  fi
fi

###################################
##### Linux Specific Settings #####
###################################
if [ ${os_name} == 'Linux' ]; then
  # Enable virtualenvwrapper
  if [ -x /usr/local/bin/virtualenvwrapper.sh ]; then
    if [ ! -d $HOME/.virtualenvs ]; then
      mkdir $HOME/.virtualenvs
    fi
    export WORKON_HOME=$HOME/.virtualenvs
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    . /usr/local/bin/virtualenvwrapper.sh
  fi
fi
#######################################
##### End of OS Specific Settings #####
#######################################
