#!/bin/bash
source $PROG/all-scripts-exports.sh
PERONAL_USR=charlieporth1_gmail_com

declare -a FILES
FILES=(
	/etc/fail2ban/jail.d/pihole-dns-1-block.conf
	/etc/fail2ban/jail.d/pihole-dns.conf
	/etc/fail2ban/filter.d/pihole-dns.conf
	/etc/fail2ban/filter.d/pihole-dns-1-block.conf
	/etc/dnsmasq.d/99-custom-settings.conf
	/etc/dnsmasq.d/14-InfoSec.conf
	/etc/dnsmasq.d/13-perf.conf
	/etc/dnsmasq.d/12-records.conf
	/etc/dnsmasq.d/10-servers.conf
	/etc/dnsmasq.d/10-servers-generated.conf
	/etc/dnsmasq.d/05-addint-standard.conf
	/etc/dnsmasq.d/07-customredirect.conf
	/etc/dnsmasq.d/02-pihole.conf
	/etc/dnsmasq.d/filter_lists.conf
	/etc/pihole/pihole-FTL.conf
	/etc/pihole/custom-dns-servers.conf
	/etc/pihole/dns-servers.conf{,bk}
	/etc/pihole/quick-{black,white}list.list
	/etc/pihole/google-{white,black}list.{list,regex}
	/etc/pihole/vulnerability-blacklist.regex
	/etc/pihole/vulnerability-pihole-blocked-query-types.regex
	/etc/pihole/youtube_regex_urls.txt
        /home/$PERONAL_USR/Programs/cert_manager.sh
	/home/$PERONAL_USR/Programs/pihole-lighttpd-changes.sh
	/home/$PERONAL_USR/Programs/pihole-db-sql-changes.sh
	/home/$PERONAL_USR/Programs/update_ads.sh
	/home/$PERONAL_USR/Programs/update.unbound-config.sh
	/home/$PERONAL_USR/Programs/update-pihole-config.sh
	/home/$PERONAL_USR/Programs/start_processes.sh
	/home/$PERONAL_USR/Programs/health-check.sh
)
TRANSFER_DIR=/tmp/cp_master_files

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

sudo rm -rf $TRANSFER_DIR
gcloud compute ssh $MASTER_MACHINE \
        --project "$GCLOUD_PROJECT" \
        --zone "$GCLOUD_ZONE" -- "sudo rm -rf $TRANSFER_DIR"


sudo bash $PROG/files_to_replace.sh
