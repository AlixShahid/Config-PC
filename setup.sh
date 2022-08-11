#!/bin/bash

echo "coping config files.."
cp -rf alacritty dunst rofi bspwm polybar sxhkd zsh ~/.config/

echo "setting-up zsh"
ln ~/.config/zsh/.zshrc ~/.zshrc

echo "coping keyd config to /etc/keyd"
sudo cp ./keyd/default.conf /etc/keyd/
