# MDR 7/07/08 -- Created this file (~/.bash_aliases) to contain aliases

# Alias ls to enable color support
if [ "$TERM" != "dumb" ]; then
    if [ $os_name == 'Darwin' ]; then
        alias ls='ls -G'
    elif [ $os_name == 'Linux' ]; then
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
    fi
fi

# Alias ls some more
alias lla='ls -lAF'
alias ll='ls -l'
alias la='ls -AF'
alias l='ls -CF'

alias myaliases='less ~/.bash_aliases'

# Alias cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


# Alias apt-get if the command exists
if which apt-get &> /dev/null; then
    alias agi='sudo apt-get install'
    alias agu='sudo apt-get update'
    alias ags='apt-cache search'
    alias agsh='apt-cache show'
    alias agr='sudo apt-get remove'
    alias agd='sudo apt-get dist-upgrade'
    alias agv='sudo apt-show-versions'
fi

# Alias Django commands (always create these aliases)
alias djdbshell='python manage.py dbshell'
alias djdumpdata='python manage.py dumpdata'
alias djinspectdb='python manage.py inspectdb'
alias djloaddata='python manage.py loaddata'
alias djshell='python manage.py shell'
alias djrunserver='python manage.py runserver'
alias djsqlall='python manage.py sqlall'
alias djstartapp='python manage.py startapp'
alias djstartproject='django-admin.py startproject'
alias djsyncdb='python manage.py syncdb'
alias djvalidate='python manage.py validate'
alias djtest='python manage.py test'
alias djschemamigration='python manage.py schemamigration'
alias djmigrate='python manage.py migrate'
alias djharvest='python manage.py harvest'

# Alias git commands (always create these aliases)
alias gst='git status'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | mate'
alias gau='git add --update'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcotb='git checkout --track -b'
alias glog='git log --oneline --graph'

# Alias Apache2 if the file /etc/init.d/apache2 exists
if [ -f /etc/init.d/apache2 ]; then
    alias a2stop='sudo /etc/init.d/apache2 stop'
    alias a2start='sudo /etc/init.d/apache2 start'
    alias a2restart='sudo /etc/init.d/apache2 restart'
    alias a2reload='sudo /etc/init.d/apache2 reload'
fi

# Alias Postgres 8.2 if the file /etc/init.d/postgresql-8.2 exists
if [ -f /etc/init.d/postgresql-8.2 ]; then
    alias p82stop='sudo /etc/init.d/postgresql-8.2 stop'
    alias p82start='sudo /etc/init.d/postgresql-8.2 start'
    alias p82restart='sudo /etc/init.d/postgresql-8.2 restart'
    alias p82reload='sudo /etc/init.d/postgresql-8.2 reload'
fi

# Alias Postgres 8.3 if the file /etc/init.d/postgresql-8.3 exists
if [ -f /etc/init.d/postgresql-8.3 ]; then
    alias p83stop='sudo /etc/init.d/postgresql-8.3 stop'
    alias p83start='sudo /etc/init.d/postgresql-8.3 start'
    alias p83restart='sudo /etc/init.d/postgresql-8.3 restart'
    alias p83reload='sudo /etc/init.d/postgresql-8.3 reload'
fi

# Alias Postgres 8.4 if the file /etc/init.d/postgresql-8.4 exists
if [ -f /etc/init.d/postgresql-8.4 ]; then
    alias p84stop='sudo /etc/init.d/postgresql-8.4 stop'
    alias p84start='sudo /etc/init.d/postgresql-8.4 start'
    alias p84restart='sudo /etc/init.d/postgresql-8.4 restart'
    alias p84reload='sudo /etc/init.d/postgresql-8.4 reload'
    alias p84dropdb='sudo -u postgres dropdb'
    alias p84createdb='sudo -u postgres createdb'
fi

# Alias Cherokee if the directory /usr/local/cherokee exists
if [ -d /usr/local/cherokee ]; then
    alias cherokee='sudo /usr/local/cherokee/sbin/cherokee'
    alias cherokee-admin='sudo /usr/local/cherokee/sbin/cherokee-admin'
fi
