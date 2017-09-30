pts-dropbear: Dropbear SSH tools with ed25519 and other improvements by pts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pts-dropbear is a C source tree of the Dropbear embedded SSH server and
server tools, with modifications by pts.

Based on: dropbear-2017.75.tar.bz2

The most important improvements in pts-dropbear:

* Added ssh-ed25519 crypto for server host keys and user keys. The
  implementation is based on TweetNaCl v20140427.
* Added environment variable propagation (similar to OpenSSH AcceptEnv,
  command-line flag -A) to dropbear sshd.
* Improved some command-line flags (e.g. -E is always available).
* Compilation instructions for pts-xstatic (statically linked i386 Linux
  binary). Binary size is 350456 bytes.
* Option to compile without loading any system keys (e.g. from
  /etc/dropbear): `make NOSYSHOSTKEYLOAD=1'.

How to generate an ssh-ed25519 server host key:

* Until support is added to dropbearkey and dropbearconvert, use this Python
  script:
  https://github.com/pts/py_ssh_keygen_ed25519/blob/master/py_ssh_keygen_ed25519.py
* Example invocation:

    $ ./py_ssh_keygen_ed25519.py -t ed25519 -Z dropbear -f dropbear_hostkey_ed25519

  This creates the files dropbear_hostkey_ed25519 and
  dropbear_hostkey_ed25519.pub.

TODO:

* Send patches to upstream dropbear.
* Add ssh-ed25519 to dropbearkey (and reuse the code with ed25519.c).
* Add ssh-ed25519 to dropbearconv.
* --disable-wtmp? Add at least a command-line flag.

__END__
