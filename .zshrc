HISTFILE=~/.histfile_zsh
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

setopt autocd completealiases

autoload -U compinit && compinit
autoload -U colors && colors

alias la='ls -FA --color=auto'
# ll()
# {
#     ls -Flh  --color=always "$@" | less -FXRS
# }
# lla()
# {
#     ls -FlhA --color=always "$@" | less -FXRS
# }
alias ls='ls -F  --color=auto'
alias ..='cd ..'
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

PROMPT="%{$fg_bold[red]%}%n%{$reset_color%} %Bat%b %{$fg_bold[yellow]%}%m%{$reset_color%} %(?..%{$fg_bold[red]%}err:%?%{$reset_color%} )%{$fg_bold[magenta]%}%!%{$reset_color%}
%{$fg_bold[green]%}%~%{$reset_color%}%{$fg_bold[yellow]%}%#%{$reset_color%} "
