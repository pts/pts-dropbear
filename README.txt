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
* Added option of autodetection and loading of OpenSSH hostkeys to Dropbear
  sshd (with `make OPENSSHHOSTKEYLOAD=1').
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

    $ dropbearkey -t ed25519 -f dropbear_hostkey_ed25519

* Alternatively, this command works if you have OpenSSH:

    $ ssh-keygen -N "" -t ed25519 -f dropbear_hostkey_ed25519

* Alternatively, you can use this Python script:
  https://github.com/pts/py_ssh_keygen_ed25519/blob/master/py_ssh_keygen_ed25519.py

  Example invocation:

    $ ./py_ssh_keygen_ed25519.py -t ed25519 -Z dropbear -f dropbear_hostkey_ed25519

TODO:

* Send patches to upstream Dropbear.
* Add querying an ssh-agent to dbclient. (No need to write an ssh-agent,
  the Gnome, gpg and OpenSSH ssh-agent implementations are fine.)
* Add flag to dropbearkey to generate OpenSSH private key format (with
  `make WRITEOPENSSHKEYS=1'), `-Z openssh'.
* refactor: split keywrite.c (import_write(...)) out keyimport.c, to make
  the dropbear (not dropbearmulti) binary smaller.
* --disable-wtmp in c.sh? Add at least a command-line flag. Is the stock
  Ubuntu 14.04 /var/log/wtmp compatible with xstatic uClibc wtmp format?

FYI:

* dropbearconvert (and import_read) ignores comments.
* dropbearkey creates private keys without comments (only public keys have comments).
* OpenSSH `ssh -i' ignores comments in the private key file.
* dropbear doesn't support user or host key passphrases.
* dbclient cannot authenticate with an ssh-agent.

__END__
