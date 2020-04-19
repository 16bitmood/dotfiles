################################################################################
#
# ~/.bashrc
#
################################################################################
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# 
################################################################################
# Aliases
alias ls='ls --color=auto'
alias lsp='fd -d 1' # Easily parsable `ls`

alias cdi='cd $(fd -d 1 -t d | fzf)'
alias fetch='neofetch --w3m'

## Editor shortcuts
alias cof='code $(fd -E ".git/*" -H -t f | fzf)' # Add option for exits and such
alias cod='code $(fd -E ".git/*" -H -t d | fzf)' # 

#
################################################################################
# Random Stuff
PATH=$PATH:/home/gts/.local/bin
PS1='[\w] >> '