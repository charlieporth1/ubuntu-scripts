#!/bin/bash
export SCRIPT_DIR=`dirname $0`
source $SCRIPT_DIR/.project_env.sh

HOST=ctptech.dev
CERT_ROOT_DIR=/etc/letsencrypt/live/$HOST

MASTER_MACHINE="ctp-vpn"
GCLOUD_PROJECT="galvanic-pulsar-284521"
GCLOUD_ZONE="us-central1-a"
PERONAL_USR=charlieporth1_gmail_com
# Configure Master server to get files
gcloud compute ssh $MASTER_MACHINE \
	--project "$GCLOUD_PROJECT" \
	--zone "$GCLOUD_ZONE" -- "sudo bash /home/$PERONAL_USR/Programs/cert_manager.sh && mkdir -p /tmp/ssl/ && sudo -u root cp -rfvL $CERT_ROOT_DIR/. /tmp/ssl/ && sudo -u root chown -R $PERONAL_USR:$PERONAL_USR /tmp/ssl/ && sudo rm -rf /tmp/ssl/{boot,bin}"

#sudo -u root chmod 7777 -R $PERONAL_USR /tmp/ssl/*

if ! [[ -d $HOME/ssl/ ]]; then
	mkdir -p $HOME/ssl
fi

if ! [[ -d /var/cache/nginx/ ]]; then
	mkdir -p /var/cache/nginx
fi

NGINX_SSL=$INSTALL_CONFIG_DIR/nginx/ssl/
# Copy files
bash $PROG/master_copy.sh '/tmp/ssl/*' "$HOME/ssl/" --important
bash $PROG/master_copy.sh "/var/cache/nginx/vpn.ctptech.dev.der" "/var/cache/nginx/"

sudo cp -rf ~/ssl/* $NGINX_SSL/
sudo cp -rf ~/ssl/* $INSTALL_CONFIG_DIR/unbound/ssl/
sudo chown -R unbound:unbound $UNBOUND/ssl


mkdir -p $CERT_ROOT_DIR
if [[ -d $NGINX_SSL ]]; then
  for i in $NGINX_SSL/*; do
    if [ -r $i ]; then
        ln -s $i $CERT_ROOT_DIR
    fi
  done
  unset i
  ln -s $NGINX_SSL/* $CERT_ROOT_DIR
fi

sleep 20s
rm -rf ~/ssl
gcloud compute ssh $MASTER_MACHINE \
        --project "$GCLOUD_PROJECT" \
        --zone "$GCLOUD_ZONE" -- "sudo rm -rf /tmp/ssl/"

