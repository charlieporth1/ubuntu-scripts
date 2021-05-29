#!/bin/bash
#wget https://www.internic.net/domain/named.root -O $UNB/root.hints
#sudo wget -O $UNB/named.cache https://www.internic.net/domain/named.cache
UNBOUND=/etc/unbound
sudo wget -O $UNBOUND/icannbundle.pem https://data.iana.org/root-anchors/icannbundle.pem
sudo wget -O $UNBOUND/root-anchors.xml https://data.iana.org/root-anchors/root-anchors.xml
sudo unbound-anchor -v -f /etc/resolv.conf -F -a  /var/lib/unbound/root.key
echo $?
wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
if [[ -f /etc/unbound/root.hints.bk ]] && [[ -z `cat /var/lib/unbound/root.hints` ]]; then 
	sudo cp -rf /etc/unbound/root.hints.bk /var/lib/unbound/root.hints
fi
