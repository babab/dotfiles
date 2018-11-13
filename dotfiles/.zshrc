HISTFILE=~/.histfile_zsh
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

setopt completealiases autopushd pushdignoredups
setopt PROMPT_SUBST
# setopt PROMPT_PERCENT

autoload -U compinit && compinit
autoload -U colors && colors

# Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

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

# # Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# # Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

# with baps1
# PROMPT='%(?..%{$fg_bold[red]%}err:%? )%{$fg_bold[magenta]%}%! %{$fg_bold[green]%}$(baps1) $(prompt_git_info)%{$reset_color% %{$fg_bold[green]%}%~%{$fg_bold[yellow]%}%#%{$reset_color%} '
# without baps1
PROMPT='%(?..%{$fg_bold[red]%}err:%? )%{$fg_bold[magenta]%}%! $(prompt_git_info)%{$reset_color% %{$fg_bold[green]%}%~%{$fg_bold[yellow]%}%#%{$reset_color%} '

source ~/dotfiles/depends/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/depends/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/dotfiles/depends/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-history-substring-search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
