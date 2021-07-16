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
	if [[ -e ~/wallpapers ]] || [[ -L ~/wallpapers ]]; then
		rm -rf ~/wallpapers
	fi
}

function place_common_config() {
	ln -s $script_dir/alacritty ~/.config/alacritty
	ln -s $script_dir/dunst ~/.config/dunst
	ln -s $script_dir/profile ~/.profile
	ln -s $script_dir/gitconfig ~/.gitconfig
	ln -s $script_dir/wallpapers ~/wallpapers
}

function place_xmonad_config() {
	ln -s $script_dir/xmobarrc ~/.xmobarrc
	ln -s $script_dir/xmonad ~/.xmonad
	place_common_config
}

function place_i3_config() {
	ln -s $script_dir/i3 ~/.config/i3
	ln -s $script_dir/i3status ~/.config/i3status
	ln -s $script_dir/i3blocks ~/.config/i3blocks
	place_common_config
}

whiptail --yesno "このスクリプトを実行することにより、このスクリプトと衝突する既存の設定ファイルが破壊されます。続けますか？" 20 60
if [ "$?" = 1 ]; then
	exit
fi

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

clean_configs

choice=$(whiptail --menu "どの構成を使いますか？" 0 0 10 0 "i3+i3blocks" 1 "xmonad+xmobar" 3>&1 1>&2 2>&3)
case "$choice" in
0) place_i3_config ;;
1) place_xmonad_config ;;
esac

whiptail --yesno "GitHubのSSH設定、M+ 1mnのインストール、タッチパッドの設定、キーボードの設定を行いますか？" 20 60
if [ "$?" = 0 ]; then
	sh $script_dir/after_place.sh
fi
