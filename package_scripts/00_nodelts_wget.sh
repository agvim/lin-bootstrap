#!/bin/bash


# lts version is in a line that says "... Latest LTS <strong>x.y.z</strong> ..."
NODE_VERSION=$(wget -q https://nodejs.org/en/download -O - | grep "Latest LTS" | sed -r 's/.*<strong>//; s/<\/strong>.*//')
check_if_installed () {
    ls "/opt/node-v$NODE_VERSION-linux-x64" > /dev/null

    return $?
}

install(){
    wget "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" -O "/tmp/nodejs.tar.xz" &&
        sudo bash -c "umask 022; tar -Jxvf \"/tmp/nodejs.tar.xz\" -C /opt/; export PATH=\"/opt/node-v$NODE_VERSION-linux-x64/bin:$PATH\"; /opt/node-v$NODE_VERSION-linux-x64/bin/npm install -g yarn" &&
        ln -f -s "/opt/node-v$NODE_VERSION-linux-x64/bin/node" "$HOME/.local/bin/" &&
        ln -f -s "/opt/node-v$NODE_VERSION-linux-x64/bin/npm" "$HOME/.local/bin/" &&
        ln -f -s "/opt/node-v$NODE_VERSION-linux-x64/bin/yarn" "$HOME/.local/bin/" &&
        ln -f -s "/opt/node-v$NODE_VERSION-linux-x64/bin/yarnpkg" "$HOME/.local/bin/" &&
        ln -f -s "/opt/node-v$NODE_VERSION-linux-x64/bin/npx" "$HOME/.local/bin/"

    return $?
}

update () {
    sudo bash -c "PATH=\"/opt/node-v$NODE_VERSION-linux-x64/bin:$PATH\"; umask 022; npm update -g; yarn global upgrade"

    return $?
}

case "$1" in
    "install" ) ! check_if_installed && install ;;
    "update" ) update ;;
esac
