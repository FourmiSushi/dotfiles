#!/bin/bash
script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
yay -Qqen > $script_dir/pkg_list.txt
