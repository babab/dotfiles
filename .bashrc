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
if [ -d "/var/lib/gems/1.8/bin" ]; then
    PATH="$PATH:/var/lib/gems/1.8/bin"
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
\[$(tput setaf 2)\] \$(baps1)\
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
alias kk='echo git status && git status'
alias kl='echo git diff && git diff'
alias lk='echo git diff --cached && git diff --cached'
alias vv='ranger'

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

# Bash completion
complete -d ll
complete -d lla
complete -ac xs
complete -ac loop

if [ -f "$HOME/.bashrc.local" ]; then
    . ${HOME}/.bashrc.local
fi

# Environment vars
export PYTHONSTARTUP=~/.pythonrc
