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

if [ -d "$HOME/bin" ]; then
    PATH="$PATH:$HOME/bin"
fi
if [ -d "/var/lib/gems/1.8/bin" ]; then
    PATH="$PATH:/var/lib/gems/1.8/bin"
fi

if [ -x /usr/bin/scrot ] && [ ! -d "$HOME/Pictures/scrot" ]; then
    mkdir -p "$HOME/Pictures/scrot"
fi

. $HOME/.ps1

# Quick shortcuts
alias ls='/bin/ls -F  --color=auto'
alias la='/bin/ls -FA --color=auto'
ll()
{
    ls -Flh  --color=always "$@" | less -FXRS
}
lla()
{
    ls -FlhA --color=always "$@" | less -FXRS
}
alias llgrep='find | grep'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias x='exit'
alias xx="> $HOME/.bash_history && exit"
alias kk='echo git status && git status'
alias kl='echo git diff && git diff'
alias lk='echo git diff --cached && git diff --cached'
alias vv='ranger'

# Setting default flags
alias less='less -FXRS'
alias sshagent='eval `ssh-agent` >/dev/null'

# Custom aliases
alias startenv_myaethon2='. ~/.virtualenv/myaethon2/bin/activate'
alias openboxwindowinfo='obxprop | grep "^_OB_APP"'
alias rm_pyc='find . -name "*.pyc" | xargs /bin/rm -f'
alias rm_migrations='find . -wholename "*/migrations/*" | xargs /bin/rm -f'
alias runserver='find . -name "*.pyc" | xargs /bin/rm -f && ./manage.py runserver'
alias rm_vimsession='find . -name ".session.vim" | xargs /bin/rm -f'

if [ -x /usr/bin/scrot ]; then
    alias wscrot="scrot '$HOME/Pictures/scrot/%s_%Y-%m-%d_\$wx\$h.png'"
fi

# Bash completion
complete -d ll
complete -d lla
complete -ac xs
complete -ac loop

if [ -f "$HOME/.bashrc.local" ]; then
    . ${HOME}/.bashrc.local
fi

# Environment vars
export EDITOR="$(which vim)"
export PYTHONSTARTUP=~/.pythonrc
export DISPASS_LABELFILE=~/.dispass

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
sgvim()
{
    if [ -f "$PWD/.session.vim" ]; then
        if [ -f "/tmp/$USER.vimsession" ]; then
            echo Vim session already started
        else
            touch /tmp/$USER.vimsession
            gvim -S .session.vim >/dev/null 2>&1 &
            rm /tmp/$USER.vimsession
        fi
    else
        echo No .session.vim file found
    fi
}

alias gotoproject='cd `projectpad --get`'
alias setproject='projectpad --set && cd `projectpad --get`'
