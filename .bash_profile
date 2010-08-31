# ~/.bash_profile: executed by bash(1) for login shells
#
# Created by Matthew D. Rankin
# Copyright (c) 2010 Matthew D. Rankin. All rights reserved.

# Set operating system / kernel name to either 'Darwin' or 'Linux'
os_name=`uname -s`

# Include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Add the user's private bin to PATH if it exists
if [ -d ~/bin ]; then
    PATH=~/bin:"${PATH}"
fi

# .bash_profile settings specific to Mac OS X
if [ $os_name == 'Darwin' ]; then
    
    # Set EDITOR variables for TextMate if TextMate is installed
    if [ -x /Users/matthew/bin/mate ]; then
        export EDITOR='mate -w'
        export GIT_EDITOR='mate -wl1'
        export TEXEDIT='mate -w -l %d "%s"'
        export LC_CTYPE=en_US.UTF-8
    fi
    
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
        export PIP_DOWNLOAD_CAHCE=$HOME/.pip_download_cache        
    fi
    
    # Enable virtualenvwrapper
    if [ -x ${PY_FW}/${DEFAULT_PY}/bin/virtualenvwrapper.sh ]; then
        source ${PY_FW}/2.7/bin/virtualenvwrapper.sh
    fi

fi # end if [ $os_name == 'Darwin' ]; then

# .bash_profile settings specific to Linux
if [ $os_name == 'Linux' ]; then
    # MDR 28-Feb-10: Added for virtualenvwrapper
    # TODO 28-Feb-10: Change this such that it checks to see if ~/.virtualenvs
    # exists and if not to create it.
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
# end if os_name Linux'

