#!/bin/sh
cd output


SFDIR=..
pisg --configfile=$SFDIR/config/pisg.conf --cfg CssDir=$SFDIR/template/ --cfg PageHead=$SFDIR/template/header.html


