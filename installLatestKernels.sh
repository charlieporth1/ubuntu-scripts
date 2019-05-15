#!/bin/bash
sudo bash /mnt/HDD/Programs/fixapt.sh
shopt -s expand_aliases
export ubuVer=`lsb_release -a | sed -n  '3p' | awk '{print $2}'`
export kernV=`uname -r`
export kernVC=`uname -r | cut -d "-" -f 1`
export kernVCMacro=`uname -r | cut -d "-" -f 2`
alias fourDig='grep -oE "\-[0-9]{1,2}{3,4}-" | tail -1 |cut -d "-" -f 2'
alias lastK="tail -1 |cut -d '-' -f 2"
export kernSearch=`sudo apt search`
#sudo apt search linux-headers-`uname -r | cut -d "-" -f 1` | grep -oE "\-[0-9]{1,2}{3,4}-" | tail -1 | cut -d "-" -f 2
export plHol1="_"
export plHol2="_2"
export plHol3="_3"
#"linux-headers-generic-hwe-$plHol1-edge" "linux-headers-gcp-edge"
declare -a kernelStrings
kernelStrings=("linux-buildinfo-$plHol1-oem" "linux-cloud-tools-$plHol1" "linux-image-extra-$plHol1" "linux-image-generic-hwe-$plHol1"
"linux-cloud-tools-generic-hwe-$plHol1" "linux-cloud-tools-common" "linux-cloud-tools-virtual-hwe-$plHol1" "linux-image-extra-virtual-hwe-$plHol1"
"linux-generic-hwe-plHol1" "linux-firmware" "linux-headers-$plHol1-oem" "linux-image-virtual-hwe-$plHol1" "linux-modules-$plHol1-oem"
"linux-headers-$plHol1" "linux-headers-generic-hwe-$plHol1" "linux-headers-oem" "linux-headers-virtual-hwe-$plHol1" "linux-hwe-cloud-tools-$plHol1" "linux-image-$plHol1-oem" 
 "linux-modules-extra-$plHol1" "linux-oem-headers-$plHol1" "linux-signed-generic-hwe-$plHol1" "linux-signed-image-generic-hwe-$plHol1"
"linux-tools-$plHol1-oem" "linux-tools-oem" "linux-tools-virtual-hwe-$plHol1")
declare -a diffSearchStrings
diffSearchStrings=("ubuVer" "kernV" "kernVC" )
for kernel in ${kernelStrings[@]}
do
#	for string in ${diffSearchStrings[@]}
#	do
		echo $kernel
		export kernP1=`echo $kernel | cut -d "$plHol1" -f 1`
		export kernP2=`echo $kernel | cut -d "$plHol1" -f 2`
		export searchForFourDig=`sudo apt search $(echo $kernP1$kernVC) | fourDig`
		export searchForKMVer=`sudo apt search $(echo $kernP1$kernVCMacro$kernP2) | lastK`
		export searchForKGVer=`sudo apt search $(echo $kernP1$kernV$kernP2) | lastK`
		export searchForKVer=`sudo apt search $(echo $kernP1$kernVC$kernP2) | lastK`
		export noSplit=`sudo apt search $kernel | lastK`
		if [[ -n "$searchForFourDig" ]]; then
			echo "found Kernel $searchForFourDig"
			kernel=$kernP1*$kernVC*$searchForFourDig*$kernP2
			echo "Kernel found: $kernel"
			sudo apt -y install 
		elif [[ -n "$searchForKMVer" ]]; then
			echo "found Kernel $searchForKMVer"
			kernel=$kernP1*$$kernVCMacro*$searchForKMVer*$kernP2
			echo "Kernel found: $kernel"
			sudo apt -y install
		elif [[ -n "$searchForKGVer" ]]; then
			echo "found Kernel $searchForKGVer" 
			kernel=$kernP1*$kernV*$searchForKGVer*$kernP2
			echo "Kernel found: $kernel"
			sudo apt -y install
		elif [[ -n "$searchForKVer" ]]; then
			echo "found Kernel $searchForKVer"
			kernel=$kernP1*$kernVC*$searchForKVer*$kernP2
			echo "Kernel found: $kernel"
			sudo apt -y install 
		elif [[  "$(echo $kernel | cut -d '-' -f 1)" = "$(echo $kernel)" ]] && [[ -n $noSplit ]]; then
			echo "found Kernel $noSplit"
			kernel=$noSplit
			echo "Kernel found: $kernel"
			sudo apt -y install $kernel
		else 
			 "kernel $kernel not found"
		fi
#	done
done

sudo apt-get autoremove
