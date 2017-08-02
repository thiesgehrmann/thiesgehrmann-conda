#!/usr/bin/env bash

# If it has Build.PL use that, otherwise use Makefile.PL
if [ -f Build.PL ]; then
    perl Build.PL
    #sed -i.bak 's:#!.*:#!/usr/bin/env perl:' ./Build
    cat ./Build
    which perl
    perl="`head -n1 Build | cut -d\  -f2`"
    $perl ./Build
    $perl ./Build test
    # Make sure this goes in site
    $perl ./Build install --installdirs site
elif [ -f Makefile.PL ]; then
    # Make sure this goes in site
    perl Makefile.PL INSTALLDIRS=site
    make
    make test
    make install
else
    echo 'Unable to find Build.PL or Makefile.PL. You need to modify build.sh.'
    exit 1
fi
