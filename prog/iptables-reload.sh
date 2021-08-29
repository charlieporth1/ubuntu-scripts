#!/bin/bash
echo "Clearing IPTables and IPSet"
sudo bash $PROG/iptables-clear.sh

echo "Recreating IPTables and IPSet"
sudo bash $PROG/iptables-load.sh
sudo bash $PROG/set_unban_ip.sh
