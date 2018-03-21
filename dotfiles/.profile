# Environment vars
export BROWSER="/usr/bin/brave"
export EDITOR="/usr/bin/vim"
export EXEC_FOR_PYTHON="python2"
export GPG_TTY="$(tty)"
export LANG=en_US.UTF-8
export LESS="iFXRS"
export PATH="$HOME/bin:$PATH:$HOME/usr/bin:$HOME/.composer/vendor/bin"
export PYTHONSTARTUP=~/.pythonrc
export VIRTUAL_ENV_DISABLE_PROMPT=disabled

if [ ! -z "${SSH_CONNECTION}" ]; then
    export TERM=screen
fi
