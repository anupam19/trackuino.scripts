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
PACKAGE="trackuino-shield-$BRANCH"

# Pack eagle files
(
cd "$ROOT/trackuino-shield"
hg update -C $BRANCH
DELIV="$TMP/$PACKAGE"
mkdir "$DELIV"

for i in sch brd
do
  cp trackuino-shield.$i "$DELIV"
done
cp -r gerbers "$DELIV"

cd "$TMP"
zip -9r $PACKAGE.zip $PACKAGE
)

mv $TMP/$PACKAGE.zip .
