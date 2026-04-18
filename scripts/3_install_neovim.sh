#!/bin/bash

echo "- Install Neovim and others ---------------------------------------------"
sudo pacman -Sy neovim python3 go rust cargo ripgrep lua51 luarocks python-pip python3 python-pynvim viu chafa ueberzugpp

#pip
# pip install neovim vim-vint --break-system-packages
# [vim-vint]  WARNING: The script pynvim-python is installed in '/home/sd/.local/bin' which is not on PATH.
# Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.

echo "- fix neovim clipboard -------------------------------------------------"
sudo pacman -Sy wl-clipboard

echo "- Install NPM packages --------------------------------------------------"
npm i -g neovim tree-sitter-cli
npm i -g typescript typescript-language-server

