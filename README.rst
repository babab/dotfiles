My dotfiles (\*nix configurations and scripts)
==============================================

These configurations are ultimately optimized for Zsh on Archlinux
and support combinations of Bash or Zsh with Archlinux and Debian
(derivatives).

Installing dotfiles into ~/dotfiles
-----------------------------------

.. code-block:: console

   cd ~
   rm .bashrc .zshrc # remove these or they won't get symlinked to ~/dotfiles
   git clone git://github.com/babab/dotfiles.git
   cd dotfiles
   ./install.sh
