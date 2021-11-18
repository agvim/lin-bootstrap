#/bin/bash

check_if_installed () {
    ls $HOME/.homesick > /dev/null
    return $?
}

install () {
    # clone last revision. note that git already creates all intermediate folders
    git clone --depth=1 https://github.com/agvim/homeshick.git $HOME/.homesick/repos/homeshick
    return $?
}

# updated via homeshick itself
# update () {
#     $HOME/.homesick/repos/homeshick/bin/homeshick update homeshick
#     return $?
# }
