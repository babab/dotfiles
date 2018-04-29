[ -z "$PS1" ] && return
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=999
HISTFILESIZE=999
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

set -o vi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -d "/usr/local/go" ]; then
    export GOROOT=/usr/local/go
fi

if [ -x /usr/bin/scrot ]; then
    if [ ! -d "$HOME/Pictures/scrot" ]; then
        mkdir -p "$HOME/Pictures/scrot"
    fi
    alias wscrot="scrot '$HOME/Pictures/scrot/%s_%Y-%m-%d_\$wx\$h.png'"
fi

# Source prompt settings
. $HOME/.ps1

# Source aliases
. $HOME/.aliases

# Source environment variables
. $HOME/.profile

# Wrapper for starting the Django development server on varying
# addresses and port numbers. Allowing to also run if manage.py is in
# the (parent directory of a) parent directory of $PWD.
# Usage: runserver [port number=8000] [listening address=127.0.0.1]
runserver()
{
    startdjangoserver()
    {
        find . -name "*.pyc" | xargs /bin/rm -f
        if [ ! "$1" ]; then
            portn="8000"
        else
            portn="$1"
        fi
        if [ ! "$2" ]; then
            addr="127.0.0.1"
        else
            addr="$2"
        fi
        ${EXEC_FOR_PYTHON} manage.py runserver ${addr}:${portn}
    }

    if [ -f "$PWD/manage.py" ]; then
        startdjangoserver "$1" "$2"
    elif [ -f "$PWD/../manage.py" ]; then
        cd ..
        echo "runserver: changed directory to $PWD"
        startdjangoserver "$1" "$2"
    elif [ -f "$PWD/../../manage.py" ]; then
        cd ../..
        echo "runserver: changed directory to $PWD"
        startdjangoserver "$1" "$2"
    else
        echo "Not in a Django project folder, using python -m http.server"
        python3 -m http.server
    fi
}

# Wrapper for sourcing and protecting vim session
svim()
{
    if [ -f "$PWD/.session.vim" ]; then
        if [ -f "/tmp/$USER.vimsession" ]; then
            echo Vim session already started
        else
            touch /tmp/$USER.vimsession
            vim -S .session.vim
            rm /tmp/$USER.vimsession
        fi
    else
        echo No .session.vim file found
    fi
}

# Bash completion for custom functions and scripts
complete -d ll
complete -d lla
complete -ac xs
complete -ac loop

# Source local settings and overrides
if [ -f "$HOME/.bashrc.local" ]; then
    . ${HOME}/.bashrc.local
fi
