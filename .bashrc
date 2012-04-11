[ -z "$PS1" ] && return
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=999
HISTFILESIZE=200
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

set -o vi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -d "$HOME/bin" ]; then
    PATH="$PATH:$HOME/bin"
fi

if [ -x /usr/bin/scrot ] && [ ! -d "$HOME/Pictures/scrot" ]; then
    mkdir -p "$HOME/Pictures/scrot"
fi

exitcode_ps1()
{
    if [ $1 -gt 0 ]; then
        echo " err:$1"
    fi
}

sshkey_ps1()
{
    ssh-add -l 2>/dev/null >/dev/null
    case $? in
        0)
            echo "+"
            ;;
        1)
            echo "-"
            ;;
        2)
            echo "n/a"
            ;;
    esac
}

PS1="\[$(tput bold; tput setaf 1)\]\n\u\
\[$(tput op)\] at \
\[$(tput setaf 3)\]\h\
\[$(tput setaf 1)\]\$(exitcode_ps1 \$?)\
\[$(tput setaf 5)\] \!\
\[$(tput setaf 6)\] \$(sshkey_ps1)\
\[$(tput setaf 4)\] \$(date +'%H:%M:%S')\
\[$(tput setaf 2)\] \$(timediff_ps1 ${USER}`tty`)\
\[$(tput setaf 1)\]\$(__git_ps1 ' %s')\
\[$(tput setaf 2)\]\n\w\
\[$(tput setaf 3)\]\$\[$(tput op)\] "

# Quick shortcuts
alias ls='/bin/ls -F  --color=auto'
alias la='/bin/ls -FA --color=auto'
ll()
{
    /bin/ls -Flh  --color=always "$@" | less -FXRS
}
lla()
{
    /bin/ls -FlhA --color=always "$@" | less -FXRS
}
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias x='exit'
alias xx="> $HOME/.bash_history && exit"

# Setting default flags
alias less='less -FXRS'
alias sshagent='eval `ssh-agent` >/dev/null'

# Custom aliases
alias openboxwindowinfo='obxprop | grep "^_OB_APP"'
alias rm_pyc='find . -name "*.pyc" | xargs /bin/rm -f'
alias rm_migrations='find . -wholename "*/migrations/*" | xargs /bin/rm -f'
alias runserver='find . -name "*.pyc" | xargs /bin/rm -f && ./manage.py runserver'

if [ -x /usr/bin/scrot ]; then
    alias wscrot="scrot '$HOME/Pictures/scrot/%s_%Y-%m-%d_\$wx\$h.png'"
fi

git_stashed_checkout()
{
    if [ ! $1 ]; then
        echo "USAGE: git_stashed_checkout <branch>"
        return
    fi
    branch="$1"
    git stash && git checkout $branch && git stash pop
}

# Bash completion
complete -d ll
complete -d lla
complete -ac xs

if [ -f "$HOME/.bashrc.local" ]; then
    . ${HOME}/.bashrc.local
fi
