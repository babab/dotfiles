# Changelog

This is a changelog for a dotfiles repository, it does not have the
same structure or purpose as a typical software changelog. It is meant
for documenting changes that need manual intervention of the user when
updating. It is closely linked with the `install.sh` script.

The version number does not follow semver, and is just a simple natural
number. Any version change represents a backwards incompatible change.
The version gets bumped only:
- when a symlink is added or removed (using dotfiles.list)
- on any change to the install/update procedure and/or script.

The current version can be found with `./install.sh --version`.

## Index
<!-- auto generated with https://github.com/mzlogin/vim-markdown-toc -->
<!-- vim-markdown-toc GFM -->

* [v6 - 2023-05-24](#v6---2023-05-24)
    * [Manual actions](#manual-actions)
* [v5 - 2023-05-04](#v5---2023-05-04)
    * [Manual actions](#manual-actions-1)
    * [Changes](#changes)
* [v4 - 2023-04-20](#v4---2023-04-20)
    * [Manual actions](#manual-actions-2)
    * [Changes](#changes-1)
* [v3 - 2023-02-28](#v3---2023-02-28)
    * [Changes](#changes-2)
* [v2 - 2023-02-23](#v2---2023-02-23)
* [v1 - 2023-02-12](#v1---2023-02-12)
    * [Changes](#changes-3)

<!-- vim-markdown-toc -->


------------------------------------------------------------------------------

## v6 - 2023-05-24

Declutter hidden files in HOME, by removing the dotfiles/symlinks from
$HOME for files that can be programmatically pointed at through includes
and environment variables.

The ps1 prompt is now configured by including the correct file in
`.bashrc`. The global gitignore file and the include.path pointing to
user.gitconfig is now configured through envvar key/value pairs set in
`~/.profile`.

The files with their old and new locations:

- `~/.ps1_basic` -> `$BABABBOT_ROOT/sh/ps1_basic.bash`
- `~/.ps1_ext` -> `$BABABBOT_ROOT/sh/ps1_ext.bash`
- `~/.gitignore_global` -> `$BABABDOT_ROOT/conf/gitignore_global`

Changed in configuration, but still unversioned in Git:

- `~/.gitconfig.user` -> `$BABABDOT_ROOT/conf/user.gitconfig`

The old symlinks can/must be removed, since they will point to
non-existing files from now on.


### Manual actions


The easiest way is to remove symlinks by hand.

``` shell
cd ~
rm .ps1_basic .ps1_ext .gitignore_global
mv .gitconfig.user $BABABDOT_ROOT/conf/user.gitconfig
```

**OR**

You can use the install script to remove and populate all symlinks.
In v5 do: `./install.sh --remove`.
Then, in v6 do: `./install.sh --confirm`.


------------------------------------------------------------------------------

## v5 - 2023-05-04

Added ability to place folder anywhere in `HOME`. Previously a location
of `~/dotfiles` was expected. The new default location and dirname is
`~/git/dotfiles`.

The install script now has a `--status` option to check on symlink
status and/or differences between existing local files and those in this
repo.

### Manual actions

To update, the dotfiles repo must either:

- Be moved from `~/dotfiles` to `~/git/dotfiles`.

  ``` shell
  cd ~
  ctb dotfiles  # create temporary backup using bin/ctb
  mkdir -p git
  mv dotfiles git
  cd git/dotfiles
  ./install.sh --force  # re-create symlinks
  ```

**OR**

- `BABABDOT_ROOT` must be changed to point to `~/dotfiles`.

  Pull the latest changes and edit the location for `BABABDOT_ROOT` in
  `dotfiles/.profile` or overwrite it elsewhere.

### Changes

- Introduced environment variable `BABABDOT_ROOT` in `.profile`.
- Used `BABABDOT_ROOT` in `.zshrc` to point to the plugins that are
  downloaded into the depends directory by the install script.
- Added `--status` option to install script.


------------------------------------------------------------------------------

## v4 - 2023-04-20

Fix `~/bin` check and add cobra-cli config.

### Manual actions

Update by running:

    ./install.sh --confirm

### Changes

- Added file `dotfiles/.cobra.yaml` with symlink `~/.cobra.yaml`


------------------------------------------------------------------------------

## v3 - 2023-02-28

Check if `~/bin` is a symlink or directory. This changes the flow of
the install script somewhat. No user action needed after upgrade.

### Changes

- Never remove `~/bin` if it is a dir instead of a symlink, not even
  when forced.


------------------------------------------------------------------------------

## v2 - 2023-02-23

Download *baps1* if no cc is found on the system. This changes the flow of
the install script somewhat. No user action needed for existing configs.


------------------------------------------------------------------------------

## v1 - 2023-02-12

Begin versioning. Add version number to `install.sh` script and add
`--version` flag to display it.

### Changes

- Introduce **BABABDOT_VERSION** number to `install.sh`.

