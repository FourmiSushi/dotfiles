#!/bin/bash

git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
rm -rf yay-bin
