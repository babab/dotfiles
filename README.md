# My dotfiles and scripts

These configurations and scripts are ultimately optimized for Zsh on
Archlinux and support combinations of Bash or Zsh with Archlinux and
Debian (or its derivatives: Ubuntu, Linux Mint, etc.).


## Index
<!-- auto generated with https://github.com/mzlogin/vim-markdown-toc -->
<!-- vim-markdown-toc GFM -->

* [Code hosting / Links](#code-hosting--links)
* [Small programs and utility scripts](#small-programs-and-utility-scripts)
* [Cloning dotfiles repository](#cloning-dotfiles-repository)
* [Linking dotfiles](#linking-dotfiles)
    * [Default install - preserving existing configuration](#default-install---preserving-existing-configuration)
    * [Complete install](#complete-install)

<!-- vim-markdown-toc -->


## Code hosting / Links

- [babab/dotfiles](https://codeberg.org/babab/dotfiles) on Codeberg
- [babab/dotfiles](https://github.com/babab/dotfiles) on Github

Dotfiles for Vim (*~/.vim*) are kept in a separate repository called
vim-config.

- [babab/vim-config](https://codeberg.org/babab/vim-config) on Codeberg
- [babab/vim-config](https://github.com/babab/vim-config) on Github


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


## Cloning dotfiles repository

This repository should be cloned somewhere down the path in `HOME`.
The default location is *~/git/dotfiles*.

Some config files will directly refer to files in this repository
using the env var `BABABDOT_ROOT`. If you use a location
other the *~/git/dotfiles*, this var should be changed to
point to the right location. It is defined at the top of
[dotfiles/.profile](dotfiles/.profile).

The install script is then used to create the correct
symlinks pointing to the dotfiles and shell scripts.

Clone the git repository somewhere in `HOME`:

``` shell
mkdir -p ~/git
cd ~/git

# Download / clone from either Github or Codeberg
git clone https://codeberg.org/babab/dotfiles.git
git clone https://github.com/babab/dotfiles.git
```

## Linking dotfiles

Before any linking is done, you can compare these dotfiles with the ones
in your userdir. It will show if the files are symlinked and shows if
the files/symlinks exists but differ with these repo.

To check status, use:

``` shell
./install.sh --status
```

### Default install - preserving existing configuration

Change to the created directory and run install.sh from that directory:

``` shell
cd ~/git/dotfiles
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
cd ~/git/dotfiles
./install.sh --force
```
