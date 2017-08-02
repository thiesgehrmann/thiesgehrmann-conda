#!/bin/sh
set -x -e

mkdir -p $PREFIX/bin

pwd

find | grep "license_download.cgi" | while read x; do
  mv "$x" "license_download.cgi"
done

ls -ltrh

executable=`cat license_download.cgi | grep "gm_et_linux_64.tar.gz" | cut -d\" -f2`
license=`cat license_download.cgi | grep "gm_key_64.gz" | tr '"' '\n' | grep "gm_key_64.gz"`

wget $executable -O ./gm_et_linux_64.tar.gz
wget $license -O ./gm_key_64.gz


tar -xvf ./gm_et_linux_64.tar.gz
gunzip ./gm_key_64.gz

# Remove reference to root installed perl, use the one from the current environment
sed -i.bak -e 's:#!/usr/bin/perl:#!/usr/bin/env perl:' `find | grep -e '.pl$'`

#sed -i.bak -e "s#my \$file_name = glob('~/.gm_key');#my \$file_name = glob('$PREFIX/opt/genemark_es/gm_key');#" `find | grep gmes_petap.pl`

ls -ltrh

mkdir -p "$PREFIX"/opt/
mv gm_et_linux_64 "$PREFIX"/opt/genemark_es
mv gm_key_64 "$PREFIX"/opt/genemark_es/gm_key

ln -f -s "$PREFIX"/opt/genemark_es/gmes_petap/gmes_petap.pl "$PREFIX"/bin
ln -f -s "$PREFIX"/opt/genemark_es/gmes_petap/gmhmme3 "$PREFIX"/bin
ln -f -s "$PREFIX"/opt/genemark_es/gmes_petap/probuild "$PREFIX"/bin

mkdir -p $PREFIX/etc/conda/activate.d/
echo "export GENEMARK_PATH=$PREFIX/bin/gmes_petap.pl; cp \"$PREFIX\"/opt/genemark_es/gm_key $HOME/.gm_key" > $PREFIX/etc/conda/activate.d/genemark_es-confdir.sh
chmod a+x $PREFIX/etc/conda/activate.d/genemark_es-confdir.sh

mkdir -p $PREFIX/etc/conda/deactivate.d/
echo "unset GENEMARK_PATH; rm $HOME/.gm_key" > $PREFIX/etc/conda/deactivate.d/genemark_es-confdir.sh
chmod a+x $PREFIX/etc/conda/deactivate.d/genemark_es-confdir.sh

