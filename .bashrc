#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias fetch='neofetch --w3m'
PATH=$PATH:/home/gts/.local/bin

alias ls='ls --color=auto'
PS1='[\W] >> '

# My main directory
# cd $HOME/main