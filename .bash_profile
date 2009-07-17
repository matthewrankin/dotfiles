# MDR 7/07/08 -- Created this file based off Ubuntu slices.
# ~/.bash_profile: executed by bash(1) for login shells

# Set operating system / kernel name to either 'Darwin' or 'Linux'
os_name=`uname -s`

# Include .bashrc if it exists
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Set PATH so it includes user's private bin if it exists
if [ -d ~/bin ]; then
	PATH=~/bin:"${PATH}"
fi

# .bash_profile settings specific to Mac OS X
if [ $os_name == 'Darwin' ]; then
    # Set EDITOR variables for TextMate
    export EDITOR='mate -w'
    export GIT_EDITOR='mate -wl1'
    export TEXEDIT='mate -w -l %d "%s"'
    export LC_CTYPE=en_US.UTF-8

    # Setting PATH for MacPython 2.6
    PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
    export PATH

    # MDR April 23, 2009: Added for virtualenvwrapper
    export WORKON_HOME=$HOME/.virtualenvs
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    source /Library/Frameworks/Python.framework/Versions/2.6/bin/virtualenvwrapper_bashrc
    
fi
