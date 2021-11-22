#!/bin/bash

# $ curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/sharkdp/bat/releases/latest | sed -r 's/[^0-9]+//'
# 0.18.3
BAT_VERSION=$(curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/sharkdp/bat/releases/latest | sed -r 's/[^0-9]+//')

check_if_installed () {
    LOCAL_VERSION=$(bat --version | sed -r 's/[^0-9]*//')
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
    "install" ) ! check_if_installed && install ;;
    "update" ) ! check_if_installed && install ;;
esac
