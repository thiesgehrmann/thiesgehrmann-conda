sed -e "s:INSTALL_DIR=~/.aspera/connect:INSTALL_DIR=$PREFIX/opt/aspera/connect:" ./aspera-connect-3.7.2.141527-linux-64.sh > ./aspera-connect-3.7.2.141527-linux-64-fixed.sh
chmod +x ./aspera-connect-3.7.2.141527-linux-64-fixed.sh
./aspera-connect-3.7.2.141527-linux-64-fixed.sh

ln -s $PREFIX/opt/aspera/connect/bin/ascp $PREFIX/bin
ln -s $PREFIX/opt/aspera/connect/bin/asperaconnect $PREFIX/bin

