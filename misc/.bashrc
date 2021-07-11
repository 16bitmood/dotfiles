################################################################################
#
# ~/.bashrc
#
################################################################################
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

################################################################################
HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000
################################################################################
shopt -s checkwinsize
################################################################################
# Aliases
alias c='clear'

alias fetch='neofetch --w3m'
alias eo='emacsclient -n'

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias py='python3'

################################################################################
# Functions
function reload-emacs() {
    systemctl --user stop emacs
    systemctl --user start emacs
    notify-send "Reloading Emacs!"
}

function sudo-sync-mirrors() {
    sudo reflector --verbose --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
}

################################################################################
# Random Stuff
PATH=$PATH:/home/gts/.local/bin
PS1='[\w] >> '
################################################################################
# Colors

if command -v wal &> /dev/null
then
    wal -qR && clear 
fi
################################################################################
# Inside Vim

vit()
{
    if [[ ! -z "$NVIM_LISTEN_ADDRESS" ]]; then
        if [ $# -eq 0 ]; then
            echo "You are already inside Vim. Provide filenames as arguments"
        else
            nvr --remote $@
        fi
    else
        nvim $@
    fi
}

alias nvim=vit
alias vim=vit
alias vi=vit
