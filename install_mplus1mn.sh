#!/bin/bash

mkdir mplus
cd mplus
wget https://gist.githubusercontent.com/FourmiSushi/a5369e46bb35e4937160e7f1026a756f/raw/019eec7d5b44b353dab6d4b10a9efb916253e6e6/PKGBUILD
makepkg -si
cd ..
rm -rf mplus