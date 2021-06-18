#!/bin/bash
#wget https://www.internic.net/domain/named.root -O $UNB/root.hints
#sudo wget -O $UNB/named.cache https://www.internic.net/domain/named.cache
UNBOUND=/etc/unbound
sudo wget -O $UNBOUND/icannbundle.pem https://data.iana.org/root-anchors/icannbundle.pem
sudo wget -O $UNBOUND/root-anchors.xml https://data.iana.org/root-anchors/root-anchors.xml
sudo unbound-anchor -v -f /etc/resolv.conf -F -a  /etc/unbound/root.key
sudo ln -s /etc/unbound/root.key /var/lib/unbound/root.key
sudo ln -s /etc/unbound/root.key /var/unbound/etc/root.key

echo $?
#wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
wget --user=ftp --password=ftp ftp://ftp.rs.internic.net/domain/named.root -O /etc/unbound/root.hints
if [[ -f /etc/unbound/root.hints.bk ]] && [[ -z `cat /etc/unbound/root.hints` ]]; then
	sudo cp -rf /etc/unbound/root.hints.bk /var/lib/unbound/root.hints
else
	sudo ln -s /etc/unbound/root.hints /var/lib/unbound/root.hints
fi
wget --user=ftp --password=ftp ftp://ftp.rs.internic.net/domain/db.cache -O /etc/bind/db.root
