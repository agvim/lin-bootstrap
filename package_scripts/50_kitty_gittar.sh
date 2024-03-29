#!/bin/bash

# $ curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/kovidgoyal/kitty/releases/latest | sed -r 's/[^0-9]+//'
# 0.23.1%
KITTY_VERSION=$(curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/kovidgoyal/kitty/releases/latest | sed -r 's/[^0-9]+//')
INSTALL_PATH="$HOME/.local/kitty.app"

check_if_installed () {
    LOCAL_VERSION=$(which kitty > /dev/null && kitty --version | cut -d' ' -f 2)
    [[ "$LOCAL_VERSION" == "$KITTY_VERSION" ]]
}

install(){
    rm -rf "$INSTALL_PATH/*"
    mkdir -p "$INSTALL_PATH"
    wget --no-verbose "https://github.com/kovidgoyal/kitty/releases/download/v${KITTY_VERSION}/kitty-${KITTY_VERSION}-x86_64.txz" -O "/tmp/kitty_${KITTY_VERSION}_x86_64.txz" &&
        tar -C "$INSTALL_PATH" -xJof "/tmp/kitty_${KITTY_VERSION}_x86_64.txz" &&
        ln -s -f "$INSTALL_PATH/bin/kitty" "$HOME/.local/bin/kitty" &&
        cp "$INSTALL_PATH/share/applications/kitty.desktop" "$HOME/.local/share/applications/"
}

case "$1" in
    "install" )
        if check_if_installed; then
            exit 0
        else
            sudo apt-get install -y libxcb-xkb1 && install
        fi;;
    "update")
        if check_if_installed; then
            echo "no update needed"
            exit 0
        else
            install
        fi;;
esac
