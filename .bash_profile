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
    # Set EDITOR variables for TextMate if TextMate is installed
    if [ -x /Users/matthew/bin/mate ]; then
        export EDITOR='mate -w'
        export GIT_EDITOR='mate -wl1'
        export TEXEDIT='mate -w -l %d "%s"'
        export LC_CTYPE=en_US.UTF-8
    fi
    
    # Set PATH for MacPython 2.6 if Python2.6 is installed
    if [ -x /Library/Frameworks/Python.framework/Versions/2.6/bin/python2.6 ]; then
        PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
        export PATH
    fi
    
    # MDR April 23, 2009: Added for virtualenvwrapper
    if [ -x /Library/Frameworks/Python.framework/Versions/2.6/bin/virtualenvwrapper_bashrc ]; then
        export WORKON_HOME=$HOME/.virtualenvs
        export PIP_VIRTUALENV_BASE=$WORKON_HOME
        export PIP_REQUIRE_VIRTUALENV=true
        source /Library/Frameworks/Python.framework/Versions/2.6/bin/virtualenvwrapper_bashrc
    fi
    
    # Set PYTHONPATH if Mercurial is installed
    if [ -d /usr/local/lib/python2.6/site-packages/mercurial ]; then
        export PYTHONPATH=/usr/local/lib/python2.6/site-packages:${PYTHONPATH}
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
