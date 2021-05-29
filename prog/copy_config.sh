#!/bin/bash
SCRIPT_DIR=`realpath .`
bash $SCRIPT_DIR/links.sh
source $SCRIPT_DIR/.project_env.sh
source $SCRIPT_DIR/.install-args-proc.sh
sudo rm -rf  $INSTALL_CONFIG_DIR/unbound/unbound.conf.d/*

sudo cp -rf $CONFIG_DIR/unbound/* $INSTALL_CONFIG_DIR/unbound/
sudo cp -rf $CONFIG_DIR/nginx/* $INSTALL_CONFIG_DIR/nginx/
sudo cp -rf $CONFIG_DIR/profile.d/* $INSTALL_CONFIG_DIR/profile.d/
sudo cp -rf $CONFIG_DIR/domains/ $INSTALL_CONFIG_DIR/
sudo cp -rf $CONFIG_DIR/dns-over-https $INSTALL_CONFIG_DIR/dns-over-https/
sudo cp -rf $CONFIG_DIR/* $INSTALL_CONFIG_DIR/
sudo cp -rf $CONFIG_DIR/bash_rc/* ~/
sudo cp -rf $CONFIG_DIR/www/* $WWW/

sudo bash $SETUP_DIR/master_config.sh
echo "Done"
