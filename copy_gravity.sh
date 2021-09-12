#!/bin/bash
input="$1"
source /etc/environment
GRAVITY=gravity.db
DB_FILE=${HOLE:=/etc/pihole}/$GRAVITY
CLONE_DIR=.config/rclone
CLONE_FILE=$CLONE_DIR/rclone.conf
echo "DB_FILE $DB_FILE"
source $PROG/replace_gravity.sh
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

function copy_gravity() {
#                        --buffer-size 256M \
#                        --transfers 6 \
	sync
	sudo rclone copy -vvv remote:SERVER_DATA/$GRAVITY /tmp/ \
                        --copy-links \
                        --no-gzip-encoding \
                        --progress \
                        --checksum \
                        --fast-list  \
                        --max-depth 10 \
                        --update \
                        --drive-impersonate charlieporth1@gmail.com

	sync
}
function health_gravity_update() {
	if [[ "`is_gravity_ok $TMP_GRAVITY_FILE`" == 'true' ]]; then
		echo "Coping gravity to $DB_FILE from $TMP_GRAVITY_FILE"
		bash $PROG/replace_gravity.sh $TMP_GRAVITY_FILE --no-check
	else
		bash $PROG/alert_user.sh "Gravity is croupt please fix asap $HOSTNAME"
	fi

}
if [[ $AUTOMATIC_INSTALL == 'false' ]] || [[ -z $AUTOMATIC_INSTALL ]]; then
	echo "Coping gravity.db"
	if [[ "$input" == '--health-check-gravity' ]] && [[ -f $health_gravity_update ]]; then
		if [[ "`is_gravity_ok $DB_FILE --quick-check`" == 'false' ]]; then
		      bash $PROG/replace_gravity.sh $TMP_GRAVITY_FILE --no-check
		fi
	else
		copy_gravity
		sleep 10s
		health_gravity_update
	fi
fi
#systemctl restart pihole-FTL.service

