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

if [ -x /usr/bin/scrot ]; then
    if [ ! -d "$HOME/Pictures/scrot" ]; then
        mkdir -p "$HOME/Pictures/scrot"
    fi
    alias wscrot="scrot '$HOME/Pictures/scrot/%s_%Y-%m-%d_\$wx\$h.png'"
fi

# Source environment variables
. $HOME/.profile

# Source aliases
. $HOME/.aliases

# Bash completion for custom functions and scripts
complete -d ll
complete -d lla
complete -ac xs
complete -ac loop
complete -A hostname vbvmconn

# Source prompt settings, two options:
. "$BABABDOT_ROOT/sh/ps1_basic.bash"  # option 1
# . "$BABABDOT_ROOT/sh/ps1_ext.bash"  # option 2

# Source local settings and overrides
if [ -f "$HOME/.bashrc.local" ]; then
    . ${HOME}/.bashrc.local
fi

# print kernel, hostname, username and ssh-key/ssh-agent status
~/bin/hellotty
