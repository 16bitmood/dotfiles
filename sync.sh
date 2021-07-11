#!/bin/bash
CONFIG_DIR=${HOME}/main/src/dotfiles

rsync -r ${CONFIG_DIR}/.config ${HOME}/.config
rsync -r ${CONFIG_DIR}/.emacs.d ${HOME}/.emacs.d
rsync -r ${CONFIG_DIR}/.Xresources.d ${HOME}/.Xresources.d

# rsync -r ${CONFIG_DIR}/awesomewm/ ${HOME}/.config/awesome/
# rsync -r ${CONFIG_DIR}/berry/     ${HOME}/.config/berry/
# rsync -r ${CONFIG_DIR}/emacs/     ${HOME}/.emacs.d/
# rsync -r ${CONFIG_DIR}/nvim/      ${HOME}/.config/nvim/
# rsync ${CONFIG_DIR}/emacs/emacs.service ${HOME}/.config/systemd/user/emacs.service

# rsync ${CONFIG_DIR}/misc/.bashrc                   ${HOME}/.bashrc
# rsync ${CONFIG_DIR}/misc/.xinitrc                  ${HOME}/.xinitrc
# rsync ${CONFIG_DIR}/misc/rofi.rasi                 ${HOME}/.config/rofi/config.rasi
# rsync ${CONFIG_DIR}/misc/picom.conf                ${HOME}/.config/picom.conf
# rsync ${CONFIG_DIR}/misc/alacritty.yml             ${HOME}/.config/alacritty.yml
# rsync -r ${CONFIG_DIR}/misc/startup_script.desktop ${HOME}/.config/autostart/
# rsync ${CONFIG_DIR}/misc/gtk.css                   ${HOME}/.config/gtk-3.0/gtk.css
