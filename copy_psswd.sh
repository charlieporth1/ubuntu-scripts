#!/bin/bash
SCRIPT_DIR=`realpath .`
shopt -s expand_aliases
ROOT_DIR=/opt/config/.ctp
export ENCPASS_HOME_DIR=$ROOT_DIR/.encpass

mkdir -p -m 755 $ENCPASS_HOME_DIR 2>/dev/null
chown -R $ADMIN_USR:nogroup $ROOT_DIR 2> /dev/null
chmod -R 755 $ROOT_DIR 2> /dev/null

MASTER_MACHINE="ctp-vpn"
GCLOUD_PROJECT="galvanic-pulsar-284521"
GCLOUD_ZONE="us-central1-a"
PERONAL_USR=charlieporth1_gmail_com

exported_ssh_file_dir=/home/$PERONAL_USR/.encpass/exports
exported_file_dir=/home/$ADMIN_USR/.encpass/exports
recive=~/.sec_hook

mkdir -p $recive
passwd="`uuidgen`--salty"
grep_tar_file="grep -oE 'encpass-openssl-[0-9\.-]+\.tgz.enc'"

alias grep-tar-file="$grep_tar_file"

function expect_import() {
        local spawn_cmd="$4"
	local user_input="$3"
        local usr="${user_input:=$USER}"
        local exported_full_path_file="$1"
        local passwd="$2"
	export ENCPASS_HOME_DIR="${ENCPASS_HOME_DIR:-$HOME/.encpass}"
sudo expect << EOF

set timeout 5

spawn $spawn_cmd

expect -exact "Import file: $exported_full_path_file\r
To directory: $ENCPASS_HOME_DIR\r
\r
Enter Password for import file:"

send -- "$passwd\r"

expect -exact "\r
Confirm Password:"

send -- "$passwd\r"

expect -exact "\r
\r
WARNING: Overwrite flag is set. Importation will overwrite any existing secrets/keys that have the same name.\r
Are you sure you want to proceed with the import? \[y/N\]"

send -- "y\r"
expect eof
EOF
echo "**************************************"
echo "DONE *********************************"
}


function run_import() {
	sudo chown -R $USER:$USER $recive

	local exported_full_path_file="$1"
	local passwd="$2"
	local user_input="$3"
        local usr="${user_input:=$USER}"
	local spawn_cmd="bash -c \"export ENCPASS_HOME_DIR=$ENCPASS_HOME_DIR && encpass.sh import -o -p $exported_full_path_file\""
	expect_import "$exported_full_path_file" "$passwd" "$usr" "$spawn_cmd"

	local spawn_cmd="encpass.sh import -o -p $exported_full_path_file"
	expect_import "$exported_full_path_file" "$passwd" "$usr" "$spawn_cmd"

}

function run_cleanup() {
	unset passwd
	sudo rm -rf $recive/*.tgz*
	sudo rm -rf $exported_file_dir/*.tgz*
	gcloud compute ssh $MASTER_MACHINE \
        	--project "$GCLOUD_PROJECT" \
        	--zone "$GCLOUD_ZONE" -- "sudo rm -rf $TRANSFER_DIR; sudo rm -rf $exported_ssh_file_dir/*.tgz*"
	chown -R $ADMIN_USR:nogroup $ROOT_DIR 2> /dev/null
	chmod -R 755 $ROOT_DIR 2> /dev/null
}

function transfer_ssh() {
	local exported_file=$(gcloud compute ssh $MASTER_MACHINE \
        	--project "$GCLOUD_PROJECT" \
        	--zone "$GCLOUD_ZONE" -- "sudo -u $PERONAL_USR yes \"$passwd\" | encpass.sh export -k alert_user.sh | $grep_tar_file | $grep_tar_file")

	local exported_file=$(echo $exported_file | grep-tar-file)

	bash $PROG/master_copy.sh "$exported_ssh_file_dir/$exported_file" "$recive/"

	run_import "$recive/$exported_file" "$passwd" "$ADMIN_USR"
	run_cleanup
}

function transfer_local_user() {
	local user_input="$1"
        local usr="${user_input:=$USER}"
	local exported_file=$(sudo -u $ADMIN_USR yes "$passwd" | encpass.sh export -k alert_user.sh | grep-tar-file)

	local exported_file=$(echo $exported_file | grep-tar-file)
	full_file_path="$exported_file_dir/$exported_file"
	run_import "$full_file_path" "$passwd" "$usr"
	sleep 2.5s
	run_cleanup
}

if [[ "$1" == '--root' ]]; then
	transfer_local_user root
elif [[ "$1" == '--user' ]]; then
	transfer_local_user "$USER"
else
	transfer_ssh
fi


sudo chown -R $USER:root ~/.encpass/
unset ENCPASS_HOME_DIR
