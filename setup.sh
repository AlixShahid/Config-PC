#!/bin/bash

bash ./install-packages.sh

echo "coping config files.."
mkdir ~/.config/vicinae
cp -rf niri DankMaterialShell\
	./vicinae/vicinae.json\
	alacritty wezterm dunst rofi bspwm polybar sxhkd zsh eww hypr waybar\
	~/.config/

mkdir ~/.local/share/vicinae
cp ./vicinae/vicinae.db ~/.local/share/vicinae/

echo "coping keyd config to /etc/keyd"
sudo cp ./keyd/default.conf /etc/keyd/


echo "setting-up zsh"
ln ~/.config/zsh/.zshrc ~/.zshrc

systemctl --user add-wants niri.service dms

dms greeter enable
dms greeter sync
