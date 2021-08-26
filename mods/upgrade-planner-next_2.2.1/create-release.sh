#!/bin/bash

MOD_NAME="upgrade-planner-next"

if [ -z "$1" ]
then
    echo "Please specify the version number"
    exit 1
else
    VERSION=$1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

WORK_DIR=`mktemp -d`

# check if temporary directory was created
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create temporary directory"
  exit 1
fi

# deletes the temp directory
function cleanup {      
  rm -rf "$WORK_DIR"
}

function safe_change_dir {
    if cd $1; then
        :
    else
        echo "CD failed to change directory"
        exit 1
    fi
}

# register the clean-up function to be called on the EXIT signal
trap cleanup EXIT

cp -R $DIR $WORK_DIR

safe_change_dir $WORK_DIR/$MOD_NAME

rm *.zip
rm -rf .git*
rm -rf screenshots
rm create-release.sh

sed -i "s/\"version\": \".*\",/\"version\": \"$VERSION\",/g" info.json

safe_change_dir $WORK_DIR

ZIP_NAME="${MOD_NAME}_${VERSION}"

mv $MOD_NAME $ZIP_NAME

zip -qr "$ZIP_NAME.zip" $ZIP_NAME

cp "$ZIP_NAME.zip" $DIR

echo "Release for version $VERSION created"

