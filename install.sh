#!/bin/bash

# Copyright (c) 2016-2023 Benjamin Althues <benjamin@babab.nl>
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

usage()
{
    echo Dotfiles installer by Benjamin Althues
    echo --------------------------------------
    echo "Usage: ./install.sh [--force]"
    echo "       ./install.sh [--remove]"
    echo "       ./install.sh [--confirm]"
    echo "       ./install.sh [--version]"
    echo
    echo 'Use --confirm to install in a safe way without removing files'
    echo 'Use --remove to remove all (pre-existing) files / symbolic links'
    echo '    (before install)'
    echo 'Use --force to remove all existing files and install in one step'
}

# Installer script version number, this gets bumped:
# - on any change to the install/update procedure
# - when a symlink is added or removed that is handled by this script
#   (in dotfiles.list)
export BABABDOT_VERSION=3


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
    ln -s "$file" 2>/dev/null
    if [[ $? -ne 0 ]]; then
        echo -e "SKIPPED\t${file}, the file or link already exists"
    else
        echo -e "LINKED\t${file}"
    fi
}

pull_or_clone_github()
{
    # This should always be executed from the parent of a (soon to be)
    # checked out git workdirectory.
    _user="$1"
    _repo="$2"
    echo "* $2 - https://github.com/$_user/$_repo"
    if [ -d "$_repo" ]; then
        cd "$_repo"
        git pull
        cd ..
    else
        git clone https://github.com/"$_user/$_repo".git
    fi
}

_getdepends()
{
    echo -- cloning / updating dependencies
    mkdir -p "${RELATIVE_DOTFILES_PATH}/depends"
    cd "${RELATIVE_DOTFILES_PATH}/depends"
    pull_or_clone_github ryuslash baps1
    pull_or_clone_github zsh-users zsh-autosuggestions
    pull_or_clone_github zsh-users zsh-history-substring-search
    pull_or_clone_github zsh-users zsh-syntax-highlighting
    cd "$HOME"
}

LFS="
"

_remove()
{
    echo ':: Removing files'
    for line in $(cat "${HOME}/${RELATIVE_DOTFILES_PATH}/dotfiles.list"); do
        rm -vf "$line"
    done

    # unlink bin directory separately
    if [ -h bin ]; then
        rm -f bin 2>/dev/null
    else
        echo Error: bin is not a symbolic link but a directory.
        echo
        echo ~/bin should either be non-existent or a symlink to
        echo ${RELATIVE_DOTFILES_PATH} Please fix and run again.
        exit 2
    fi

}

function _confirm {
    # create folder for vim bak and swp files
    mkdir -p .vim-bak-swp

    # try to create symlinks for the defined files and directories
    echo -- creating symlinks to dotfiles
    for line in $(cat "${HOME}/${RELATIVE_DOTFILES_PATH}/dotfiles.list"); do
        makelink "$line"
    done

    # link bin directory separately
    echo -- creating ~/bin symlink
    ln -s ${RELATIVE_DOTFILES_PATH}/bin 2>/dev/null

    # skip baps1 section below if it's already installed
    echo -- checking baps1
    command -v baps1 && return

    # install or download baps1
    if (command -v cc && command -v make); then
        echo ++ building/installing baps1
        INST_PATH="${HOME}/${RELATIVE_DOTFILES_PATH}/bin" make -e \
           -C "${HOME}/${RELATIVE_DOTFILES_PATH}/depends/baps1/src" install
        make -C "${HOME}/${RELATIVE_DOTFILES_PATH}/depends/baps1/src" clean
    else
        echo ++ downloading/installing baps1
        curl -o "${HOME}/${RELATIVE_DOTFILES_PATH}/bin/baps1" \
            http://files.babab.nl/programs/x86_64/baps1/linux/baps1
        chmod +x "${HOME}/${RELATIVE_DOTFILES_PATH}/bin/baps1"
    fi
}


if [[ ! "$1" ]]; then
    usage
    exit 1
fi


# cd to home; all further actions are relative to $HOME
cd "$HOME"

case $1 in
'--remove')
    _remove
    ;;
'--confirm')
    _confirm
    _getdepends
    ;;
'--force')
    _remove
    _confirm
    _getdepends
    ;;
'--version')
    echo "install.sh v$BABABDOT_VERSION"
    ;;
*)
    usage
    exit 1
    ;;
esac
