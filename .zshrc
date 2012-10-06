HISTFILE=~/.histfile_zsh
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep nomatch
unsetopt extendedglob notify
bindkey -v

zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'l:|=* r:|=*' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/benjamin/.zshrc'

autoload -Uz compinit
compinit
