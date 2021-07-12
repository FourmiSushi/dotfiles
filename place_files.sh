#!/bin/bash

script_dir=$(
	cd $(dirname ${BASH_SOURCE:-$0})
	pwd
)

function clean_configs() {
	if [[ -e ~/.config/alacritty ]] || [[ -L ~/.config/alacritty ]]; then
		rm -rf ~/.config/alacritty
	fi
	if [[ -e ~/.config/dunst ]] || [[ -L ~/.config/dunst ]]; then
		rm -rf ~/.config/dunst
	fi
	if [[ -e ~/.xmobarrc ]] || [[ -L ~/.xmobarrc ]]; then
		rm -rf ~/.xmobarrc
	fi
	if [[ -e ~/.xmonad ]] || [[ -L ~/.xmonad ]]; then
		rm -rf ~/.xmonad
	fi
	if [[ -e ~/.config/i3 ]] || [[ -L ~/.config/i3 ]]; then
		rm -rf ~/.config/i3
	fi
	if [[ -e ~/.config/i3status ]] || [[ -L ~/.config/i3status ]]; then
		rm -rf ~/.config/i3status
	fi
	if [[ -e ~/.config/i3blocks ]] || [[ -L ~/.config/i3blocks ]]; then
		rm -rf ~/.config/i3blocks
	fi
	if [[ -e ~/.profile ]] || [[ -L ~/.profile ]]; then
		rm -rf ~/.profile
	fi
	if [[ -e ~/.gitconfig ]] || [[ -L ~/.gitconfig ]]; then
		rm -rf ~/.gitconfig
	fi
}

function place_xmonad_config() {
	ln -s $script_dir/xmobarrc ~/.xmobarrc
	ln -s $script_dir/xmonad ~/.xmonad
}

function place_i3_config() {
	ln -s $script_dir/i3 ~/.config/i3
	ln -s $script_dir/i3status ~/.config/i3status
	ln -s $script_dir/i3blocks ~/.config/i3blocks
}

pacman -Qqe yay-bin >/dev/null
if [ "$?" = 1 ]; then
	whiptail --yesno "yayがインストールされていません。インストールしますか？" 20 60
	if [ "$?" = 0 ]; then
		sh $script_dir/install_yay.sh
	fi
fi

whiptail --yesno "パッケージをインストールしますか？" 20 60
if [ "$?" = 0 ]; then
	sh $script_dir/install_pkgs.sh
fi

whiptail --yesno "すでにある設定ファイルを削除しますか？" 20 60
if [ "$?" = 0 ]; then
	clean_configs
fi

choice=$(whiptail --menu "どの構成を使いますか？" 0 0 10 0 "i3+i3blocks" 1 "xmonad+xmobar" 3>&1 1>&2 2>&3)
case "$choice" in
0) place_i3_config ;;
1) place_xmonad_config ;;
*) place_i3_config ;;
esac

ln -s $script_dir/alacritty ~/.config/alacritty
ln -s $script_dir/dunst ~/.config/dunst
ln -s $script_dir/profile ~/.profile
ln -s $script_dir/gitconfig ~/.gitconfig
