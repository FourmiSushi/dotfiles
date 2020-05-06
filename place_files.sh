#!/bin/bash

script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

function clean_before_install() {
	if [[ -e ~/.config/alacritty/alacritty.yml ]] || [[ -L ~/.config/alacritty/alacritty.yml ]]; then
		rm -rf ~/.config/alacritty/alacritty.yml
	fi
	if [[ -e ~/.config/dunst/dunstrc ]] || [[ -L ~/.config/dunst/dunstrc ]]; then
		rm -rf ~/.config/dunst/dunstrc
	fi
	if [[ -e ~/.xmobarrc ]] || [[ -L ~/.xmobarrc ]]; then
		rm -rf ~/.xmobarrc
	fi
	if [[ -e ~/.xmonad/xmonad.hs ]] || [[ -L ~/.xmonad/xmonad.hs ]]; then
		rm -rf ~/.xmonad/xmonad.hs
	fi
}

function make_dir_if_not_exists() {
	if [[ ! -d ~/.config/alacritty ]]; then
		mkdir -p ~/.config/alacritty
	fi
	if [[ ! -d ~/.config/dunst ]]; then
		mkdir -p ~/.config/dunst
	fi
	if [[ ! -d ~/.xmonad ]]; then
		mkdir -p ~/.xmonad
	fi
}

read -p "Clean before installing dotfiles? (y/N):" yn
case "$yn" in
	[yY]*) clean_before_install;;
esac

make_dir_if_not_exists

ln -s $script_dir/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s $script_dir/dunstrc ~/.config/dunst/dunstrc
ln -s $script_dir/xmobarrc ~/.xmobarrc
ln -s $script_dir/xmonad.hs ~/.xmonad/xmonad.hs
