#!/bin/bash

script_dir=$(
    cd $(dirname ${BASH_SOURCE:-$0})
    pwd
)


ssh-keygen -t ed25519
gh auth login
.$script_dir/install_mplus1mn.sh
sudo cp $script_dir/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf
localectl set-x11-keymap jp