# pywal change wallpaper and colorscheme
## why do it like this? because I don't understand 
## how awesomewm works :(
WALLPAPER=$1
wal -i $WALLPAPER && \
mv ~/.cache/wal/colors.Xresources ~/.Xresources && \
echo "#include \".Xresources.d/urxvt\"" >> ~/.Xresources && \
xrdb -merge .Xresources