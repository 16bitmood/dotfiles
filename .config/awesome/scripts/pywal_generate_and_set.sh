# pywal change wallpaper and colorscheme
## why do it like this? because I don't understand 
## how awesomewm works :(
WALLPAPER=$1
THEME=$2

if [-z $THEME]
then
    wal -i $WALLPAPER
else
    feh --bg-max $WALLPAPER
    # feh --bg-max --randomize $(dirname $WALLPAPER)
    wal --theme $THEME
fi

cp ~/.cache/wal/colors.Xresources ~/.Xresources
echo "#include \".Xresources.d/urxvt\"" >> ~/.Xresources
xrdb -merge .Xresources
