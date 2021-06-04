#!/bin/bash
SCRIPT_DIR=`realpath .`
bash $SCRIPT_DIR/links.sh
source $SCRIPT_DIR/.project_env.sh
source $SCRIPT_DIR/.install-args-proc.sh

sudo rm -rf  $INSTALL_CONFIG_DIR/unbound/unbound.conf.d/*

ROUTE=$PROG/route-dns
LIST_DIR=/var/{cache,tmp}/ctp-dns
mkdir -p $LIST_DIR


# CPs
sudo cp -rf $CONFIG_DIR/unbound/* $INSTALL_CONFIG_DIR/unbound/
sudo cp -rf $CONFIG_DIR/nginx/* $INSTALL_CONFIG_DIR/nginx/
sudo cp -rf $CONFIG_DIR/profile.d/* $INSTALL_CONFIG_DIR/profile.d/
sudo cp -rf $CONFIG_DIR/domains/ $INSTALL_CONFIG_DIR/
sudo cp -rf $CONFIG_DIR/dns-over-https $INSTALL_CONFIG_DIR/dns-over-https/
sudo cp -rf $CONFIG_DIR/* $INSTALL_CONFIG_DIR/
sudo cp -rf $CONFIG_DIR/bash_rc/* ~/
sudo cp -rf $CONFIG_DIR/www/* $WWW/

# Sys LNs
sudo ln -s /etc/fail2ban/filter.d/ctp-custom-vars.conf   /etc/fail2ban/filter.d/common.local
sudo ln -s $ROUTE/ctp-dns.sh /usr/local/bin
sudo ln -s $SCRIPT_DIR/dns-route.sh $PROG/
sudo ln -s $SCRIPT_DIR/../prog/route-dns $PROG/
sudo ln -s $ROUTE/lists/ $LIST_DIR

# Chmod +x
chmod +x $ROUTE/ctp-dns.sh
chmod +x /usr/local/bin/ctp-dns.sh

#sudo bash $SETUP_DIR/master_config.sh
echo "Done with coping config files"
