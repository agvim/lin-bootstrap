#!/bin/bash

check_if_installed () {
    # /home/xxx/.local/share/fonts/FiraCode-Bold-Nerd.ttf: FiraCode Nerd Font Mono:style=Bold
    # /home/xxx/.local/share/fonts/FiraCode-Regular-Nerd.ttf: FiraCode Nerd Font Mono:style=Regular
    # /home/xxx/.local/share/fonts/JetBrainsMono-Regular-Nerd.ttf: JetBrainsMono Nerd Font Mono:style=Regular
    # /home/xxx/.local/share/fonts/JetBrainsMono-Italic-Nerd.ttf: JetBrainsMono Nerd Font Mono:style=Italic
    # /home/xxx/.local/share/fonts/JetBrainsMono-Bold-Italic-Nerd.ttf: JetBrainsMono Nerd Font Mono:style=Bold Italic
    # /home/xxx/.local/share/fonts/JetBrainsMono-Bold-Nerd.ttf: JetBrainsMono Nerd Font Mono:style=Bold
    fc-list | grep "FiraCode" > /dev/null &&
        fc-list | grep "JetBrainsMono" > /dev/null
}

install(){
    # FIXME: individual fonts (neovide has problem with variable ones)
    # note they need to be the MONO variant for kitty (and using it also for neovide)
    NERD_VERSION=$(curl -Ls -I -o /dev/null -w %{url_effective} https://github.com/ryanoasis/nerd-fonts/releases/latest | sed -r 's/[^0-9]+//')
    FONTTEMP=$(mktemp -d /tmp/fontsXXXXXXX)
    mkdir -p $HOME/.local/share/fonts/ &&
        wget --no-verbose "https://github.com/ryanoasis/nerd-fonts/releases/download/v$NERD_VERSION/FiraCode.zip" -O "$FONTTEMP/fira_code.zip" &&
        unzip -o -j "$FONTTEMP/fira_code.zip" -d "$FONTTEMP/" &&
        cp "$FONTTEMP/Fira Code Bold Nerd Font Complete Mono.ttf" "$HOME/.local/share/fonts/FiraCode-Bold-Nerd.ttf" &&
        cp "$FONTTEMP/Fira Code Regular Nerd Font Complete Mono.ttf" "$HOME/.local/share/fonts/FiraCode-Regular-Nerd.ttf" &&
        wget --no-verbose "https://github.com/ryanoasis/nerd-fonts/releases/download/v$NERD_VERSION/JetBrainsMono.zip" -O "$FONTTEMP/jetbrains_mono.zip" &&
        unzip  -o -j "$FONTTEMP/jetbrains_mono.zip" -d "$FONTTEMP/" &&
        cp "$FONTTEMP/JetBrains Mono Italic Nerd Font Complete Mono.ttf" "$HOME/.local/share/fonts/JetBrainsMono-Italic-Nerd.ttf" &&
        cp "$FONTTEMP/JetBrains Mono Bold Italic Nerd Font Complete Mono.ttf" "$HOME/.local/share/fonts/JetBrainsMono-Bold-Italic-Nerd.ttf" &&
        cp "$FONTTEMP/JetBrains Mono Regular Nerd Font Complete Mono.ttf" "$HOME/.local/share/fonts/JetBrainsMono-Regular-Nerd.ttf" &&
        cp "$FONTTEMP/JetBrains Mono Bold Nerd Font Complete Mono.ttf" "$HOME/.local/share/fonts/JetBrainsMono-Bold-Nerd.ttf" &&
        rm -rf "$FONTTEMP"
}

case "$1" in
    "install" ) ! check_if_installed && install ;;
    # update not available
    "updateable" ) exit 1 ;;
esac
