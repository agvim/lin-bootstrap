#!/bin/bash
. "$(dirname $0)/lib/package_tests.sh"

#get homeshick
git clone https://github.com/agvim/homeshick.git $HOME/.homesick/repos/homeshick
homeshick="yes | $HOME/.homesick/repos/homeshick/homeshick.sh"

#clone the basic castles
eval $homeshick clone agvim/cfg-bash
eval $homeshick clone agvim/cfg-tmux
eval $homeshick clone agvim/cfg-vim

#if we have xfce4-terminal, clone the xfce4 castle
is_installed xfce4-terminal
if [[ $? -eq 1 ]]
then
    eval $homeshick clone agvim/cfg-xfce4-terminal
fi

#if we have xfce4 panel, clone the desktop castle
is_installed xfce4-panel
if [[ $? -eq 1 ]]
then
    eval $homeshick clone agvim/cfg-xfce4-desktop
fi

eval $homeshick link
echo "Finished homesick configuration"
