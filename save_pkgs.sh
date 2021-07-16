#!/bin/bash
script_dir=$(
    cd $(dirname ${BASH_SOURCE:-$0})
    pwd
)
yay -Qqe >$script_dir/pkg_list.txt
