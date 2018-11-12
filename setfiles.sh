#!/bin/bash

read -sp "Password: " password
echo "$password" | sudo -S pacman -Syu --noconfirm
echo "$password" | sudo -S pacman -S alacritty neovim --noconfirm
echo "$password" | sudo -S pacman -Rs variety --noconfirm
echo "$password" | sudo -S pip install neovim

mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/termite
\cp -rf ./config/* $HOME/.config/
cd $HOME
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein

