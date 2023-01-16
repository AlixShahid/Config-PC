#!/bin/bash

echo "coping config files.."
cp -rf alacritty wezterm dunst rofi bspwm polybar sxhkd zsh eww hypr waybar ~/.config/

echo "setting-up zsh"
ln ~/.config/zsh/.zshrc ~/.zshrc

echo "coping keyd config to /etc/keyd"
sudo cp ./keyd/default.conf /etc/keyd/
