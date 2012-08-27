#!/bin/bash

# Check cmd line
set -e
if [ $# != 1 ]
then
  echo "Usage: $0 <version>"
  exit 1
fi

# Assorted dirs
SD="$(dirname $0)"
ROOT="$SD/.."
TMP="$(mktemp -d /tmp/pack.XXXXXX)"

# Branch
BRANCH=$1
PACKAGE="trackuino-firmware-$BRANCH"

# Pack eagle files
(
cd "$ROOT/firmware"
hg update -C $BRANCH
DELIV="$TMP/$PACKAGE"
mkdir "$DELIV"
mkdir "$DELIV/trackuino"

cp -r trackuino $DELIV
for i in README WHATSNEW LICENSE
do
  cp $i "$DELIV"
done


cd "$TMP"
zip -9r $PACKAGE.zip $PACKAGE -x \*/.DS_Store
)

mv $TMP/$PACKAGE.zip .
