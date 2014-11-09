To install, make sure to have `gcc49` and do the following:

```
HOMEBREW_CC=gcc-4.9 HOMEBREW_CXX=g++-4.9 brew install -vd msp430-elf-binutils
HOMEBREW_CC=gcc-4.9 HOMEBREW_CXX=g++-4.9 brew install -vd msp430-elf-gcc
HOMEBREW_CC=gcc-4.9 HOMEBREW_CXX=g++-4.9 brew install -vd msp430-elf-includes
```

Still left to do:

```
17:54 < durka42> I have a partial workaround
17:54 < durka42> brew unlink gcc
17:54 < durka42> mkdir /usr/local/lib/gcc
17:54 < durka42> brew link gcc
17:54 < durka42> brew link msp430-elf-gcc
17:55 < durka42> if the /usr/local/lib/gcc already exists, then it doesn't try to remove the whole dir
17:55 < durka42> now only that share/ stuff is in the way
```
