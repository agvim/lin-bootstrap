#!/bin/bash

check_if_installed () {
    # nodesource repos are placed in this sources.list files
    ls /etc/apt/sources.list.d/nodesource.list > /dev/null && ls /etc/apt/sources.list.d/yarn.list > /dev/null
}

install(){
    # use the nodesource repository for lts releases
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&
    # install yarn also
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null &&
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list &&
    sudo apt-get -q update && sudo apt-get -q install -y nodejs yarn
}

# managed with apt
# update() {}

case "$1" in
    "install" | "update")
        if check_if_installed; then
            exit 0
        else
            install
        fi;;
    "updateable") exit 1;;
esac
