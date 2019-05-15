# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# some more ls aliases
#alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'

# Aliases
alias ll="ls -lhA --color"
alias ls="ls -CF --color"
alias sl="ls"
alias lsl="ls -lhFA | less"
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -ht"
alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
#psg bash

alias vi=vim
alias svi='sudo vim'

alias ping='ping -c 3'
alias ping6='ping6 -c 3'

alias updatey='sudo yum -y update'

alias reboot='sudo shutdown -r now'
alias shutdown='sudo shutdown -h now'
