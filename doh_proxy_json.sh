#!/bin/bash
SCRIPT_DIR=`realpath .`

source $SCRIPT_DIR/.project_env.sh

git clone https://github.com/m13253/dns-over-https
cd dns-over-https/
git stash
sudo git pull -ff
make
sudo make install

sudo systemctl start doh-server.service
sudo systemctl enable doh-server.service
# TO DO ADD OTHER IFACE
ROOT_NETWORK=`bash $PROG/get_network_devices_ip_address.sh --default --only-single-interface`

OLD_STR='0.0.0.0'
NEW_STR="\"udp:$ROOT_NETWORK:53\",\t\n\"tcp:$ROOT_NETWORK:53\",\n"
sed -i "s/$OLD_STR/$NEW_STR/g" $CONFIG_DIR/dns-over-https/doh-server.conf
sudo cp -rf $CONFIG_DIR/dns-over-https/* $INSTALL_CONFIG_DIR/dns-over-https/
