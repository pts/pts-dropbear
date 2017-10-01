#ifndef DROPBEAR_GENSIGNKEY_H
#define DROPBEAR_GENSIGNKEY_H

#include "signkey.h"

/* format is KEYFILE_DROPBEAR or KEYFILE_OPENSSH */
int signkey_generate(enum signkey_type type, int bits, const char* filename, int skip_exist, int format);

#endif
