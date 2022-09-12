#!/bin/bash

# $ curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/neovide/neovide/releases/latest  | sed -r 's/[^0-9]+//'
# 0.10.1
NEOVIDE_VERSION=$(curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/neovide/neovide/releases/latest | sed -r 's/[^0-9]+//')

check_if_installed () {
    # $ neovide --version
    # Neovide 0.10.1
    LOCAL_VERSION=$(which neovide > /dev/null && neovide --version | cut -d' ' -f 2)
    [[ "$LOCAL_VERSION" == "$NEOVIDE_VERSION" ]]
}

install(){
    wget --no-verbose "https://github.com/neovide/neovide/releases/download/${NEOVIDE_VERSION}/neovide.tar.gz" -O "/tmp/neovide_${NEOVIDE_VERSION}.tgz" &&
        tar -C "$HOME/.local/bin" -xzof "/tmp/neovide_${NEOVIDE_VERSION}.tgz"
}

case "$1" in
    "install" | "update" )
        if check_if_installed; then
            echo "no update needed"
            exit 0
        else
            install
        fi;;
        # ! check_if_installed && install ;;
esac
