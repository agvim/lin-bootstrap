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
