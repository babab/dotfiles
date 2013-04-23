[ -z "$PS1" ] && return
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=999
HISTFILESIZE=999
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

set -o vi

addtopath()
{
    # Add dirs to $PATH; checks if dir exists and is not already in $PATH
    (test ! "$1" || test ! -d "$1") && return 1
    found=0
    for i in $(echo "${PATH}" | sed 's/:/\n/g'); do
        if [ "$1" == "$i" ]; then
            found=1
        fi
    done
    if [ ${found} -eq 0 ]; then
        export PATH="${PATH}:$1"
    fi
}

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -d "/usr/local/go" ]; then
    export GOROOT=/usr/local/go
    addtopath "$GOROOT/bin"
fi

addtopath "$HOME/bin"
addtopath "/var/lib/gems/1.8/bin"

if [ -x /usr/bin/scrot ] && [ ! -d "$HOME/Pictures/scrot" ]; then
    mkdir -p "$HOME/Pictures/scrot"
    alias wscrot="scrot '$HOME/Pictures/scrot/%s_%Y-%m-%d_\$wx\$h.png'"
fi

# Source prompt settings
. $HOME/.ps1

# Aliases
alias la='ls -FA --color=auto'
ll()
{
    ls -Flh  --color=always "$@" | less -FXRS
}
lla()
{
    ls -FlhA --color=always "$@" | less -FXRS
}
alias ls='ls -F  --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias kk='echo git status && git status'
alias kl='echo git diff && git diff'
alias less='less -FXRS'
alias lk='echo git diff --cached && git diff --cached'
alias rm_migrations='find . -wholename "*/migrations/*" | xargs /bin/rm -f'
alias rm_pyc='find . -name "*.pyc" | xargs /bin/rm -f'
alias rm_vimsession='find . -name ".session.vim" | xargs /bin/rm -f'
alias runmailserver='python -m smtpd -n -c DebuggingServer localhost:1025'
alias sinstall='sudo make install'
alias sshagent='eval `ssh-agent` >/dev/null'
alias x='exit'
alias xx="> $HOME/.bash_history && exit"

# Projectpad aliases
alias gotoproject='cd `projectpad --get`'
alias setproject='projectpad --set && cd `projectpad --get`'

# Environment vars
export EDITOR="/usr/bin/vim"
export PYTHONSTARTUP=~/.pythonrc
export DISPASS_LABELFILE=~/.dispass
export GPG_TTY="$(tty)"
export EXEC_FOR_PYTHON="python2"

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
        echo "Error: not in a Django project folder"
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

# Check date, one of my boxes has a broken clock battery
test $(date +%s) -lt 1366700000 && echo Date is incorrect, fix it!
