#!/bin/bash

# =====================================================
# input the path where you want to put the back file in
basedir=/backup/daily/

# =====================================================

PATH=/bin:/usr/bin:/sbin:/usr/sbin; export PATH
export LANG=C
basefile1=$basedir/cgi-bin.$(date +Y%-%m-%d).tar.bz2
[! -d "$basedir"] && mkdir -p $basedir

#1. backup cgi-bin in /var/www/
cd /var/www
tar -jpc -f $basefile1 cgi-bin
