# Old script
mkdir -p .temp/icons
mkdir -p .temp/icons

TO_STORE_DIR="/home/gts/.config/awesome/.temp/icons/"

cd assets/icons

DARK=$(xrdb -query | grep -i \*.color0 | awk -F ' ' '{print $2}')
LIGHT=$(xrdb -query | grep -i \*.color15 | awk -F ' ' '{print $2}')
echo $DARK
echo $LIGHT

for ICON in *
    do
        echo $ICON
        convert $ICON -fill "$DARK"  -opaque white  $TO_STORE_DIR$ICON.dark.png
        convert $ICON -fill "$LIGHT" -opaque white  $TO_STORE_DIR$ICON.light.png
    done