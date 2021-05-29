#!/bin/bash
pihole -up
wget -O /tmp/install.sh https://raw.githubusercontent.com/PiPass/bin/master/install.sh
sudo ./install.sh
bash <(wget -qO- https://sputnik.roen.us/pipass/scripts/install.sh)
curl --insecure -sSL https://sputnik.roen.us/pipass/scripts/install.sh | bash
cd $WWW
git clone https://github.com/pipass/blockpage
cp -rf $WWW/blockpage/blockpage/unblock/index.php $WWW/blockpage/blockpage/unblock/index.php.org
cp -rf /home/$ADMIN_USR/index.php $WWW/blockpage/blockpage/unblock/index.php
sudo unlink /usr/sbin/dnsmasq
sudo ln -s /usr/local/sbin/dnsmasq /usr/sbin/dnsmasq
bash $PROG/pihole-lighttpd-changes.sh

curl -sSL https://raw.githubusercontent.com/PiPass/bin/master/install.sh | bash
curl -sSL https://raw.githubusercontent.com/PiPass/bin/master/update.sh | bash
sudo chown -R www-data:www-data /var/www/html/blockpage/
curl https://raw.githubusercontent.com/Zelo72/rpi/master/pihole/migratePiholeAdlists.py |\
 sudo tee /usr/local/bin/migratePiholeAdlists.py
sudo chmod 777 /usr/local/bin/migratePiholeAdlists.py 
curl https://raw.githubusercontent.com/mmotti/PyPhDB/master/PyPhDB.py | \
sudo tee /usr/local/bin/PyPhDB.py
sudo chmod 777 /usr/local/bin/PyPhDB.py
