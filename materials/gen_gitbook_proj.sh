#!/bin/bash -e

TMPDIR=$(mktemp -d)

ln -s ../_gitbook_template/Makefile $TMPDIR/Makefile
cp -r ./_gitbook_template/src       $TMPDIR/.

if [ -z $OUTDIR ]; then
  mv -f $TMPDIR .
  echo "gitbook project generated on $(basename $TMPDIR)"
else
  mv -f $TMPDIR $OUTDIR
  echo "gitbook project generated on $OUTDIR"
fi
