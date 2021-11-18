#!/bin/bash

# $ curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/kovidgoyal/kitty/releases/latest | sed -r 's/[^0-9]+//'
# 0.23.1%
KITTY_VERSION=$(curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/kovidgoyal/kitty/releases/latest | sed -r 's/[^0-9]+//')
INSTALL_PATH="$HOME/.local/kitty.app"

check_if_installed () {
    LOCAL_VERSION=$(kitty --version | sed -r 's/[^0-9]*//; s/ created by Kovid Goyal//')
    if [[ "$LOCAL_VERSION" == "$KITTY_VERSION" ]]; then
        return 0
    else
        return 1
    fi
}

install(){
    rm -rf "$INSTALL_PATH/*"
    wget "https://github.com/kovidgoyal/kitty/releases/download/v${KITTY_VERSION}/kitty-${KITTY_VERSION}-x86_64.txz" -O /tmp/kitty_${KITTY_VERSION}_x86_64.txz &&
        tar -C "$INSTALL_PATH" -xJof "/tmp/kitty_${KITTY_VERSION}_x86_64.txz" &&
        ln -s -f "$INSTALL_PATH/bin/kitty" ".local/bin/kitty"

    return $?
}

case "$1" in
    "install" ) ! check_if_installed && install ;;
    "update" ) ! check_if_installed && install ;;
esac
