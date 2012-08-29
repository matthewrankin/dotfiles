# ~/.bash_profile: executed by bash(1) for login shells
#
# Created by Matthew D. Rankin
# Copyright (c) 2010 Matthew D. Rankin. All rights reserved.

# Determine the operating system (used in bashrc)
os_name=`uname -s`

# Include the non-login shell settings
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Add the user's bin to the PATH
if [ -d ~/bin ]; then
    PATH=~/bin:"${PATH}"
fi

# Add /usr/local/bin and ./sbin to $PATH since OS X 10.6 adds
# /usr/local/bin after /usr/bin
PATH=/usr/local/bin:/usr/local/sbin:"${PATH}"

# Set the editor to vim regardless of OS
export EDITOR='vim'

# Mac OS X specific settings
if [ ${os_name} == 'Darwin' ]; then
    ## Python stuff starts here
    
    # The last Python added to PATH will be the default Python
    PY_VER=( '3.1' '2.6' '2.7')
    PY_VER_ELEMENTS=${#PY_VER[@]}
    DEFAULT_PY=${PY_VER[${PY_VER_ELEMENTS}-1]}
    PY_FW="/Library/Frameworks/Python.framework/Versions"
    
    for (( i=0;i<$PY_VER_ELEMENTS;i++)); do
        if [ -x ${PY_FW}/${PY_VER[${i}]}/bin/python${PY_VER[${i}]} ]; then
            PATH="${PY_FW}/${PY_VER[${i}]}/bin:${PATH}"
            export PATH
        fi
    done
    
    # Check for virtualenv in the default Python
    if [ -x ${PY_FW}/${DEFAULT_PY}/bin/virtualenv ]; then
        export VIRTUALENV_USE_DISTRIBUTE=true
        export WORKON_HOME=$HOME/.virtualenvs
    fi
    
    # Check for pip
    if [ -x ${PY_FW}/${DEFAULT_PY}/bin/pip ]; then
        export PIP_VIRTUALENV_BASE=$WORKON_HOME
        export PIP_REQUIRE_VIRTUALENV=false
        export PIP_DOWNLOAD_CACHE=$HOME/.pip_download_cache
    fi
    
    # Enable virtualenvwrapper
    if [ -x ${PY_FW}/${DEFAULT_PY}/bin/virtualenvwrapper.sh ]; then
        . ${PY_FW}/${DEFAULT_PY}/bin/virtualenvwrapper.sh
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

    ## Node.js stuff starts here
    if [ -x /usr/local/bin/node ]; then
      export NODE_PATH=/usr/local/lib/node_modules
    fi
fi

# Linux specific settings
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

