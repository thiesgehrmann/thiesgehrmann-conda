#!/bin/bash

pwd
ls -ltrh
python setup.py install
cp scripts/run_BUSCO.py $PREFIX/bin/BUSCO
cp scripts/generate_plot.py $PREFIX/bin/BUSCO_plot

cat config/config.ini.default \
 | sed -e "s:/home/osboxes/BUSCOVM/augustus/augustus-3.2.2/bin/:$PREFIX/bin/:" \
       -e "s:/home/osboxes/BUSCOVM/hmmer/hmmer-3.1b2-linux-intel-ia32/binaries/:$PREFIX/bin/:" \
 > $PREFIX/config/busco_config.ini

echo "###############"
cat $PREFIX/config/busco_config.ini
echo "###############"

mkdir -p $PREFIX/etc/conda/activate.d/
echo -e "#!/usr/bin/env bash\nexport BUSCO_CONFIG_FILE=$PREFIX/config/busco_config.ini;" > $PREFIX/etc/conda/activate.d/busco_config.sh
chmod a+x $PREFIX/etc/conda/activate.d/busco_config.sh

mkdir -p $PREFIX/etc/conda/deactivate.d/
echo "#!/usr/bin/env bash\nunset BUSCO_CONFIG_FILE;" > $PREFIX/etc/conda/deactivate.d/busco_config.sh
chmod a+x $PREFIX/etc/conda/deactivate.d/busco_config.sh

