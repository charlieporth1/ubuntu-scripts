#!/bin/bash
if [[ $AUTOMATIC_INSTALL == 'false' ]] || [[ -z $AUTOMATIC_INSTALL ]]; then
	echo "Coping gravity.db"
	rclone -vvv copy remote:SERVER_DATA/gravity.db /etc/pihole

fi
#systemctl restart pihole-FTL.service
