#!/bin/bash
declare -a files=(
	.ssh/*
	.ssh/config
	.git-credentials
	.config/rclone/*
	.config/rclone/rclone.conf
	.gitconfig
	.encpass
	.encpass/*
	.config/*
	.config/gcloud/*
	.boto
)

for file in "${files[@]}"
do
	sudo cp -rf /home/$ADMIN_USR/$file /root/$file
	sudo chown -R root:root /root/$file
done
password="`uuidgen`--saltly"
#encpass-openssl-2021-08-08-1628434963.tgz


