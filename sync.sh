CONFIG_DIR=${HOME}/main/config

rsync -r ${CONFIG_DIR}/awesomewm/ ${HOME}/.config/awesome/
# rsync -r ${CONFIG_DIR}/mpv/       ${HOME}/.config/mpv/
rsync -r ${CONFIG_DIR}/emacs/     ${HOME}/.emacs.d/


rsync ${CONFIG_DIR}/misc/neofetch.conf ${HOME}/.config/neofetch/config.conf
rsync ${CONFIG_DIR}/misc/.bashrc       ${HOME}/.bashrc

# rsync ${CONFIG_DIR}/misc/ranger.conf ${HOME}/.config/ranger/rc.conf
rsync ${CONFIG_DIR}/misc/picom.conf ${HOME}/.config/picom.conf
