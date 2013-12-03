#!/bin/bash
. "$(dirname $0)/lib/package_tests.sh"

if [ `whoami` = 'root' ]
then
    aptget='apt-get'
    aptitude='aptitude'
else
    aptget='sudo apt-get'
    aptitude='sudo aptitude'
fi

#install aptitude first
$aptget update
$aptget install -y aptitude

#allways used packages
PACKAGES="bash tmux git vim exuberant-ctags ack-grep fonts-inconsolata"

#throw in gvim if we have x11 installed
is_installed x11-common
if [[ $? -eq 1 ]]
then
    PACKAGES="$PACKAGES vim-gtk"
fi

#if we have xfce4 panel, install the panel plugins and orage calendar
is_installed xfce4-panel
if [[ $? -eq 1 ]]
then
    PACKAGES="$PACKAGES xfce4-systemload-plugin xfce4-netload-plugin xfce4-places-plugin orage"
fi

#use aptitude to install the basic packages
$aptitude update
$aptitude install -y $PACKAGES
