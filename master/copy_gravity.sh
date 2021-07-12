#!/bin/bash
CLONE_DIR=.config/rclone
CLONE_FILE=$CLONE_DIR/rclone.conf
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
	sudo rm -rf /tmp/gravity.db
	sync
	rclone -vvv copy remote:SERVER_DATA/gravity.db /tmp/
	db_status=`sqlite3 /tmp/gravity.db "PRAGMA integrity_check" | grep -io 'ok'`
	if [[ -n "$db_status" ]]; then
		sudo mv /tmp/gravity.db /etc/pihole/gravity.db
		sudo bash $PROG/pihole-db-sql-changes.sh
	else
		bash $PROG/alert_user.sh "Gravity is croupt please fix asap $HOSTNAME db_status: $db_status"
	fi
	sync
fi
#systemctl restart pihole-FTL.service
