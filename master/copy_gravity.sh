#!/bin/bash
source /etc/environment
GRAVITY=gravity.db
DB_FILE=${HOLE:-/etc/pihole}/$GRAVITY
CLONE_DIR=.config/rclone
CLONE_FILE=$CLONE_DIR/rclone.conf
echo "DB_FILE $DB_FILE"
source $PROG/replace_gravity.sh
#rclone config reconnect remote: -vvv
if [[ -n $ADMIN_USR ]]; then
	mkdir -p ~/$CLONE_DIR/
	ADMIN_HOME=${ADMIN_HOME:-/home/$ADMIN_USR}

	if [[ "$HOME" != "$ADMIN_HOME" ]]; then
		echo "Rclone config file found"
		cp -rf $ADMIN_HOME/$CLONE_FILE  ~/$CLONE_DIR/
	fi
fi

if [[ $AUTOMATIC_INSTALL == 'false' ]] || [[ -z $AUTOMATIC_INSTALL ]]; then
	echo "Coping gravity.db"
	sync
#                        --buffer-size 256M \
#                        --transfers 6 \
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
	sleep 10s

	if [[ `is_gravity_ok /tmp/$GRAVITY` == 'true' ]]; then
		echo "Coping gravity to $DB_FILE"
		bash $PROG/replace_gravity.sh /tmp/$GRAVITY
	else
		bash $PROG/alert_user.sh "Gravity is croupt please fix asap $HOSTNAME db_status: $db_status"
	fi
fi
#systemctl restart pihole-FTL.service
