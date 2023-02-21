HISTFILE=~/.histfile_zsh
HISTSIZE=8000
SAVEHIST=8000
bindkey -v

setopt completealiases autopushd pushdignoredups
setopt PROMPT_SUBST
# setopt PROMPT_PERCENT

autoload -U compinit && compinit
autoload -U colors && colors

# # Autoload zsh functions.
# fpath=(~/.zsh/functions $fpath)
# autoload -U ~/.zsh/functions/*(:t)

source ${HOME}/.aliases # aliases and (wrapper) functions
source ${HOME}/.profile # environment variables

if [ -x /usr/bin/scrot ]; then
    if [ ! -d "$HOME/Pictures/scrot" ]; then
        mkdir -p "$HOME/Pictures/scrot"
    fi
    alias wscrot="scrot '$HOME/Pictures/scrot/%s_%Y-%m-%d_\$wx\$h.png'"
fi

### Prompt ###################################################################

# function precmd() {
#     myprompt=$(shellprompt -p minimal)
# }
# PROMPT=$'%{$myprompt%} '
# PROMPT='
# %B%{$fg_bold[red]%}%n%{ %}%{$fg_bold[white]%}%{at%}%{ %}%{$fg_bold[yellow]%}%M%{ %}%{$fg_bold[red]%}%{n%}%{ %}%{sshkey%}
# %{$fg_bold[green]%}%{~/g/s/g/b/shellprompt%}%{$fg_bold[yellow]%}%{%%%}%{ %}%{$reset_color%}'

# PS1='$(shellprompt-stable -p babab --no-ansi)'
# PROMPT='$(shellprompt -m zsh -p babab)'
# PROMPT='%{$(shellprompt -p babab)%}'

## with baps1
#PROMPT='%(?..%{$fg_bold[red]%}err:%? )%{$fg_bold[magenta]%}%! %{$fg_bold[green]%}$(baps1) %{$reset_color% %{$fg_bold[green]%}%~%{$fg_bold[yellow]%}%#%{$reset_color%} '

# without baps1
PROMPT='%(?..%{$fg_bold[red]%}err:%? )%{$fg_bold[magenta]%}%! %{$reset_color%} %{$fg_bold[green]%}%~%{$fg_bold[yellow]%}%#%{$reset_color%} '


### Other ####################################################################

source ~/dotfiles/depends/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/depends/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/dotfiles/depends/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-history-substring-search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# pyenv
if command -v pyenv; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# print kernel, hostname, username and ssh-key/ssh-agent status
~/bin/hellotty

# vim: set ft=sh:
