#!/bin/bash
#wget https://www.internic.net/domain/named.root -O $UNB/root.hints
#sudo wget -O $UNB/named.cache https://www.internic.net/domain/named.cache
UNBOUND=/etc/unbound
sudo mkdir -p /var/unbound/etc/ /var/lib/unbound/
sudo wget -O $UNBOUND/icannbundle.pem https://data.iana.org/root-anchors/icannbundle.pem
sudo wget -O $UNBOUND/root-anchors.xml https://data.iana.org/root-anchors/root-anchors.xml
sudo wget -O $UNBOUND/root-anchors.p7s https://data.iana.org/root-anchors/root-anchors.p7s

echo $?
#wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
wget --user=ftp --password=ftp ftp://ftp.rs.internic.net/domain/named.root -O /etc/unbound/root.hints

if [[ -f /etc/unbound/root.hints.bk ]] && [[ -z `cat /etc/unbound/root.hints` ]]; then
	sudo cp -rf /etc/unbound/root.hints.bk /var/lib/unbound/root.hints
else
	sudo rm -rf /var/lib/unbound/root.hints
#	sudo ln -s /etc/unbound/root.hints /var/lib/unbound/root.hints
	sudo cp -rf /etc/unbound/root.hints /var/lib/unbound/root.hints
fi

wget --user=ftp --password=ftp ftp://ftp.rs.internic.net/domain/db.cache -O /etc/bind/db.root
#	-x $UNBOUND/root-anchors.xml \

sudo unbound-anchor -v -F -R \
	-a /var/lib/unbound/root.key \
	-f /etc/resolv.conf \
 	-r /var/lib/unbound/root.hints
#	-r /etc/unbound/root.hints

#	-c $UNBOUND/icannbundle.pem \
#	-x root-anchors/root-anchors.xml \
#	-s root-anchors/root-anchors.p7s \
#	-u data.iana.org \
#	-P 443

#sudo ln -s /etc/unbound/root.key /var/lib/unbound/root.key
#sudo ln -s /etc/unbound/root.key /var/unbound/etc/root.key
#sudo rm -rf /var/unbound/etc/root.key
sudo cp -rf /etc/unbound/root.key /var/unbound/etc/root.key
#sudo chown -R unbound:unbound {/var/lib/unbound/,/var/unbound/etc/,/etc/unbound/}

