#!/bin/bash
SCRIPT_PATH=$(dirname $0)
homeshick="$HOME/.homesick/repos/homeshick/bin/homeshick"
IFS='
'

CHECKMARK='✔'
CROSS='✘'

APPIMAGES_UPDATEABLE_FOLDER="$HOME/.local/appimages/updateable"
if [ `whoami` = 'root' ]
then
    apt='apt-get -q'
else
    apt='sudo apt-get -q'
fi

function print_header {
    # the header in bold yellow underlined with ======
    printf -v spaces "%*s" ${#1} " "
    printf "\n\033[1;33m%s\n%s\033[0m\n\n" "$1" "${spaces// /=}"
}

function print_outcome {
    if [[ $1 -ne 0 ]]; then
        printf "\033[31m$CROSS failed updating %s\033[0m\n" "$2"
    else
        printf "\033[32m$CHECKMARK updated %s\033[0m\n" "$2"
    fi
}

install () {
    # system packages
    print_header "install system packages"
    # always useful packages
    PACKAGES="tmux vim"
    # stuff for vim/neovim
    PACKAGES="$PACKAGES git universal-ctags ripgrep"
    # stuff for neovim
    PACKAGES="$PACKAGES xsel python3-pip"
    # zsh shell
    PACKAGES="$PACKAGES zsh"
    # misc: curl
    PACKAGES="$PACKAGES curl wget"
    # use apt to install the basic packages
    eval $apt update && eval $apt install -y $PACKAGES

    # try to install the manually downloaded packages
    # includes appimageupdatetool and homeshick
    for F in $(find "$SCRIPT_PATH/package_scripts" -name '*.sh' | sort) ; do
        print_header "install $(basename $F)"
        eval "$F" install
    done

    # neovim python bindings
    print_header "install python3 neovim bindings"
    pip3 install pynvim

    # homeshick
    print_header "install homeshick configurations"
    eval $homeshick clone https://github.com/agvim/cfg-bash
    # eval $homeshick clone https://github.com/agvim/cfg-vim
    eval $homeshick clone https://github.com/agvim/cfg-nvim
    eval $homeshick clone https://github.com/agvim/cfg-tmux
    eval $homeshick clone https://github.com/agvim/cfg-zsh
    eval $homeshick clone https://github.com/agvim/cfg-kitty
    eval $homeshick clone https://github.com/agvim/cfg-bat
    eval $homeshick clone https://github.com/agvim/cfg-git
    eval $homeshick link
}

update () {
    print_header "update system packages"
    eval $apt update && eval $apt upgrade -y && eval $apt autoremove -y

    # try to update the manually downloaded packages
    for F in $(find "$SCRIPT_PATH/package_scripts" -name '*.sh' | sort) ; do
        eval "$F" updateable
        if [[ $? -eq 0 ]]; then
            print_header "update $(basename $F)"
            eval "$F" update
            print_outcome $? "$(basename $F)"
        fi
    done

    # appimage
    for F in $(find "$APPIMAGES_UPDATEABLE_FOLDER" -iname '*.appimage')
    do
        print_header "appimage update $(basename $F)"
        appimageupdatetool --overwrite --remove-old "$F"
        print_outcome $? "$(basename $F)"
    done

    # neovim python bindings
    print_header "update python3 neovim bindings"
    pip3 install --upgrade pynvim
    print_outcome $? "neovim python bindings"

    # homeshick
    print_header "homeshick update"
    eval $homeshick pull
    print_outcome $? "homeshick castles"
}

case "$1" in
    "install" ) install ;;
    "update" ) update ;;
esac
