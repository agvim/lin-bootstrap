#/bin/bash

check_if_installed () {
    ls $HOME/.homesick > /dev/null
}

install () {
    # clone last revision. note that git already creates all intermediate folders
    git clone --depth=1 https://github.com/agvim/homeshick.git $HOME/.homesick/repos/homeshick
}

# updated via homeshick itself
# update () {
#     $HOME/.homesick/repos/homeshick/bin/homeshick update homeshick
#     return $?
# }

case "$1" in
    "install" ) ! check_if_installed && install ;;
    # "update" ) update ;;
    "updateable" ) exit 1;;
esac
