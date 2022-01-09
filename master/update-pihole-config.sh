#!/bin/bash
pihole -up
#wget -O /tmp/install.sh https://raw.githubusercontent.com/PiPass/bin/master/install.sh
#sudo ./install.sh
cd $WWW
cp -rf $WWW/blockpage/blockpage/unblock/index.php $WWW/blockpage/blockpage/unblock/index.php.org
cp -rf /home/$ADMIN_USR/index.php $WWW/blockpage/blockpage/unblock/index.php
sudo unlink /usr/sbin/dnsmasq
sudo ln -s /usr/local/sbin/dnsmasq /usr/sbin/dnsmasq

curl -sSL https://raw.githubusercontent.com/PiPass/bin/master/install.sh | bash
curl -sSL https://raw.githubusercontent.com/PiPass/bin/master/update.sh | bash

bash $PROG/pihole-lighttpd-changes.sh
ROOT_DNSMASQ_FILE=$DNSMASQ/01-pihole.conf
NORMANL_TTL="^local-ttl=2$"
WANTED_TTL="local-ttl=20"
sed -i -E "s/$NORMANL_TTL/$WANTED_TTL/g" $ROOT_DNSMASQ_FILE