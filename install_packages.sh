#!/bin/bash
SCRIPT_PATH=$(dirname $0)
homeshick="$HOME/.homesick/repos/homeshick/bin/homeshick"
IFS='
'
APPIMAGES_UPDATEABLE_FOLDER="$HOME/.local/appimages/updateable"
if [ `whoami` = 'root' ]
then
    apt='apt-get'
else
    apt='sudo apt-get'
fi

function print_header {
    # the header in bold yellow underlined with ======
    printf -v spaces "%*s" ${#1} " "
    printf "\n\033[1;33m%s\n%s\033[0m\n\n" "$1" "${spaces// /=}"
}

install () {
    # try to install the manually downloaded packages for the current user
    for F in $(find "$SCRIPT_PATH/package_scripts" -name '*.sh' | sort) ; do
        print_header "install $(basename $F)"
        eval "$F" install
    done


    # system packages
    # always useful packages
    PACKAGES="tmux vim"

    # stuff for vim/neovim
    PACKAGES="$PACKAGES git universal-ctags ripgrep"

    # stuff for neovim
    PACKAGES="$PACKAGES xsel python3-pip"

    # zsh shell
    PACKAGES="$PACKAGES zsh"

    # use apt to install the basic packages
    print_header "install system packages"
    eval $apt update && eval $apt install -y $PACKAGES

    # neovim python bindings
    print_header "install python3 neovim bindings"
    pip3 install pynvim

    # homeshick
    print_header "install homeshick and configurations"
    git clone https://github.com/agvim/homeshick.git $HOME/.homesick/repos/homeshick
    eval $homeshick clone https://github.com/agvim/cfg-bash
    # eval $homeshick clone https://github.com/agvim/cfg-vim
    eval $homeshick clone https://github.com/agvim/cfg-nvim
    eval $homeshick clone https://github.com/agvim/cfg-tmux
    eval $homeshick clone https://github.com/agvim/cfg-zsh
    eval $homeshick clone https://github.com/agvim/cfg-kitty
    eval $homeshick clone https://github.com/agvim/cfg-bat
    eval $homeshick link
}

update () {
    print_header "update system packages"
    eval $apt update && eval $apt upgrade && eval $apt autoremove

    # try to update the manually downloaded packages for the current user
    for F in $(find "$SCRIPT_PATH/package_scripts" -name '*.sh' | sort) ; do
        print_header "update $(basename $F)"
        eval "$F" update
    done

    # appimage
    for F in $(find "$APPIMAGES_UPDATEABLE_FOLDER" -iname '*.appimage')
    do
        print_header "appimage update $(basename $F)"
        appimageupdatetool --overwrite --remove-old "$F"
    done

    # neovim python bindings
    print_header "update python3 neovim bindings"
    pip3 install --upgrade pynvim

    # homeshick
    print_header "homeshick update"
    eval $homeshick pull
}

case "$1" in
    "install" ) ! check_if_installed && install ;;
    "update" ) update ;;
esac
