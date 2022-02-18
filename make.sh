#!/bin/bash

set -e

if [ "$1" == "" ]
then
    echo "Usage: $0 FILENAME.MD [OUTPUT_DIR]"
    exit -1
fi

if [ "$2" == "" ]
then
    OUTDIR="."
else
    OUTDIR="$2"
fi

FILENAME=`grep -m1 value "$1" | cut -d'"' -f2`

echo "mmark `mmark --version`"

`which xml2rfc` --version

mmark "$1" > "$OUTDIR"/"$FILENAME".xml

sed -E 's/<u format="char-num">([^<]+)<\/u>/\1/g' "$OUTDIR"/"$FILENAME".xml > "$OUTDIR"/"$FILENAME".tmp

cat "$OUTDIR"/"$FILENAME".tmp > "$OUTDIR"/"$FILENAME".xml

`which xml2rfc` -p "$OUTDIR" --html "$OUTDIR"/"$FILENAME".xml

sed 's/\&amp\;/\&/g' "$OUTDIR"/"$FILENAME".html > "$OUTDIR"/"$FILENAME".tmp

cat "$OUTDIR"/"$FILENAME".tmp > "$OUTDIR"/"$FILENAME".html

rm -f "$OUTDIR"/"$FILENAME".xml "$OUTDIR"/"$FILENAME".tmp

exit 0
