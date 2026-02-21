#!/bin/bash

echo "Stow ---------------------------------------------------------------"

# sudo apt install -y eza stow starship
sudo apt install -y eza stow

rm ~/.bashrc

cd ~/.dotfiles

echo "-------"

stow alacritty
stow wezterm
stow astro
stow bash
stow htop
stow suckless
stow git
stow lazygit
stow Thunar
stow vimbtw
stow xarchiver
stow xinit
stow fzfrc
stow gtk-3.0
# stow starship
# stow i3
# stow dk
# stow bspwm
# stow sway

cd ~

