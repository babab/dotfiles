#!/bin/sh

# Copyright (c) 2016 Benjamin Althues <benjamin@althu.es>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

if [[ -z ${RELATIVE_DOTFILES_PATH} ]]; then
    RELATIVE_DOTFILES_PATH="dotfiles"
fi

# Symbolic linker function (does not overwrite files if they exist)
makelink()
{
    file="${RELATIVE_DOTFILES_PATH}/dotfiles/dotfiles/$1"
    ln -s "$file" 2>/dev/null
    if [[ $? -ne 0 ]]; then
        echo -e "FAILED\tLinking ${file}, the file or link already exists"
    else
        echo -e "DONE\tLinking ${file}"
    fi
}

removelink()
{
    file="${RELATIVE_DOTFILES_PATH}/dotfiles/dotfiles/$1"
    ln -s "$file" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "FAILED\tLinking ${file}, the file or link already exists"
    else
        echo -e "DONE\tLinking ${file}"
    fi
}

usage()
{
    echo "Usage: ./install.sh [--confirm]"
    echo "       ./install.sh [--force]"
    echo
    echo Dotfiles installer by Benjamin Althues
    echo --------------------------------------
    echo The relative path to the dotfiles repository from within $HOME
    echo can be overridden by setting RELATIVE_DOTFILES_PATH when installing
    echo
    echo "    RELATIVE_DOTFILES_PATH=/my/alternative/path ./install.sh"
    echo
    echo Use --confirm to installing in a safe way without removing files
    echo Use --force to remove all files / symbolic links before installing
}

if [[ ! "$1" ]]; then
    usage
    exit 1
fi

# cd to home
cd ~

if [[ "$1" == "--force" ]]; then
    rm -f .Xdefaults
    rm -f .agignore
    rm -f .aliases
    rm -f .bashrc
    rm -f .config
    rm -f .emacs
    rm -f .gitconfig
    rm -f .gitignore
    rm -f .gitignore_global
    rm -f .ps1_basic
    rm -f .ps1_ext
    rm -f .pythonrc
    rm -f .spectrwm.conf
    rm -f .tmux.conf
    rm -f .vim
    rm -f .vimrc
    rm -f .xbindkeysrc
    rm -f .xinitrc
    rm -f .zsh
    rm -f .zshrc
    rm -f bin
fi

if [[ "$1" == "--confirm" || "$1" == "--force" ]]; then
    # create folder for vim bak and swp files, defined in .vimrc
    mkdir -p .vim-bak-swp

    # try to create symlinks for the files and directories below
    makelink .Xdefaults
    makelink .agignore
    makelink .aliases
    makelink .bashrc
    makelink .config
    makelink .emacs
    makelink .gitconfig
    makelink .gitignore
    makelink .gitignore_global
    makelink .ps1_basic
    makelink .ps1_ext
    makelink .pythonrc
    makelink .spectrwm.conf
    makelink .tmux.conf
    makelink .vim
    makelink .vimrc
    makelink .xbindkeysrc
    makelink .xinitrc
    makelink .zsh
    makelink .zshrc
    makelink bin

    # init/update git submodules
    cd ${RELATIVE_DOTFILES_PATH}
    git submodule update --init
else
    usage
    exit 1
fi
