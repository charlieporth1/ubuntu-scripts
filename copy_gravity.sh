#!/bin/bash
input="$1"
source $PROG/all-scripts-exports.sh
source $PROG/replace_gravity.sh
source /etc/environment
CONCURRENT

GRAVITY=gravity.db
DB_FILE=${HOLE:=/etc/pihole}/$GRAVITY
CLONE_DIR=.config/rclone
CLONE_FILE=$CLONE_DIR/rclone.conf

echo "DB_FILE $DB_FILE"
TMP_GRAVITY_FILE=/tmp/$GRAVITY
#rclone config reconnect remote: -vvv
if [[ -n $ADMIN_USR ]]; then
	mkdir -p ~/$CLONE_DIR/
	ADMIN_HOME=${ADMIN_HOME:-/home/$ADMIN_USR}

	if [[ "$HOME" != "$ADMIN_HOME" ]]; then
		echo "Rclone config file found"
		cp -rf $ADMIN_HOME/$CLONE_FILE ~/$CLONE_DIR/
	fi
fi

function remote_size_test() {
	rclone size remote:SERVER_DATA/$GRAVITY --json | jq '.bytes'
}
export -f remote_size_test

function copy_gravity() {
#                        --buffer-size 256M \
#                        --transfers 6 \
	local remote_size=$(remote_size_test)
	if [[ $min_gravity_size -le $remote_size ]]; then
		sync
		sudo rclone copy -vvv remote:SERVER_DATA/$GRAVITY /tmp/ \
                        --copy-links \
                        --no-gzip-encoding \
                        --progress \
                        --checksum \
                        --fast-list  \
                        --max-depth 10 \
                        --update \
                        --drive-impersonate charlieporth1@gmail.com || bash $PROG/alert_user.sh "ERROR DOWNLOADPLOADING GRAVITY $HOSTNAME" --channel="$default_channel"

		sync
	else
		echo "Gravity size is: $remote_size; min size is: $min_gravity_size. Not coping because it is too damn small"
		bash $PROG/alert_user.sh "ERROR DOWNLOADPLOADING GRAVITY $HOSTNAME" --channel="$default_channel"
	fi
}
export -f copy_gravity

function health_gravity_update() {
	local result=`is_gravity_ok $TMP_GRAVITY_FILE`
	if [[ "$result" == 'true' ]]; then
		echo "Coping gravity to $DB_FILE from $TMP_GRAVITY_FILE $result"
		bash $PROG/replace_gravity.sh $TMP_GRAVITY_FILE --no-check
	else
		bash $PROG/alert_user.sh "Gravity is croupt please fix asap $HOSTNAME $result" --channel="$default_channel"
	fi
}
export -f health_gravity_update

if [[ $AUTOMATIC_INSTALL == 'false' ]] || [[ -z $AUTOMATIC_INSTALL ]]; then
	echo "Coping $GRAVITY from GDrive"
	if [[ "$input" == '--health-check-gravity' ]]; then
		if ! [[ -f $TMP_GRAVITY_FILE ]]; then
			copy_gravity
			sleep 10s
		fi

		result=`is_gravity_ok $DB_FILE --quick-check`
		if [[ "$result" == 'false' ]]; then
		      bash $PROG/replace_gravity.sh $TMP_GRAVITY_FILE --no-check
		fi
	elif [[ -z "$input" ]]; then
		copy_gravity
		sleep 10s
		health_gravity_update
	else
		echo "N/A"
		bash $PROG/alert_user.sh "ERROR DOWNLOADPLOADING GRAVITY $HOSTNAME" --channel="$default_channel"
	fi
fi
#systemctl restart pihole-FTL.service

