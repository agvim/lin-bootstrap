#!/bin/bash
. "$(dirname $0)/lib/package_tests.sh"

# cfg-xfce4-terminal and cfg-xfce4-desktop are not properly interpreted as
# github paths
github="https://github.com"

# get homeshick
git clone $github/agvim/homeshick.git $HOME/.homesick/repos/homeshick
homeshick="yes | $HOME/.homesick/repos/homeshick/bin/homeshick"

# clone the basic castles
eval $homeshick clone $github/agvim/cfg-bash
eval $homeshick clone $github/agvim/cfg-tmux
eval $homeshick clone $github/agvim/cfg-vim

# if zsh is installed personalize it like bash
is_installed zsh
if [[ $? -eq 1 ]]
then
    eval $homeshick clone $github/agvim/cfg-zsh
fi

# if we have xfce4-terminal, clone the xfce4 castle
is_installed xfce4-terminal
if [[ $? -eq 1 ]]
then
    eval $homeshick clone $github/agvim/cfg-xfce4-terminal
fi

eval $homeshick link
echo "Finished homesick configuration"
