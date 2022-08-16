#!/bin/bash

check_if_installed () {
    # .local/share/fonts/FiraCode-Bold.ttf: Fira Code:style=Bold
    # .local/share/fonts/FiraCode-Light.ttf: Fira Code,Fira Code Light:style=Light,Regular
    # .local/share/fonts/FiraCode-Medium.ttf: Fira Code,Fira Code Medium:style=Medium,Regular
    # .local/share/fonts/FiraCode-Regular.ttf: Fira Code:style=Regular
    # .local/share/fonts/FiraCode-Retina.ttf: Fira Code,Fira Code Retina:style=Retina,Regular
    # .local/share/fonts/FiraCode-SemiBold.ttf: Fira Code,Fira Code SemiBold:style=SemiBold,Regular
    # .local/share/fonts/JetBrainsMono-Bold-Italic.ttf: JetBrains Mono:style=Bold Italic
    # .local/share/fonts/JetBrainsMono-Bold.ttf: JetBrains Mono:style=Bold
    # .local/share/fonts/JetBrainsMono-Italic.ttf: JetBrains Mono:style=Italic
    # .local/share/fonts/JetBrainsMono-Regular.ttf: JetBrains Mono:style=Regular
    # .local/share/fonts/Symbols-2048-em Nerd Font Complete.ttf: Symbols Nerd Font:style=2048-em
    fc-list | grep "FiraCode" > /dev/null &&
        fc-list | grep "JetBrainsMono" > /dev/null &&
        fc-list | grep "Symbols-2048" > /dev/null

    return $?
}

install(){
    # FIXME: individual fonts (neovide has problem with variable ones)
    # for the jetbrains one, unzip only the individual ones with ligatures
    FIRA_VERSION=$(curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/tonsky/FiraCode/releases/latest | sed -r 's/[^0-9]+//')
    JETBRAINS_VERSION=$(curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/JetBrains/JetBrainsMono/releases/latest | sed -r 's/[^0-9]+//')
    mkdir -p $HOME/.local/share/fonts/ &&
        wget "https://github.com/tonsky/FiraCode/releases/download/$FIRA_VERSION/Fira_Code_v$FIRA_VERSION.zip" -O /tmp/fira_code.zip &&
        unzip  -j /tmp/fira_code.zip 'ttf/*.ttf' -d "$HOME/.local/share/fonts/" &&
        wget "https://github.com/JetBrains/JetBrainsMono/releases/download/v$JETBRAINS_VERSION/JetBrainsMono-$JETBRAINS_VERSION.zip" -O /tmp/jetbrainsmono.zip &&
        unzip  -j /tmp/jetbrainsmono.zip 'fonts/ttf/JetBrainsMono-*.ttf' -d "$HOME/.local/share/fonts/" &&
        wget "https://github.com/ryanoasis/nerd-fonts/raw/master/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf" -O "$HOME/.local/share/fonts/Symbols-2048-em Nerd Font Complete.ttf"

    return $?
}

case "$1" in
    "install" ) ! check_if_installed && install ;;
    # update not available
    "updateable" ) exit 1 ;;
esac
