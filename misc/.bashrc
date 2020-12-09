################################################################################
#
# ~/.bashrc
#
################################################################################
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# 
################################################################################
# Vi Mode
set -o vi
# Aliases
alias fetch='neofetch --w3m'

function reload-emacs() {
    systemctl --user stop emacs
    systemctl --user start emacs
    notify-send "Reloading Emacs!"
}

function sudo-sync-mirrors() {
    sudo reflector --verbose --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
}
#
################################################################################
# Random Stuff
PATH=$PATH:/home/gts/.local/bin
PS1='[\w] >> '
