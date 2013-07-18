#!/bin/bash
. "$(dirname $0)/lib/package_tests.sh"

#get homeshick
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
homeshick="yes | $HOME/.homesick/repos/homeshick/homeshick.sh"

#clone the basic castles
$homeshick clone agvim/cfg-bash
$homeshick clone agvim/cfg-tmux
$homeshick clone agvim/cfg-vim

#if we have xfce4-terminal, clone the xfce4 castle
is_installed xfce4-terminal
if [[ $? -eq 1 ]]
then
    $homeshick clone agvim/cfg-xfce4-terminal
fi

#if we have xfce4 panel, clone the desktop castle
is_installed xfce4-panel
if [[ $? -eq 1 ]]
then
    $homeshick clone agvim/cfg-xfce4-desktop
fi

$homeshick link
echo "Finished homesick configuration"

#$HOME/.spf13-vim-agvim/bootstrap.sh
#echo "Finished vim configuration"
