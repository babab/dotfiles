HISTFILE=~/.histfile_zsh
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

setopt completealiases autopushd pushdignoredups
setopt PROMPT_SUBST

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

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

# Check if ssh-agent and key are loaded
sshkey_ps1()
{
    ssh-add -l >/dev/null 2>&1
    case "$?" in
        0)
            echo ssh-key is loaded
            # echo y
            ;;
        1)
            echo ssh-key is NOT loaded
            # echo n
            ;;
        2)
            echo ssh-agent is NOT running
            # echo n/a
            ;;
    esac
}

# Check if a particular process is running
pscheck_ps1()
{
    pgrep "$1" >/dev/null 2>&1
    case $? in
        0)
            echo y
            ;;
        *)
            echo n
            ;;
    esac
}

# Check if a python virtualenv is activated
venv_ps1()
{
    if [ -z "$VIRTUAL_ENV" ]; then
        echo n
    else
        echo venv
    fi
}


# Machine dependent settings
if [[ $(uname) == "OpenBSD" ]]; then
    PROMPT='
%{$fg_bold[red]%}%n%{$reset_color%} %Bat%b %{$fg_bold[yellow]%}%m %(?..%{$fg_bold[red]%}err:%? )%{$fg_bold[magenta]%}%! %{$fg_bold[green]%}$(sshkey_ps1){$fg_bold[magenta]%}$(venv_ps1) $(prompt_git_info)%{$reset_color%}
%{$fg_bold[green]%}%~%{$fg_bold[yellow]%}%#%{$reset_color%} '
else
    PROMPT='
%{$fg_bold[red]%}%n%{$reset_color%} %Bat%b %{$fg_bold[yellow]%}%m %(?..%{$fg_bold[red]%}err:%? )%{$fg_bold[magenta]%}%! %{$fg_bold[magenta]%}$(venv_ps1) %{$fg_bold[green]%}$(baps1) $(prompt_git_info)%{$reset_color%}
%{$fg_bold[green]%}%~%{$fg_bold[yellow]%}%#%{$reset_color%} '
    source ~/dotfiles/depends/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source ~/dotfiles/depends/zsh-history-substring-search/zsh-history-substring-search.zsh
    source ~/dotfiles/depends/zsh-autosuggestions/zsh-autosuggestions.zsh

    # zsh-history-substring-search
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
fi
