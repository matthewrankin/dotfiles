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

# Mac OS X specific settings
if [ ${os_name} == 'Darwin' ]; then
    
    ## TexMate stuff starts here
    if [ -x /Users/matthew/bin/mate ]; then
        export EDITOR='mate -w'
        export GIT_EDITOR='mate -wl1'
        export TEXEDIT='mate -w -l %d "%s"'
        export LC_CTYPE=en_US.UTF-8
    fi
    
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
        export PIP_REQUIRE_VIRTUALENV=true
        export PIP_DOWNLOAD_CACHE=$HOME/.pip_download_cache
    fi
    
    # Enable virtualenvwrapper
    if [ -x ${PY_FW}/${DEFAULT_PY}/bin/virtualenvwrapper.sh ]; then
        source ${PY_FW}/${DEFAULT_PY}/bin/virtualenvwrapper.sh
    fi
    
    ## Ruby stuff starts here
    
    # This loads RVM into a shell session.
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
    # Setup RVM BASH completion
    [[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
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
        source /usr/local/bin/virtualenvwrapper_bashrc
    fi
fi
