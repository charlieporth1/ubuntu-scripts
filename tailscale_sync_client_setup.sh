#!/bin/bash
[[ -f /usr/local/bin/tailscale_sync_client_env.sh ]] && source tailscale_sync_client_env.sh
sudo ln -s ~/tailscale_sync_client_env.sh /usr/local/bin/tailscale_sync_client_env.sh
if ! [[ -d $PROG ]]; then
	mkdir -p $PROG/
if [[ -z $PROG ]]; then
	if [[ -n $ADMIN_HOME ]]; then
		PROG=$ADMIN_HOME/Programs
		mkdir -p $PROG
	elif [[ -n $ADMIN_USR ]]; then
		PROG=/home/$ADMIN_USR/Programs
		mkdir -p $PROG
	fi
else
	PROG=/root/Programs
	mkdir -p $PROG
fi

CTP_INSTALL='# CTP INSTALL `date`'
if [[ -f /etc/environment ]] && [[ -z `grep "$CTP_INSTALL" /etc/environment` ]]; then

echo """
$CTP_INSTALL
PROG=$PROG
""" | sudo tee -a /etc/environment

fi

CROND=/etc/cron.d/
echo """
15   */4 *   *   *    root $PROG/tailscale_sync_client_cron.sh
30   */8 *   *   *    root $PROG/tailscale_sync_client_setup.sh
""" | sudo tee $CROND/tailscale_cron_setup
