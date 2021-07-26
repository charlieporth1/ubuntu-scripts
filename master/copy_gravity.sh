#!/bin/bash
source /etc/environment
GRAVITY=gravity.db
DB_FILE=$HOLE/$GRAVITY
CLONE_DIR=.config/rclone
CLONE_FILE=$CLONE_DIR/rclone.conf
echo "DB_FILE $DB_FILE"

function is_gravity_ok() {
        local db_file="${1:-$DB_FILE}"
        local OK_STR='ok'
        local db_status=`sudo sqlite3 $db_file "PRAGMA integrity_check" | grep -io "$OK_STR"`
        sync
        if [[ "$db_status" == "$OK_STR" ]] && [[ -f $db_file ]]; then
                echo "true"
        else
                echo "false"
        fi
}

if [[ -n $ADMIN_USR ]]; then
	mkdir -p ~/$CLONE_DIR/

	if [[ -f /home/$ADMIN_USR/$CLONE_FILE ]]; then
		echo "Rclone config file found"
		cp -rf /home/$ADMIN_USR/$CLONE_FILE ~/$CLONE_FILE
	else
		echo "Rclone  NOT PLEASE FIND config file found"
	fi
fi

if [[ $AUTOMATIC_INSTALL == 'false' ]] || [[ -z $AUTOMATIC_INSTALL ]]; then
	echo "Coping gravity.db"
	sync
#                        --buffer-size 256M \
#                        --transfers 6 \
	rclone copy -vvv remote:SERVER_DATA/$GRAVITY /tmp/ \
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

	is_gravity_ok /tmp/$GRAVITY
	if [[ `is_gravity_ok /tmp/$GRAVITY` == 'true' ]]; then
		echo "Coping gravity to $DB_FILE"
		sudo rm -rf $DB_FILE*
		sudo cp -rf /tmp/$GRAVITY $DB_FILE
		is_gravity_ok
	else
		bash $PROG/alert_user.sh "Gravity is croupt please fix asap $HOSTNAME db_status: $db_status"
	fi
	sync
	sudo bash $PROG/pihole-db-sql-changes.sh
        sudo bash $PROG/generarte_vulnerability-blacklist.sh
        sudo bash $PROG/white-regex-yt.sh
	sync
fi
#systemctl restart pihole-FTL.service
