#! /bin/bash --
# by pts@fazekas.hu at Sat Sep 30 11:53:42 CEST 2017

set -ex
./configure CC="${XSTATIC:-xstatic} gcc" --disable-syslog --disable-shadow --enable-bundled-libtom --disable-lastlog --disable-utmp --disable-utmpx --disable-wtmpx
make clean
make PROGRAMS='dropbear dbclient dropbearkey dropbearconvert scp' MULTI=1 STATIC=1 SCPPROGRESS=1 NOSYSHOSTKEYLOAD=1 OPENSSHHOSTKEYLOAD=1 WRITEOPENSSHKEYS=1
strip dropbearmulti
ls -l dropbearmulti

# Try with:
#
#   $ ssh-keygen -t rsa -b 4096 -N '' -C hostkey_rsa4096 -f hostkey_rsa4096
#   $ ./dropbearmulti dropbearconvert openssh dropbear hostkey_rsa4096 dropbear_hostkey_rsa4096
#   $ ./dropbearmulti dropbear -r dropbear_hostkey_rsa4096 -F -E -m -s -P '' -A WINDOW=,TZ=,COLORFGBG=,LANG=,LC_ -p 65522
#   ...
#   $ ssh -v -o UserKnownHostsFile=/dev/null -o GlobalKnownHostsFile=/dev/null -o IdentitiesOnly=yes -o StrictHostKeyChecking=no -F /dev/null -i ...  -p 65522 127.0.0.1 id
#

: c.sh OK.
