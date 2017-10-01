pts-dropbear: Dropbear SSH tools with ed25519 and other improvements by pts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pts-dropbear is a C source tree of the Dropbear embedded SSH server, client
and tools for Unix, with modifications by pts.

Based on: dropbear-2017.75.tar.bz2

The most important improvements in pts-dropbear:

* Added ssh-ed25519 crypto for server host keys and user keys. The
  implementation is based on TweetNaCl v20140427.
* Added environment variable propagation (similar to OpenSSH AcceptEnv,
  command-line flag -A) to Dropbear sshd.
* Added autodetection and loading of OpenSSH hostkeys to Dropbear
  sshd (with `make OPENSSHHOSTKEYLOAD=1').
* Added flag to dropbearkey to generate private keys in OpenSSH format
  directly (dropbearkey -Z openssh, with `make WRITEOPENSSHKEYS=1').
* Improved some command-line flags (e.g. dropbear -E is always available).
* Compilation instructions for pts-xstatic (statically linked i386 Linux
  binary). Binary size is 350456 bytes.
* Added option to compile without loading any system hostkeys (e.g. from
  /etc/dropbear) (with `make NOSYSHOSTKEYLOAD=1').
* Made dropbearkey behavior is more compatible with ssh-keygen in OpenSSH:
** dropbearkey now creates a .pub file.
** -b bits flag.
** -C comment flag. (The comment will be added to the public key file, and
   not to the private key file.)
** -P passphrase flag. Only the empty passhprase is allowed.
** -N passphrase flag. Only the empty passhprase is allowed.
* Added autodection of the input private key file format, as
  `dropbearconvert any'.

How to generate an ssh-ed25519 server host key:

* Use this command:

    $ dropbearkey -Z openssh -t ed25519 -f dropbear_hostkey_ed25519

  Please note that `-Z openssh' is optional. It creates the private key file
  in the OpenSSH format, for improved interoperability.

* Alternatively, this command works if you have OpenSSH:

    $ ssh-keygen -N "" -t ed25519 -f dropbear_hostkey_ed25519

* Alternatively, you can use this Python script:
  https://github.com/pts/py_ssh_keygen_ed25519/blob/master/py_ssh_keygen_ed25519.py

  Example invocation:

    $ ./py_ssh_keygen_ed25519.py -t ed25519 -Z dropbear -f dropbear_hostkey_ed25519

TODO:

* Send patches to upstream Dropbear.
* Add cipher chacha20-poly1305@openssh.com (for feature parity with
  tinyssh).
* Add querying an ssh-agent to dbclient. (No need to write an ssh-agent,
  the Gnome, gpg and OpenSSH ssh-agent implementations are fine.)
* refactor: split keywrite.c (import_write(...)) out keyimport.c, to make
  the dropbear (not dropbearmulti) binary smaller.
* --disable-wtmp in c.sh? Add at least a command-line flag. Is the stock
  Ubuntu 14.04 /var/log/wtmp compatible with xstatic uClibc wtmp format?

FYI:

* dropbearconvert (and import_read) ignores comments in keys.
* dropbearkey creates private keys without comments (only public keys have comments).
* OpenSSH `ssh -i' ignores comments in the private key file. Good.
* dropbear doesn't support user or host key passphrases.
* dbclient cannot authenticate with an ssh-agent.
* dropbear doesn't try to be smart and slow, e.g. by doing DNS lookups on
  the client IP address.
* Dropbear binary size is smaller (353 kB for dropbearmulti linked with
  xstatic, containing dropbear, dbclient, dropbearkey, dropbearconvert, scp)
  than OpenSSH (836 kB for sshd, 791 kB, 380 kB for ssh-agent for ssh linked
  with xstatic, 7.3p1 without OpenSSL).
* OpenSSH crypto operations are faster than in Dropbear. (Is this true?
  Benchmark!)
* Dropbear 2017.75 supports these ciphers (with the default compiation flags):
  aes128-ctr, aes256-ctr, aes128-cbc, aes256-cbc, twofish256-cbc,
  twofish128-cbc, 3des-ctr, 3des-cbc, 3des.
  blowfish can also be enabled, but twofish is more efficient.
* OpenSSH_5.3p1 supports these ciphers: (twofish is missing.)
  aes128-ctr, aes192-ctr, aes256-ctr, arcfour256, arcfour128, aes128-cbc,
  3des-cbc, blowfish-cbc, cast128-cbc, aes192-cbc, aes256-cbc, arcfour,
  rijndael-cbc@lysator.liu.se.
* OpenSSH_7.2p2 in Ubuntu 14.04 supports these ciphers: (twofish is missing.)
  3des-cbc, aes128-cbc, aes128-ctr, aes128-gcm@openssh.com, aes192-cbc
  aes192-ctr, aes256-cbc, aes256-ctr, aes256-gcm@openssh.com, arcfour,
  arcfour128 arcfour256, chacha20-poly1305@openssh.com,
  rijndael-cbc@lysator.liu.se.
* OpenSSH_7.3p1 compiled without OpenSSL supports these ciphers:
  aes128-ctr, aes192-ctr, aes256-ctr, chacha20-poly1305@openssh.com.
* tinyssh 20161101 (and the latest github on 2017-10-01)
  supports these ciphers: aes256-str, chacha20-poly1305@openssh.com.

__END__
