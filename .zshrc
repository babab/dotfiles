HISTFILE=~/.histfile_zsh
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

PATH="$PATH:$HOME/bin"

setopt autocd completealiases

autoload -U compinit && compinit
autoload -U colors && colors

alias la='ls -FA --color=auto'
ll() { ls -Flh  --color=always "$@" | less -FXRS }
lla() { ls -FlhA --color=always "$@" | less -FXRS }
alias ls='ls -F  --color=auto'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias kk='echo git status && git status'
alias kl='echo git diff && git diff'
alias less='less -FXRS'
alias lk='echo git diff --cached && git diff --cached'
alias rm_migrations='find . -wholename "*/migrations/*" | xargs /bin/rm -f'
alias rm_pyc='find . -name "*.pyc" | xargs /bin/rm -f'
alias rm_vimsession='find . -name ".session.vim" | xargs /bin/rm -f'
alias runmailserver='python -m smtpd -n -c DebuggingServer localhost:1025'
alias sinstall='sudo make install'
alias sshagent='eval `ssh-agent` >/dev/null'
alias x='exit'

# Projectpad aliases
alias gotoproject='cd `projectpad --get`'
alias setproject='projectpad --set && cd `projectpad --get`'



### Prompt ###################################################################
# Instructions found here:
# http://sebastiancelis.com/2009/11/16/zsh-prompt-git-users/

# Allow for functions in the prompt.
setopt PROMPT_SUBST

# Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

# Set the prompt.
# RPROMPT=$'%{${fg[cyan]}%}%B%~%b$(prompt_git_info)%{${fg[default]}%} '


PROMPT='
%{$fg_bold[red]%}%n%{$reset_color%} %Bat%b %{$fg_bold[yellow]%}%m %(?..%{$fg_bold[red]%}err:%? )%{$fg_bold[magenta]%}%! %{$fg_bold[green]%}%l %{$fg_bold[red]%}$(prompt_git_info)%{$reset_color%}
%{$fg_bold[green]%}%~%{$fg_bold[yellow]%}%#%{$reset_color%} '
