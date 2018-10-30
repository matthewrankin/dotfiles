# ~/.bash_profile: executed by bash(2) for login shells
#
# Created by Matthew D. Rankin
# Copyright (c) 2010-2018 Matthew D. Rankin. All rights reserved.

################################
##### OS Agnostic Settings #####
################################

# Determine the operating system (used in bashrc)
os_name=`uname -s`

# Ensure user-install binaries take precedence
export PATH=/usr/local/bin:$PATH

# Include the non-login shell settings if running bash
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
  fi
fi

# Add the user's bin to the PATH if dir exists.
[ -d "$HOME/bin" ] && PATH="$HOME/bin:${PATH}"

# Set the editor to vim regardless of OS
export EDITOR='vim'

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

if [ ${os_name} == 'Darwin' ]; then

    ## Python stuff starts here
    PY_DIR="$(brew --prefix)/bin"

    # Enable virtualenvwrapper
    if [ -x ${PY_DIR}/virtualenvwrapper.sh ]; then
      export VIRTUALENVWRAPPER_PYTHON=${PY_DIR}/python3
      export WORKON_HOME=$HOME/.virtualenvs
      if [ -x ${PY_DIR}/pip ]; then
        export PIP_VIRTUALENV_BASE=$WORKON_HOME
      fi
      . ${PY_DIR}/virtualenvwrapper.sh
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
    # export PIP_REQUIRE_VIRTUALENV=true
    . /usr/local/bin/virtualenvwrapper.sh
  fi
fi
