# My dotfiles and scripts

These configurations and scripts are ultimately optimized for Zsh on
Archlinux and support combinations of Bash or Zsh with Archlinux and
Debian (or its derivatives: Ubuntu, Linux Mint, etc.).


## Index
<!-- auto generated with https://github.com/mzlogin/vim-markdown-toc -->
<!-- vim-markdown-toc GFM -->

* [Small programs and utility scripts](#small-programs-and-utility-scripts)
* [Installing dotfiles repository](#installing-dotfiles-repository)
    * [Default install - preserving existing configuration](#default-install---preserving-existing-configuration)
    * [Complete install](#complete-install)

<!-- vim-markdown-toc -->


## Small programs and utility scripts

[afkfish](bin/afkfish)

- AFK fishing clicker script for Minecraft using xdotool.

[afkmine](bin/afkmine)

- AFK mining clicker script for Minecraft using xdotool.

[baraction.sh](bin/baraction.sh)

- Statusbar script for spectrwm (my favorite WM).

[check-programs](bin/check-programs)

- Check to see what programs are installed on the system

[ctb](bin/ctb)

- Create temporary backup (create timestamped tar/gz archives of
    files/directories.

[duh](bin/duh)

- A fancy alias for `du -h | sort -h` that tees output before showing
    a sorted version at the end, paged with less.

[envtest](bin/envtest)

- Check paths of python, pip and virtual environment

[git-remote-gh](bin/git-remote-gh)

- Clone or configure remotes (of) a Github repo with favourable urls
    (using https for fetch / ssh for push by default).

[htmlcount](bin/htmlcount)

- Count html elements in a html files or stdin.

[loadavg](bin/loadavg)

- Show loadavg as a percentage of cores available.

[loop](bin/loop)

- Run a command every second.

[make-php-ctags](bin/make-php-ctags)

- Create ctags for a PHP project.

[metainfo](bin/metainfo)

- Show information like mimetype and SHA1/MD5 checksums of a file.

[mkscript](bin/mkscript)

- Quickly create an executable script in python, node or shell script
    with some minimal boilerplate.

[php-lintr](bin/php-lintr)

- search recursively for scripts and only show output when there are
    errors.

[random-wallpaper](bin/random-wallpaper)

- Select a random wallpaper from \~/Pictures/wallpapers and set it
    using feh.

[runserver](bin/runserver)

- Run a http.server, Django or Werkzeug development server depending
    on project context.

[screen-off](bin/screen-off)

- Blank the screen using xset.

[screenshot.sh](bin/screenshot.sh)

- Save a screenshot of a window or full screen in a timestamped file
    using scrot.

[slowcate](bin/slowcate)

- Wrapper for `sudo find / | grep "searchtext"`

[sysupgrade](bin/sysupgrade)

- Do a system upgrade, clean package cache and reboot/shutdown/return

[termwidth](bin/termwidth)

- Get terminal width and/or print rulers to help set window size.

[tmux-swprefix](bin/tmux-swprefix)

- Helper for using tmux over ssh in tmux (over ssh in tmux)

[touchpad-toggle](bin/touchpad-toggle)

- Toggle touchpad depending on current status using synclient.

[urxvt-modeline](bin/urxvt-modeline)

- Modeline script for rxvt-unicode terminal.

[vbvmconn](bin/vbvmconn)

- SSH connect with a Windows Hosted VirtualBox VM from within Cygwin,
    starting the VM first if needed.

[vii](bin/vii)

- Edit files in emacs/vim using a tab/pane layout and sudo if root.

[wmtoggle](bin/wmtoggle)

- Switch between using spectrwm or openbox when startx is executed.

[wschemaspy](bin/wschemaspy)

- Wrapper for wschemaspy MySQL db graphviz dumps

[xs](bin/xs)

- Alias for `$@ > /dev/null 2>&1 &` to start programs in X from the
    terminal.

[youtube-dl-clipboard](bin/youtube-dl-clipboard)

- Send URL in clipboard to youtube-dl (using xclip).


## Installing dotfiles repository

This dotfiles should be installed in a subdirectory of \$HOME called
`dotfiles`. The install script is then used to create the correct
symlinks pointing to the dotfiles and shell scripts.

Clone the git repository in `~/dotfiles`:

``` shell
cd ~
git clone https://github.com/babab/dotfiles.git
```

### Default install - preserving existing configuration

Change to the created directory and run install.sh from that directory:

``` shell
cd ~/dotfiles
./install.sh             # shows help information
./install.sh --confirm   # install files
```

By default, the install script will not create symlinks for any
files/directories that already exist.

### Complete install

If you don\'t care about any existing dotfiles and scripts (e.g.:
\~/bin/, \~/.profile and \~/.bashrc) you can install everything. This
makes sure there are no clashes with existing configurations and is
recommended. Optionally create a (temporary) new user account to check
it out and test it. The following command **will** remove existing
dotfiles:

``` shell
cd ~/dotfiles
./install.sh --force
```
