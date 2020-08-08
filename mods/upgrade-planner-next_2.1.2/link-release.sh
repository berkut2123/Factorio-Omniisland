#!/bin/bash

MOD_NAME="upgrade-planner-next"
FACTORIO_MOD_PATH="$HOME/.factorio/mods"

if [ -z "$1" ]
then
    echo "Please specify the version number"
    exit 1
else
    VERSION=$1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function safe_change_dir {
    if cd $1; then
        :
    else
        echo "CD failed to change directory"
        exit 1
    fi
}

# register the clean-up function to be called on the EXIT signal

sed -i "s/\"version\": \".*\",/\"version\": \"$VERSION\",/g" info.json

safe_change_dir $FACTORIO_MOD_PATH

LINK_NAME="${MOD_NAME}_${VERSION}"

ln -s $DIR $LINK_NAME

echo "Release for version $VERSION successfully linked for testing"

