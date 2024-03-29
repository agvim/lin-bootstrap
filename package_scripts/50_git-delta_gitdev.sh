#!/bin/bash

# $ curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/dandavison/delta/releases/latest
# 0.9.2
DELTA_VERSION=$(curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/dandavison/delta/releases/latest | sed -r 's/[^0-9]+//')

check_if_installed () {
    LOCAL_VERSION=$(which delta > /dev/null && delta --version | xargs | cut -d' ' -f 2)
    [[ "$LOCAL_VERSION" == "$DELTA_VERSION" ]]
}

install(){
    wget --no-verbose "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" -O /tmp/git-delta_${DELTA_VERSION}_amd64.deb &&
        sudo dpkg -i /tmp/git-delta_${DELTA_VERSION}_amd64.deb
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
