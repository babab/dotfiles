# Environment vars
export BROWSER="/usr/bin/chromium"
export EDITOR="/usr/bin/vim"
export EXEC_FOR_PYTHON="python"
export GPG_TTY="$(tty)"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LESS="iFXRS"
export GOPATH="$HOME/go"
export RUBYPATH="$HOME/.gem/ruby/2.5.0/bin"
export PATH="$HOME/bin:$GOPATH/bin:$HOME/.local/bin:$PATH:$HOME/usr/bin:$HOME/.composer/vendor/bin:$RUBYPATH"
export PYTHONSTARTUP=~/.pythonrc
export VIRTUAL_ENV_DISABLE_PROMPT=disabled

if [ ! -z "${SSH_CONNECTION}" ]; then
    export TERM=screen
fi

# QT bindings for Go, see https://github.com/therecipe/qt/
QT_DIR=/usr/lib/qt
QT_PKG_CONFIG=true

# Script settings for ~/bin scripts
export VBVMCONN_VBOXMANAGE='/cygdrive/c/Program Files/Oracle/VirtualBox/VBoxManage.exe'
