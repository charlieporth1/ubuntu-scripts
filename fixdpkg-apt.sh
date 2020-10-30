#/bin/bash
if [ -f sudo rm -rf /var/lib/dpkg/lock* ]; then
	sudo rm -rf /var/lib/dpkg/lock*
fi 
if [ -f /var/cache/apt/archives/lock ]; then 
	sudo rm -rf /var/cache/apt/archives/lock
fi
if [ -f /var/cache/debconf/config.dat ]; then 
	sudo rm -rf /var/cache/debconf/config.dat
fi
sudo dpkg --configre -a

