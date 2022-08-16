#!/bin/bash

# appimageupdatetool appimage is updateable
APPIMAGES_FOLDER="$HOME/.local/appimages/updateable"
APPIMAGE_URL="https://github.com/AppImage/AppImageUpdate/releases/download/continuous/appimageupdatetool-x86_64.AppImage"
DOWNLOADED_FILENAME="appimageupdatetool-x86_64.appimage"
SYMLINK="$HOME/.local/bin/appimageupdatetool"

check_if_installed () {
    ls "$APPIMAGES_FOLDER/$DOWNLOADED_FILENAME" > /dev/null
    return $?
}

install () {
    # download appimage, add execution permission and symlink to bin
    mkdir -p "$APPIMAGES_FOLDER" &&
        wget "$STABLE_APPIMAGE_URL" -O "$APPIMAGES_FOLDER/$DOWNLOADED_FILENAME" &&
        chmod a+x "$APPIMAGES_FOLDER/$DOWNLOADED_FILENAME" &&
        ln -f -s "$APPIMAGES_FOLDER/$DOWNLOADED_FILENAME" "$SYMLINK"

    return $?
}

# managed with appimageupdatetool
# update () {
#     appimageupdatetool --overwrite --remove-old $APPIMAGES_FOLDER/$DOWNLOADED_FILENAME
# }

case "$1" in
    "install" ) ! check_if_installed && install ;;
    # "update" ) update ;;
    "updateable" ) exit 1;;
esac
