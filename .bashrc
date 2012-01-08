[ -z "$PS1" ] && return
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=999
HISTFILESIZE=200
shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -d "$HOME/bin" ]; then
    PATH="$PATH:$HOME/bin"
fi

exitcode_ps1()
{
    if [ $1 -gt 0 ]; then
        echo " Err:$1"
    fi
}

PS1="\[$(tput bold; tput setaf 1)\]\n\u\
\[$(tput op)\] at \
\[$(tput setaf 3)\]\h\
\[$(tput setaf 1)\]\$(exitcode_ps1 \$?)\
\[$(tput setaf 5)\] \!\
\[$(tput setaf 4)\] \$(date +'%H:%M:%S')\
\[$(tput setaf 2)\] \$(timediff_ps1)\
\[$(tput setaf 1)\]\$(__git_ps1 ' %s')\
\[$(tput setaf 2)\]\n\w\
\[$(tput setaf 3)\]\$\[$(tput op)\] "

alias la='/bin/ls -FA --color=auto'
ll()
{
    ls -Flh  --color=auto "$@" | less -FXRS
}
lla()
{
    ls -FlhA --color=auto "$@" | less -FXRS
}
alias ls='/bin/ls -F  --color=auto'

zzz()
{
    case "$1" in
    "")
        echo "Usage: zzz <minutes>\t\tShutdown in <minutes> from now"
        echo "       zzz now      \t\tSutdown instandly"
        ;;
    "now")
        sudo pkill shutdown
        sudo shutdown -hP now
        ;;
    *)
        sudo pkill shutdown
        sudo shutdown -hP "+$1"
        ;;
    esac
}

alias x='exit'
alias xx="> $HOME/.bash_history && exit"
alias less='less -FXRS'
alias openboxwindowinfo='obxprop | grep "^_OB_APP"'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

if [ -f $HOME/.shaliases ]; then
    . $HOME/.shaliases
fi
