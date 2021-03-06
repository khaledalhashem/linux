#!/bin/bash

touch .bashrc
tee .bashrc <<EOF

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

EOF

touch .tmux.conf
tee .tmux.conf <<EOF

# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# reload config file (change file location to your the tmux.conf you want to use)
bind r source-file ~/.tmux.conf

EOF

touch firewall.sh
tee firewall.sh <<EOF

#!/bin/bash
#
# iptables example configuration script
#
# Flush all current rules from iptables
#
 iptables -F
#
# Allow SSH connections on tcp port 22
# This is essential when working on remote servers via SSH to prevent locking yourself out of the system
#
#SSH
 iptables -A INPUT -p tcp --dport 22 -j ACCEPT
 #HTTP
 iptables -A INPUT -p tcp --dport 80 -j ACCEPT
#HTTPS
 iptables -A INPUT -p tcp --dport 443 -j ACCEPT
#SQUID
#  iptables -A INPUT -p tcp --dport 3128 -j ACCEPT
#SQUID-HTTPS
#  iptables -A INPUT -p tcp --dport 3129 -j ACCEPT
#ZNC
#  iptables -A INPUT -p tcp --dport 1337 -j ACCEPT
#Ident
#  iptables -A INPUT -p tcp --dport 113 -j ACCEPT
#FTP
# iptables -A INPUT -p tcp --dport 20 -j ACCEPT
# iptables -A INPUT -p tcp --dport 21 -j ACCEPT
# This enables passive mode and restricts it to using the eleven ports for data connections. This is useful as you need to open these ports on your firewall.
#  iptables -A INPUT -p tcp --dport 10090:10100 -j ACCEPT
#VPN
# iptables -A INPUT -p udp --dport 1194 -j ACCEPT
# iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE

#openvpn OpenVZ iptables. That is to route the traffic from tun0 to the interface that provides internet (venet0:0 by default).
#csf configuration  copy and paste the below into -- /etc/csf/csfpre.sh -- csf -r
# iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -j SNAT -to-source 192.161.179.243
# iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
# iptables -A FORWARD -s 10.8.0.0/24 -j ACCEPT
# iptables -A FORWARD -j REJECT
# iptables -t nat -A POSTROUTING  -s 10.8.0.0/24 -o venet0 -j SNAT --to-source 172.93.54.35
#
# Set default policies for INPUT, FORWARD and OUTPUT chains
#
 iptables -P INPUT DROP
 iptables -P FORWARD DROP
 iptables -P OUTPUT ACCEPT
#
#
# Accept packets belonging to established and related connections
#
 iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#ping
 iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT 
#
#Limit SSH connections to no more than 10 per minute. After 10 connecitons (or attempts), new incoming connections from that IP are dropped.
 iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 3 --rttl --name SSH -j DROP
 iptables -A INPUT -p tcp --dport 28 -m state --state NEW -m recent --update --seconds 60 --hitcount 3 --rttl --name SSH -j DROP
# iptables -A INPUT -p udp --dport 1194 -m state --state NEW -m recent --update --seconds 60 --hitcount 3 --rttl --name opevnpn -j DROP

#SPAM Banned IP Addresses

# iptables -D INPUT -s xx.xxx.xx.xx -j DROP
#
# Save settings
#
/sbin/service iptables save
# /sbin/service ip6tables save
#  iptables-save
#
# List rules
#
 iptables -L -v
# now make the script executable
# chmod +x myfirewall

# simply exit the script and run it from the shell with the following command:
# ./myfirewall

# Accept packets from trusted IP addresses
# iptables -A INPUT -s 192.168.0.4 -j ACCEPT # change the IP address as appropriate

# Accept packets from trusted IP addresses
# iptables -A INPUT -s 192.168.0.0/24 -j ACCEPT  # using standard slash notation
# iptables -A INPUT -s 192.168.0.0/255.255.255.0 -j ACCEPT # using a subnet mask

# Accept packets from trusted IP addresses
# iptables -A INPUT -s 192.168.0.4 -m mac --mac-source 00:50:8D:FD:E6:32 -j ACCEPT

# Accept tcp packets on destination port 6881 (bittorrent)
# iptables -A INPUT -p tcp --dport 6881 -j ACCEPT

# Accept tcp packets on destination ports 6881-6890
# iptables -A INPUT -p tcp --dport 6881:6890 -j ACCEPT

# https://wiki.centos.org/HowTos/Network/IPTables

EOF
