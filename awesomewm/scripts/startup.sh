################################################################
# Variables
## MY_LOCATION,etc.
source ~/.config/awesome/scripts/bash_env.sh
################################################################
# Keybinds
## swap left_alt and super
setxkbmap -option altwin:swap_alt_win
xset r rate 300 50

# xmodmap -e "remove Mod4 = Hyper_L" -e "add Mod3 = Hyper_L"
# xmodmap -e "keysym Caps_Lock = Hyper_L"

## Remap caps to esc
setxkbmap -option caps:escape

## Remap Left-Ctrl->Hyper and CapsLock->Left-Ctrl 
#xmodmap ~/.config/awesome/scripts/hyper_caps &

# Swap Left Control and Caps Lock
# setxkbmap -option ctrl:swapcaps &
################################################################
# Generates a cache file of binaries in $PATH (on bash)
compgen -c > ${1}/listbinaries
################################################################
# Tools 
## compositor
picom -b --config ~/.config/picom.conf &
## File manager daemon
thunar --daemon &
## Redshift: Adjusts color temperature at night
if [ "$(pgrep redshift)" == '' ]; then
    redshift -l $MY_LOCATION &
fi
## NetworkManager applet
nm-applet &
## Screenshot tool
flameshot &
