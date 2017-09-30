#! /bin/bash --
# by pts@fazekas.hu at Sat Sep 30 11:53:42 CEST 2017

# wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2017.75.tar.bz2
# tar xjvf dropbear-2017.75.tar.bz2
# cd dropbear-2017.75

set -ex
./configure CC='xstatic gcc' --disable-syslog --disable-shadow --enable-bundled-libtom --disable-lastlog --disable-utmp --disable-utmpx --disable-wtmpx
make PROGRAMS='dropbear dbclient dropbearkey dropbearconvert scp' MULTI=1 STATIC=1 SCPPROGRESS=1
strip dropbearmulti
ls -l dropbearmulti

: c-sh OK.
