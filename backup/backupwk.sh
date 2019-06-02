#!/bin/bash
# =============================================================
# basedir used to save backup files
basedir=/backup/weekly

# =============================================================

PATH=/bin:/usr/bin:/sbin:/usr/sbin; export PATH
export LANG=C

named=$basedir/named
postfixd=$basedir/postfix
vsftpd=$basedir/vsftpd
sshd=$basedir/ssh
wwwd=$basedir/www
others=$basedir/others
userinfod=$basedir/userinfo

# check dir is exist?
for dir in $named $postfixd $vsftpd $sshd $wwwd $others $userinfod
do
	[ ! -d "$dir" ] && makdir -p $dir
done

#backup config files and /etc
cp -a /var/named/chroot/[etc, var] $named
cp -a /etc/postfix /etc/dovecot.conf $postfixd
cp -a /etc/vsftpd/* $vsftpd
cp -a /etc/ssh/* $sshd
cp -a /etc/{my.cnf, php..ini, httpd} $wwwd

cd /var/lib
	tar -jpc -f $wwwd/myspl.$(date +%Y-%m-%d)tar.bz2 mysql

cd /var/www
	tar -jpc -f $wwwd/html.tar.bz2 http cgi-bin

cd /
	tar -jpc -f $other/etc.tar.bz2 etc

cd /usr/
	tar -jpc -f $other/local.tar.bz2 local

cp -a /etc/{passwd, shadow, group} $userinfod

cd /
	tar -jpc -f $userinfod/home.tar.bz2 home




