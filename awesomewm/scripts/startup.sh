################################################################
# Variables
## MY_LOCATION,etc.
source ~/.config/awesome/scripts/bash_env.sh
################################################################
# Keybinds
## swap left_alt and super
setxkbmap -option altwin:swap_alt_win
## Remap caps to esc
setxkbmap -option caps:escape

# Swap Left Control and Caps Lock
# setxkbmap -option ctrl:swapcaps &
################################################################
# Tools 
## compositor
picom -b &
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