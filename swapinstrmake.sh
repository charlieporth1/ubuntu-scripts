#!/bin/bash
dir=$1
size=$2
if [[ -n $dir ]] && [[ -n $size ]]; then
	#if [ "$(echo $dir | )" ]; then
		sudo fallocate -l $size /$dir
		sudo chmod 600 $dir
		sudo mkswap $dir
		sudo swapon $dir
		echo "$dir none swap sw 0 0" | sudo tee -a /etc/fstab

elif [[ $dir = "root" ]]; then
	sudo fallocate -l 1G /swapfile
	sudo chmod 600 /swapfile
	sudo mkswap /swapfile
	sudo swapon /swapfile
	echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab

else 
	echo "Usage:"
	echo ' $1 == dir; $2 == size folowed by a T|G|M|K'
	echo 'use $1 == root; swapfile will be made with in root dir'

fi
