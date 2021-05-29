#!/bin/bash
IFS=$'\n'
usage=`for line in $(ifconfig | grep "GB\|MB"); do echo "\"$line\""; done`
echo "$usage,`date`," >> /mnt/HDD/internetUsage.csv
sleep 10s
sudo rclone delete -v Gdrive:work/internetUsage.csv  | parallel #-Jcluster
sudo rclone copy -v /mnt/HDD/internetUsage.csv  Gdrive:work/internetUsage.csv | parallel
