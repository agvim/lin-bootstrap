#!/bin/bash

function is_installed()
{
    local INSTALLED_STATUS="ii "
    local DPKGQUERY=$(dpkg-query -W -f='${db:Status-Abbrev}' $1 2>/dev/null)
    if [[ $DPKGQUERY == $INSTALLED_STATUS ]]
    then
        return 1
    else
        return 0
    fi
}

# $1 is the tool binary name
# $2 is the castle url (use if not in my github or if
#   the tool binary does not match the castle name)
function homeshick_if_installed()
{
    BINARY=$1
    if [[ $# -eq 2 ]]
    then
        URL=$2
    else
        URL="https://github.com/agvim/cfg-$BINARY"
    fi

    is_installed $BINARY
    if [[ $? -eq 1 ]]
    then
        eval $homeshick clone $URL
    fi
}
