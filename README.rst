My dotfiles and scripts
=======================

These configurations and scripts are ultimately optimized for Zsh on
Archlinux and support combinations of Bash or Zsh with Archlinux and
Debian (or its derivatives: Ubuntu, Linux Mint, etc.).

Installing dotfiles repository
------------------------------

This dotfiles should be installed in a subdirectory of $HOME called
``dotfiles``. The install script is then used to create the correct
symlinks pointing to the dotfiles and shell scripts.

Clone the git repository in ``~/dotfiles``:

.. code-block:: shell

   cd ~
   git clone git://github.com/babab/dotfiles.git

Default install - preserving existing configuration
###################################################

Change to the created directory and run install.sh from that directory:

.. code-block:: shell

   cd ~/dotfiles
   ./install.sh             # shows help information
   ./install.sh --confirm   # install files

By default, the install script will not create symlinks for any
files/directories that already exist.

Complete install
################

If you don't care about any existing dotfiles and scripts (e.g.: ~/bin/,
~/.profile and ~/.bashrc) you can install everything. This makes sure
there are no clashes with existing configurations and is recommended.
Optionally create a (temporary) new user account to check it out and
test it. The following command **will** remove existing dotfiles:

.. code-block:: shell

   cd ~/dotfiles
   ./install.sh --force


Contents
--------

Small programs and utility scripts
##################################

`afkfish <bin/afkfish>`_
 AFK fishing clicker script for Minecraft using xdotool.
`afkmine <bin/afkmine>`_
 AFK mining clicker script for Minecraft using xdotool.
`baraction.sh <bin/baraction.sh>`_
 Statusbar script for spectrwm (my favorite WM).
`ctb <bin/ctb>`_
 Create temporary backup (create timestamped tar/gz archives of files/directories.
`duh <bin/duh>`_
 A fancy alias for ``du -h | sort -h`` that tees output before showing a sorted version at the end, paged with less.
`git-set-remote <bin/git-set-remote>`_
 Configure a single git remote with multiple --push urls and a read-only fetch url.
`htmlcount <bin/htmlcount>`_
 Count html elements in a html files or stdin.
`loadavg <bin/loadavg>`_
 Show loadavg as a percentage of cores available.
`loop <bin/loop>`_
 Run a command every second.
`make-php-ctags <bin/make-php-ctags>`_
 Create ctags for a PHP project.
`metainfo <bin/metainfo>`_
 Show information like mimetype and SHA1/MD5 checksums of a file.
`php-lintr <bin/php-lintr>`_
 search recursively for scripts and only show output when there are errors.
`random-wallpaper <bin/random-wallpaper>`_
 Select a random wallpaper from ~/Pictures/wallpapers and set it using feh.
`runserver <bin/runserver>`_
 Run a http.server, Django or Werkzeug development server depending on project context.
`screen-off <bin/screen-off>`_
 Blank the screen using xset.
`screenshot.sh <bin/screenshot.sh>`_
 Save a screenshot of a window or full screen in a timestamped file using scrot.
`slowcate <bin/slowcate>`_
 Wrapper for ``sudo find / | grep "searchtext"``
`touchpad-toggle <bin/touchpad-toggle>`_
 Toggle touchpad depending on current status using synclient.
`updateand <bin/updateand>`_
 Update system and reboot or halt computer after a countdown if there are no errors.
`urxvt-modeline <bin/urxvt-modeline>`_
 Modeline script for rxvt-unicode terminal.
`wmtoggle <bin/wmtoggle>`_
 Switch between using spectrwm or openbox when startx is executed.
`wschemaspy <bin/wschemaspy>`_
 Wrapper for wschemaspy MySQL db graphviz dumps
`xs <bin/xs>`_
 Alias for ``$@ > /dev/null 2>&1 &`` to start programs in X from the terminal.
`youtube-dl-clipboard <bin/youtube-dl-clipboard>`_
 Send URL in clipboard to youtube-dl (using xclip).
