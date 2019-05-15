#!/bin/bash
cKernel=$(uname -r)
lKernel=$(cat /mnt/HDD/lastK)
rootDir=/mnt/HDD/Kernel
#sudo bash /mnt/HDD/Programs/installLatestKernels.sh 
function testModprobe() {
	local mod=$1
	depmod -a
	modprobe $mod 2>/tmp/kernel$mod\Tmp ##checking for modprobe errors 2> or redirect 2 is error redirect
	local testCmd=`cat /tmp/kernel$mod\Tmp`
	if [[ -n $testCmd  ]]; then
		echo true
		rm /tmp/kernel$mod\Tmp
	else
		echo false
		rm /tmp/kernel$mod\Tmp
	fi
	return
 }
cd $rootDir
if [[ $cKernel != $lKernel ]] || [[ -z $lKernel ]]; then
	cd $rootDir
	. /usr/bin/cred.sh
	sendemail -f $USER@otih-oith.us.to -t $phonee -m "Kernel has changed installing custom modules; kernel was: $lKernel; and now is: $cKernel; Date $(date)" -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp $passwd 
	if [ ! -d rapiddisk ]; then
		git clone https://github.com/pkoutoupis/rapiddisk/
	else 
		git pull
	fi
	cd rapiddisk
	make dkms
	make tools-install
	make install
	cd $rootDir
	if   [ ! -d frandom* ]; then
		wget http://billauer.co.il/download/frandom-1.2.tar.gz
		tar -xvf frandom*

	fi
	cd frandom-1.2
	make
	install -m 644 frandom.ko /lib/modules/`uname -r`/kernel/drivers/misc/
	echo "kernel/frandom.ko" >> /lib/modules/`uname -r`/modules.order 
	cd $rootDir
	declare -a totalKM=('rapiddisk' 'rapiddisk-cache' 'frandom')
	for mod in ${#totalKM[@]}
	do
		success=`testModprobe $mod`
		if [[ $success == true ]]; then
			if [[ ${totalKM[@]} == $mod ]]; then
				echo $cKernel > /mnt/HDD/lastK
				sendemail -f $USER@otih-oith.us.to -t $phonee -m "Install of custom kernel modules successful"-s smtp.gmail.com:587 -o tls=yes -xu  $usr -xp $passwd 
			fi
		else
			sendemail -f $USER@otih-oith.us.to -t $phonee -m "Install of custom kernel modules unsuccessful; please check why"-s smtp.gmail.com:587 -o tls=yes -xu  $usr -xp $passwd 
			sleep 5s
			break
		fi
	done
else
	echo "same k"
fi

