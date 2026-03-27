#!/bin/bash

echo "install packages ---------------------------------------------------"

sudo pacman -Sy stow bitwarden geany wget xarchiver

echo "Stow ---------------------------------------------------------------"

cd ~/.dotfiles-omarchy/
mkdir -p ~/.config/_BKP
mv ~/.config/alacritty ~/.config/_BKP/
mv ~/.config/btop ~/.config/_BKP/
mv ~/.config/fastfetch ~/.config/_BKP/
mv ~/.config/geany ~/.config/_BKP/
mv ~/.config/hypr ~/.config/_BKP/
mv ~/.config/nvim ~/.config/_BKP/
mv ~/.config/waybar ~/.config/_BKP/

stow config/

cp ~/.bashrc ~/.bashrc.bkp && stow home/

cd ~ && ./.ssh/fix_ssh_permission.sh

echo "copy docker -------------------------------------------------------"

cp ~/.dotfiles-omarchy/docker/local-wordpress-minimal/ ~/Work/local-wordpress-minimal/

