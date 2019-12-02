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
PACKAGES="$PACKAGES git exuberant-ctags silversearcher-ag yarnpkg"

# stuff for neovim
PACKAGES="$PACKAGES xsel python3-pip"
pip3 install neovim

# zsh shell
PACKAGES="$PACKAGES zsh"

# use kitty asthe default terminal emulator and use a font with ligatures
is_installed x11-common
if [[ $? -eq 1 ]]
then
    PACKAGES="$PACKAGES fonts-firacode kitty"
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

# make a bin link for yarn
mkdir $HOME/bin
## yarn for coc.vim
ln -s /usr/bin/yarnpkg $HOME/bin/yarn
