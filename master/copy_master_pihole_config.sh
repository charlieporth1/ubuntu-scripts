#!/bin/bash
MASTER_MACHINE="ctp-vpn"
GCLOUD_PROJECT="galvanic-pulsar-284521"
GCLOUD_ZONE="us-central1-a"
PERONAL_USR=charlieporth1_gmail_com

declare -a FILES
FILES=(
	"/etc/fail2ban/jail.d/pihole-dns-1-block.conf"
	"/etc/fail2ban/jail.d/pihole-dns.conf"
	"/etc/fail2ban/filter.d/pihole-dns.conf"
	"/etc/fail2ban/filter.d/pihole-dns-1-block.conf"
	"/etc/dnsmasq.d/12-records.conf"
	"/etc/dnsmasq.d/10-servers.conf"
	"/etc/dnsmasq.d/99-custom-settings.conf"
	"/etc/dnsmasq.d/14-InfoSec.conf"
	"/etc/dnsmasq.d/13-perf.conf"
	"/etc/dnsmasq.d/07-customredirect.conf"
	"/etc/dnsmasq.d/02-pihole.conf"
	"/etc/dnsmasq.d/filter_lists.conf"
	"/etc/pihole/pihole-FTL.conf"
	"/etc/pihole/dns-servers.conf"
	"/etc/pihole/dns-servers.conf.bk"
        "/home/$PERONAL_USR/Programs/cert_manager.sh"
	"/home/$PERONAL_USR/Programs/pihole-lighttpd-changes.sh"
	"/home/$PERONAL_USR/Programs/pihole-db-sql-changes.sh"
	"/home/$PERONAL_USR/Programs/update_ads.sh"
	"/home/$PERONAL_USR/Programs/update.unbound-config.sh"
	"/home/$PERONAL_USR/Programs/update-pihole-config.sh"
	"/home/$PERONAL_USR/Programs/start_processes.sh"
	"/home/$PERONAL_USR/Programs/heath-check.sh"
)
for file in "${FILES[@]}"
do
	dir=`echo $file | rev | cut -d '/' -f 2- | rev`

	gcloud compute ssh $MASTER_MACHINE \
	        --project "$GCLOUD_PROJECT" \
	        --zone "$GCLOUD_ZONE" -- "mkdir -p /tmp/$dir && sudo cp -rf $file /tmp/$file && sudo chown -R $PERONAL_USR:$PERONAL_USR /tmp/$file"

	# Copy files
	if ! [[ -d $dir ]] && ! [[ -f $file ]]; then
		echo "$file needs to be relocated it cannot be copyed from to dir coping to /tmp"
		export rFile=/tmp/
	else
		export rFile=$file
	fi

	sudo gcloud compute scp $MASTER_MACHINE:/tmp/$file $rFile \
	        --scp-flag="-r" --project "$GCLOUD_PROJECT" --zone "$GCLOUD_ZONE"

done
sudo bash $PROG/files_to_replace.sh
