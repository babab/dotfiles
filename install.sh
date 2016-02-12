#!/bin/bash

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

# check if we are in the right directory
grep -q dotfiles .git/config 2>/dev/null
if [[ $? -ne 0 ]]; then
    echo Error: cd to repository root first before running ./install.sh
    exit 1
fi

if [[ -z ${RELATIVE_DOTFILES_PATH} ]]; then
    RELATIVE_DOTFILES_PATH=$(pwd | sed -e "s|$HOME/||")
fi

# Symbolic linker function (does not overwrite files if they exist)
makelink()
{
    file="${RELATIVE_DOTFILES_PATH}/dotfiles/$1"
    cd "$HOME"
    ln -s "$file" 2>/dev/null
    if [[ $? -ne 0 ]]; then
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
    echo Use --confirm to installing in a safe way without removing files
    echo 'Use --remove to remove all files / symbolic links (before install)'
}

if [[ ! "$1" ]]; then
    usage
    exit 1
fi

LFS="
"

# cd to home
cd "$HOME"

case $1 in
'--remove')
    for line in $(cat "${HOME}/${RELATIVE_DOTFILES_PATH}/symlinks"); do
        rm -f "$line"
    done
    ;;
'--confirm')
    # create folder for vim bak and swp files, defined in .vimrc
    mkdir -p .vim-bak-swp

    # init/update git submodules
    cd ${RELATIVE_DOTFILES_PATH}
    git submodule update --init

    # try to create symlinks for the defined files and directories
    for line in $(cat "${HOME}/${RELATIVE_DOTFILES_PATH}/symlinks"); do
        makelink "$line"
    done
    ;;
*)
    usage
    exit 1
    ;;
esac
