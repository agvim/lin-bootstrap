#!/bin/bash
. "$(dirname $0)/lib/package_tests.sh"

if [ `whoami` = 'root' ]
then
    apt='apt'
else
    apt='sudo apt'
fi

# always useful packages
PACKAGES="tmux vim"

# stuff for vim in a desktop machine
PACKAGES="$PACKAGES git exuberant-ctags silversearcher-ag"

# zsh shell
PACKAGES="$PACKAGES zsh"

# throw in gvim if we have x11 installed
is_installed x11-common
if [[ $? -eq 1 ]]
then
    PACKAGES="$PACKAGES vim-gtk fonts-firacode"
fi

# # all this is installed by default now
# is_installed xfce4-panel
# if [[ $? -eq 1 ]]
# then
#     PACKAGES="$PACKAGES xfce4-systemload-plugin xfce4-netload-plugin xfce4-places-plugin"
# fi

# use apt to install the basic packages
$apt update
$apt install -y $PACKAGES
