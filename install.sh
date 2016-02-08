#!/bin/sh

# The relative path to the dotfiles repository from within $HOME
# can be overridden by setting RELATIVE_DOTFILES_PATH when installing
#
#     RELATIVE_DOTFILES_PATH='/my/alternative/path' ./install.sh
#
if [ -z ${RELATIVE_DOTFILES_PATH} ]; then
    RELATIVE_DOTFILES_PATH="dotfiles"
fi

# Symbolic linker function (does not overwrite files if they exist)
makelink()
{
    file="${RELATIVE_DOTFILES_PATH}/dotfiles/dotfiles/$1"
    ln -s "$file" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "FAILED\tLinking ${file}, the file or link already exists"
    else
        echo -e "DONE\tLinking ${file}"
    fi
}

# cd to home
cd ~

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
