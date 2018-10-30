#!/bin/bash

printf "password: "
read password
echo "$password" | sudo -S pacman -Syu
echo "$password" | sudo -S pacman -S alacritty neovim yay-bin
echo "$password" | sudo -S pip install neovim
mkdir $HOME/.config/nvim
cp ./nvim/ $HOME/.config/nvim/
cd $HOME
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein

