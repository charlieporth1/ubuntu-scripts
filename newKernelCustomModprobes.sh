#!/bin/bash
cKernel=$(uname -r)
lKernel=$(cat /mnt/HDD/lastK)
cd /mnt/HDD/Kernel
if [[ $cKernel != $lKernel ]] || [[ -z $lKernel ]]; then
	echo $cKernel > /mnt/HDD/lastK
	. /usr/bin/cred.sh
	sendemail -f $USER@otih-oith.us.to -t $phonee -m "Kernel has chaned installing custom modules; kernel was: $lKernel; and now is: $cKernel; Date $(date)" -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp $passwd |
	cd /mnt/HDD/Kernel
	if [ ! -d rapiddisk ]; then
		git clone https://github.com/pkoutoupis/rapiddisk/
	else 
		git pull
	fi
	cd rapiddisk
	make dkms
	make tools-install
	make install

	if   [ ! -d frandom* ]; then
		wget http://billauer.co.il/download/frandom-1.2.tar.gz
	fi
	tar -xvf frandom*
	cd frandom*
	make
	install -m 644 frandom.ko /lib/modules/`uname -r`/kernel/drivers/misc/
	echo "kernel/frandom.ko" >> /lib/modules/`uname -r`/modules.order 
else
	echo "same k"
fi
