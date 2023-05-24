# Location for the root folder of dotfiles repository
export BABABDOT_ROOT="$HOME/git/dotfiles"

# Environment vars
export BROWSER="/usr/bin/chromium"
export EDITOR="/usr/bin/vim"
export EXEC_FOR_PYTHON="python"
export GPG_TTY="$(tty)"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LESS="iFXRS"
export GOPATH="$HOME/go"
export PATH="$HOME/bin:$HOME/.local/bin:$GOPATH/bin:$PATH"
export PYTHONSTARTUP="$BABABDOT_ROOT/conf/pythonrc"
export VIRTUAL_ENV_DISABLE_PROMPT=disabled
export VISUAL="/usr/bin/vim"

# Git config env vars
export GIT_CONFIG_COUNT=2
export GIT_CONFIG_KEY_0=core.excludesfile
export GIT_CONFIG_VALUE_0="$BABABDOT_ROOT/conf/gitignore_global"
export GIT_CONFIG_KEY_1=include.path
export GIT_CONFIG_VALUE_1="$BABABDOT_ROOT/conf/user.gitconfig"

if [ -d "/usr/local/go" ]; then
    export GOROOT=/usr/local/go
fi
if [ ! -z "${SSH_CONNECTION}" ]; then
    export TERM=screen
fi

# pyenv
if command -v pyenv; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# QT bindings for Go, see https://github.com/therecipe/qt/
QT_DIR=/usr/lib/qt
QT_PKG_CONFIG=true

# Script settings for ~/bin scripts
export VBVMCONN_VBOXMANAGE='/cygdrive/c/Program Files/Oracle/VirtualBox/VBoxManage.exe'
