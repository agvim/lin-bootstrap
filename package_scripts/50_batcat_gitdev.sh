#!/bin/bash

# $ curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/sharkdp/bat/releases/latest | sed -r 's/[^0-9]+//'
# 0.18.3
BAT_VERSION=$(curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/sharkdp/bat/releases/latest | sed -r 's/[^0-9]+//')

check_if_installed () {
    # $ bat --version
    # bat 0.19.0 (59a8f58)
    LOCAL_VERSION=$(which bat > /dev/null && bat --version | cut -d' ' -f 2)
    if [[ "$LOCAL_VERSION" == "$BAT_VERSION" ]]; then
        return 0
    else
        return 1
    fi
}

install(){
    wget "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb" -O /tmp/bat_${BAT_VERSION}_amd64.deb &&
        sudo dpkg -i /tmp/bat_${BAT_VERSION}_amd64.deb

    return $?
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
