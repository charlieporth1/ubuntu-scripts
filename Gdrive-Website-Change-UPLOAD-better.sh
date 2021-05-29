#! /usr/bin/env bash

FILELIST=/mnt/HDD/filelist
MONITOR_DIR=/var/www/

[[ -f ${FILELIST} ]] || ls ${MONITOR_DIR} > ${FILELIST}

while : ; do
    cur_files=$(ls ${MONITOR_DIR})
    diff <(cat ${FILELIST}) <(echo $cur_files) || \
         { echo "Alert: ${MONITOR_DIR} changed" ;
           # Overwrite file list with the new one.
           echo $cur_files > ${FILELIST} ;
sudo rclone delete -v Gdrive:www
sudo rclone copy -v /var/www/ Gdrive:www         
	}

    echo "Waiting for changes."
    sleep $(expr 60 \* 2)
done
