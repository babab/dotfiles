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

if [ ! -d "$HOME/Pictures/scrot" ]; then
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

alias la='/bin/ls -FA --color=auto'
ll()
{
    ls -Flh  --color=always "$@" | less -FXRS
}
lla()
{
    ls -FlhA --color=always "$@" | less -FXRS
}
alias ls='/bin/ls -F  --color=auto'

shutdown()
{
    # $SHUTDOWN_ALLOWED is defined in .bashrc.local
    if [ "$SHUTDOWN_ALLOWED" != "YES" ]; then
        echo SHUTDOWN_ALLOWED=YES is not defined
        return
    fi

    case "$1" in
    "")
        echo "Usage: zzz <minutes>          Shutdown in <minutes> from now"
        echo "       zzz now                Shutdown instandly"
        ;;
    "n" | "now")
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
alias sshagent='eval `ssh-agent` >/dev/null'
alias wscrot="scrot '$HOME/Pictures/scrot/%s_%Y-%m-%d_\$wx\$h.png'"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Bash completion
complete -d ll
complete -d lla
complete -ac xs

if [ -f "$HOME/.bashrc.local" ]; then
    . ${HOME}/.bashrc.local
fi
