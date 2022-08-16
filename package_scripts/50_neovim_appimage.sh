#!/bin/bash

# nvim appimage is updateable
APPIMAGES_FOLDER="$HOME/.local/appimages/updateable"
APPIMAGE_URL="https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"
DOWNLOADED_FILENAME=nvim.appimage
SYMLINK="$HOME/.local/bin/nvim"
NIGHTLY_APPIMAGE_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
NIGHTLY_DOWNLOADED_FILENAME=nvim-nightly.appimage
NIGHTLY_SYMLINK="$HOME/.local/bin/nvim"

check_if_installed () {
    ls "$APPIMAGES_FOLDER/$DOWNLOADED_FILENAME" > /dev/null
    return $?
}

install(){
    # download appimage, add execution permission and symlink to bin
    mkdir -p "$APPIMAGES_FOLDER" &&
        wget "$APPIMAGE_URL" -O "$APPIMAGES_FOLDER/$DOWNLOADED_FILENAME" &&
        chmod a+x "$APPIMAGES_FOLDER/$DOWNLOADED_FILENAME" &&
        ln -f -s "$APPIMAGES_FOLDER/$DOWNLOADED_FILENAME" "$SYMLINK" &&
        wget "$NIGHTLY_APPIMAGE_URL" -O "$APPIMAGES_FOLDER/$NIGHTLY_DOWNLOADED_FILENAME" &&
        chmod a+x "$APPIMAGES_FOLDER/$NIGHTLY_DOWNLOADED_FILENAME" &&
        ln -f -s "$APPIMAGES_FOLDER/$NIGHTLY_DOWNLOADED_FILENAME" "$NIGHTLY_SYMLINK"

    return $?
}

# managed with appimageupdatetool
# update(){
#     appimageupdatetool --overwrite --remove-old $APPIMAGES_FOLDER/$DOWNLOADED_FILENAME
# }

case "$1" in
    "install" | "update")
        if [[ check_if_installed ]]; then
            exit 0
        else
            install
        fi;;
    "updateable") exit 1;;
esac
