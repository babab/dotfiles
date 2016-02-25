My dotfiles (\*nix configurations and scripts)
==============================================

These configurations are ultimately optimized for Zsh on Archlinux
and support combinations of Bash or Zsh with Archlinux and Debian
(derivatives).

Installing dotfiles repository
------------------------------

This dotfiles should be installed somewhere in a (sub)directory of
$HOME. The install script is then used to create the correct symlinks
pointing to the dotfiles and shell scripts.

Clone the git repository somewhere in your home directory, for instance
in ``~/dotfiles``:

.. code-block:: shell

   cd ~
   git clone git://github.com/babab/dotfiles.git


Change to the created directory and run install.sh from that directory:

.. code-block:: shell

   cd ~/dotfiles
   ./install.sh
   ./install.sh --confirm

The install script will not create symlinks for any files/directories
that already exist.
