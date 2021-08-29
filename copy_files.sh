#!/bin/bash
SCRIPT_DIR=`realpath .`
source $SCRIPT_DIR/.project_env.sh

MASTER_MACHINE="ctp-vpn"
GCLOUD_PROJECT="galvanic-pulsar-284521"
GCLOUD_ZONE="us-central1-a"
PERONAL_USR=charlieporth1_gmail_com

declare -a FILES
FILES=(
	"/usr/local/bin/cred.sh"
	"/home/$PERONAL_USR/.git*"
)
#	"/home/$PERONAL_USR/.encpass/*"
#	"/home/$PERONAL_USR/.encpass"

TRANSFER_DIR=/tmp/cp_slave_files

mkdir -p $TRANSFER_DIR
gcloud compute ssh $MASTER_MACHINE \
	--project "$GCLOUD_PROJECT" \
        --zone "$GCLOUD_ZONE" -- "mkdir -p $TRANSFER_DIR"

for file in "${FILES[@]}"
do
        dir=`echo $file | rev | cut -d '/' -f 2- | rev`

        gcloud compute ssh $MASTER_MACHINE \
                --project "$GCLOUD_PROJECT" \
                --zone "$GCLOUD_ZONE" -- "sudo cp -rf $file $TRANSFER_DIR/ && sudo chown -R $PERONAL_USR:$PERONAL_USR $TRANSFER_DIR/"

        # Copy files
        if ! [[ -d $dir ]] && [[ -z `echo $file | grep -o "$PERONAL_USR"` ]]; then
                echo "$file needs to be relocated it cannot be copyed from to dir coping to /tmp"
                export rFile=$TRANSFER_DIR
	elif [[ -z `echo $file | grep -o "$PERONAL_USR"` ]]; then
	        path=`echo "$file" | awk -F"/$PERONAL_USR" '{print $2}'`
		export rFile=$HOME/$path
        else
                export rFile=$file
        fi
	bash $PROG/master_copy.sh "$TRANSFER_DIR/$file" "$rFile"

done


