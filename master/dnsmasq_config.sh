#!/bin/bash
SCRIPT_DIR=`realpath .`
bash $SCRIPT_DIR/links.sh
source $SCRIPT_DIR/.project_env.sh
source $SCRIPT_DIR/.install-args-proc.sh

source /etc/environment

grep -v '169.254.169.254' $DNSMASQ/10-servers.conf > $DNSMASQ/10-servers.conf.tmp
mv $DNSMASQ/10-servers.conf.tmp $DNSMASQ/10-servers.conf
