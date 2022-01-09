#!/bin/bash
FILE=/dev/null
REQUIRED_PERMISSIONS=666
ACTUAL_PERMISSIONS=$(stat -c '%a' "$FILE")
if ! [[ -f $FILE ]] || [[ $REQUIRED_PERMISSIONS != $ACTUAL_PERMISSIONS ]]; then
	echo "Fixing $FILE REQUIRED_PERMISSIONS != ACTUAL_PERMISSIONS $REQUIRED_PERMISSIONS != $ACTUAL_PERMISSIONS"
	sudo rm -rf $FILE
	sudo mknod -m 666 $FILE c 1 3
	sudo chmod -R 666 $FILE
	sudo chown -R root:root $FILE
fi
