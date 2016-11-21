#!/bin/sh

SFDIR=/home/breakthrough/git-repos/dvstats-server-files

cd $SFDIR/output

pisg \
    --configfile=$SFDIR/config/pisg.conf            \
    --cfg CssDir=$SFDIR/template/                   \
    --cfg PageHead=$SFDIR/template/header.html      \
    --cfg PageFoot=$SFDIR/template/footer.html

sed -e "5r $SFDIR/template/fonts.html" -i $SFDIR/output/dvstats.html

