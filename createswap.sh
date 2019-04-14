#!/bin/bash
echo "using dir $1 and size of $2"
dir=$1
size=$2
sudo fallocate -l $size $dir
ls -lh $dur
sudo chmod 600 $dir
sudo mkswap $1
sudo swapon $1
echo "$1 none swap sw 0 0" | sudo tee -a /etc/fstab


