# ~/.bash_profile: executed by bash(2) for login shells
#
# Created by Matthew D. Rankin
# Copyright (c) 2010 Matthew D. Rankin. All rights reserved.

################################
##### OS Agnostic Settings #####
################################

# Determine the operating system (used in bashrc)
os_name=`uname -s`

# Include the non-login shell settings if brunning bash
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
  fi
fi

# Add the user's bin to the PATH
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:${PATH}"
fi

# TODO(mdr): Is this just an OS X issue with /usr/local/bin?
# If so, move this to the OS X Specific Settings
# Add /usr/local/bin and ./sbin to $PATH since OS X adds
# /usr/local/bin after /usr/bin
export PATH=/usr/local/bin:/usr/local/sbin:"${PATH}"

# Set the editor to vim regardless of OS
export EDITOR='vim'

# If NVM is installed, load it
# Grabbed from https://github.com/startup-class/dotfiles
if [ -s ~/.nvm/nvm.sh ]; then
  NVM_DIR = ~/.nvm
  source ~/.nvm/nvm.sh
  nvm use v0.10.12 &> /dev/null # silence nvm use; needed for rsync
fi

##################################
##### OS X Specific Settings #####
##################################

# Note: OS X Terminal.app runs a login shell by default
# (i.e., shells open with the default login shell (/usr/bin/login)

if [ ${os_name} == 'Darwin' ]; then
    ## Python stuff starts here
    # Note: 29-Aug-12. I'm no longer installing mupltiple versions
    # of Python using the python.org DMGs. Instead, I installed
    # python 2.7.3 using homebrew.
    # Homebrew Python changed and is no longer using /usr/local/share/python
    # Homebrew is now installing to /usr/local/bin
    PY_INSTALL_SCRIPTS_DIR="$(brew --prefix)/bin"
    #PY_INSTALL_SCRIPTS_DIR="/usr/local/share/python"
    #export PATH="${PY_INSTALL_SCRIPTS_DIR}":"${PATH}"
    #export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

    # Check for pip
    if [ -x ${PY_INSTALL_SCRIPTS_DIR}/pip ]; then
        export PIP_VIRTUALENV_BASE=$WORKON_HOME
        export PIP_REQUIRE_VIRTUALENV=false
        export PIP_DOWNLOAD_CACHE=$HOME/.pip_download_cache
    else
      echo "WARNING: Can't find pip"
    fi

    # Check for virtualenv in the default Python
    if [ -x ${PY_INSTALL_SCRIPTS_DIR}/virtualenv ]; then
        export VIRTUALENV_USE_DISTRIBUTE=true
        export WORKON_HOME=$HOME/.virtualenvs
    else
      echo "WARNING: Can't find virtualenv"
    fi

    # Enable virtualenvwrapper
    if [ -x ${PY_INSTALL_SCRIPTS_DIR}/virtualenvwrapper.sh ]; then
        . ${PY_INSTALL_SCRIPTS_DIR}/virtualenvwrapper.sh
    else
      echo "WARNING: Can't find virtualenvwrapper"
    fi

    ## Ruby stuff starts here
    # If RVM is installed, load it into a shell session
    if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
        . "$HOME/.rvm/scripts/rvm"
        # Setup RVM BASH completion
        if [[ -r $rvm_path/scripts/completion ]]; then
            . $rvm_path/scripts/completion
        fi
    fi

    # Since this uses the rvm command it needs to come
    # after rvm is started
    # FIXME: Not sure why this is failing.
    #[[ -s "`rvm gemdir`/bin/tmuxinator_completion" ]] &&
      #source "`rvm gemdir`/bin/tmuxinator_completion"

    ## Node.js stuff starts here
    if [ -x /usr/local/bin/node ]; then
      export NODE_PATH=/usr/local/lib/node_modules
      export PATH=/usr/local/share/npm/bin:"${PATH}"
    fi
fi

###################################
##### Linux Specific Settings #####
###################################
if [ ${os_name} == 'Linux' ]; then
    # Enable virtualenvwrapper
    if [ -x /usr/local/bin/virtualenvwrapper_bashrc ]; then
        if [ ! -d $HOME/.virtualenvs ]; then
            mkdir $HOME/.virtualenvs
        fi
        export WORKON_HOME=$HOME/.virtualenvs
        export PIP_VIRTUALENV_BASE=$WORKON_HOME
        # export PIP_REQUIRE_VIRTUALENV=true
        . /usr/local/bin/virtualenvwrapper_bashrc
    fi
fi

