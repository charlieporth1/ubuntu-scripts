#!/bin/bash
declare -a files=(
	.ssh/*
	.ssh/config
	.git-credentials
	.gitconfig
	.encpass
	.encpass/*
	.config/*
	.config/gcloud/*
)

for file in "${files[@]}"
do
	sudo cp -rf /home/$ADMIN_USR/$file /root/$file
	sudo chown -R root:root /root/$file
done
password="`uuidgen`--saltly"
#encpass-openssl-2021-08-08-1628434963.tgz

sudo rm -rf ~/.encpass/{keys,secrets}/alert_user.sh/

exported_file=$(sudo -u $ADMIN_USR encpass.sh export -k alert_user.sh | grep -oE "encpass-openssl-[0-9\.-]+*\.tgz" )
exported_file_path=/home/$ADMIN_USR/.encpass/exports/$exported_file
yes | encpass.sh import $exported_file_path
