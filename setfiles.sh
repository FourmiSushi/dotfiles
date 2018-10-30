#!/bin/bash

printf "password: "
read password
echo "$password" | sudo -S pacman -Syu
echo "$password" | sudo -S pacman -S alacritty neovim yay-bin
echo "$password" | sudo -S pip install neovim

mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/termite
\cp -f ./nvim/ $HOME/.config/nvim/
\cp -f ./termite/ $HOME/.config/termite
cd $HOME
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein

