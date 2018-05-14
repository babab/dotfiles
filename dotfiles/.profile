# Environment vars
export BROWSER="/usr/bin/brave"
export EDITOR="/usr/bin/vim"
export EXEC_FOR_PYTHON="python2"
export GPG_TTY="$(tty)"
export LANG=en_US.UTF-8
export LESS="iFXRS"
export GOPATH="$HOME/go"
export RUBYPATH="$HOME/.gem/ruby/2.5.0/bin"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH:$HOME/usr/bin:$HOME/.composer/vendor/bin:$RUBYPATH"
export PYTHONSTARTUP=~/.pythonrc
export VIRTUAL_ENV_DISABLE_PROMPT=disabled

if [ ! -z "${SSH_CONNECTION}" ]; then
    export TERM=screen
fi
