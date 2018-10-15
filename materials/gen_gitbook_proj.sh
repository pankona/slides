#!/bin/bash -e

if [ -z $OUTDIR ]; then
  OUTDIR=$(mktemp -d)
fi

ln -s ../_gitbook_template/Makefile $OUTDIR/Makefile
cp -r ./_gitbook_template/src      $OUTDIR/.
mv $OUTDIR .
echo "gitbook project generated on $OUTDIR"
