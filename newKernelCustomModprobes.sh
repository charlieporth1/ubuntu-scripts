#!/bin/bash
cKernel=$(uname -r)
lKernel=$(cat /mnt/HDD/lastK)
rootDir=/mnt/HDD/Kernel
function testModprobe() {
	local mod=$1
	depmod -a
	modprobe $mod 2> /tmp/kernel$mod\Tmp  ##checking for modprobe errors 2> or redirect 2 is error redirect
	local testCmd=`cat /tmp/kernel$mod\Tmp`
	if [[ -z $testCmd  ]]; then
		echo true
		rm /tmp/kernel$mod\Tmp
	else
		echo false
		#rm /tmp/kernel$mod\Tmp
	fi
	return
 }
cd $rootDir
if [[ $cKernel != $lKernel ]] || [[ -z $lKernel ]]; then
	sudo bash /mnt/HDD/Programs/installLatestKernels.sh 
	cd $rootDir
	pwd
	echo "rootDir $rootDir"
	echo "pwd "`pwd`
	. /usr/bin/cred.sh
	sendemail -f $USER@otih-oith.us.to -t $phonee -m "Kernel has changed installing custom modules; kernel was: $lKernel; and now is: $cKernel; Date $(date)" -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp $passwd 
	if [ ! -d rapiddisk ]; then
		git clone https://github.com/pkoutoupis/rapiddisk/ $rootDir/rapiddisk
	else
		git pull
	fi
	cd rapiddisk
	make dkms
	make tools-install
	make install
	chmod 777   /lib/modules/`uname -r`/kernel/
	cd $rootDir
	if   [ ! -d frandom* ]; then
		wget http://billauer.co.il/download/frandom-1.2.tar.gz -o $rootDir
		tar -xvf frandom*

	fi
	cd frandom-1.2
	make
	install -m 644 frandom.ko /lib/modules/`uname -r`/kernel/drivers/misc/
	echo "kernel/frandom.ko" >> /lib/modules/`uname -r`/modules.order 
	cd $rootDir
	declare -a totalKM=('rapiddisk' 'rapiddisk-cache' 'frandom')
	for mod in ${totalKM[@]}
	do
		success=`testModprobe $mod`
		echo "$mod was successful $success"
		echo "mod #: ${#totalKM[@]} "
		echo "mod #: ${totalKM[@]} "
		echo "count: $count"
		if [[ $success == "true" ]]; then
			if [[ ${totalKM[${#totalKM[@]}]} == $mod ]]; then
				echo $cKernel > /mnt/HDD/lastK
				sleep 3s
				sendemail -f $USER@otih-oith.us.to -t $phonee -m "Install of custom kernel modules successful; Date `date`" -s smtp.gmail.com:587 -o tls=yes -xu  $usr -xp $passwd 
				sleep 1s
			fi
		else
			sleep 5s
			echo "Problem module $mod; trying make uninstall"
			modprobe -r $mod
			cd $rootDir
			dir=`ls -d $mod*/`
			cd $dir 
			make uninstall
			cd $rootDir
			rm -rf $dir
			sendemail -f $USER@otih-oith.us.to -t $phonee -m "Install of custom kernel modules unsuccessful; problem module $mod; Date `date`; please check why" -s smtp.gmail.com:587 -o tls=yes -xu  $usr -xp $passwd 
			echo "unsuccessful"
			cd $rootDir
			sleep 5s
			break
		fi
	done
else
	echo "same k"
fi

