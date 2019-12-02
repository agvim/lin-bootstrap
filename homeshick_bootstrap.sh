#!/bin/bash
. "$(dirname $0)/lib/package_tests.sh"

# get homeshick
git clone https://github.com/agvim/homeshick.git $HOME/.homesick/repos/homeshick
homeshick="yes | $HOME/.homesick/repos/homeshick/bin/homeshick"

# clone the basic castles
homeshick_if_installed bash
homeshick_if_installed vim
homeshick_if_installed tmux

# if zsh is installed personalize it like bash
homeshick_if_installed zsh

# terminal emulators
homeshick_if_installed xfce4-terminal
homeshick_if_installed kitty

eval $homeshick link
echo "Finished homesick configuration"
