#!/bin/bash
export SCRIPT_DIR=`dirname $0`
source $SCRIPT_DIR/.project_env.sh
HOST=vpn.ctptech.dev
CERT_ROOT_DIR=/etc/letsencrypt/live/$HOST
MASTER_MACHINE="ctp-vpn"
GCLOUD_PROJECT="galvanic-pulsar-284521"
GCLOUD_ZONE="us-central1-a"
PERONAL_USR=charlieporth1_gmail_com
# Configure Master server to get files
gcloud compute ssh $MASTER_MACHINE \
	--project "$GCLOUD_PROJECT" \
	--zone "$GCLOUD_ZONE" -- "sudo bash /home/$PERONAL_USR/Programs/cert_manager.sh && mkdir /tmp/ssl/ && sudo cp -rfL $CERT_ROOT_DIR/. /tmp/ssl/ && sudo chown -R $PERONAL_USR:$PERONAL_USR /tmp/ssl && sudo rm -rf /tmp/ssl/{boot,bin}"

if ! [[ -d $HOME/ssl/ ]]; then
	mkdir -p $HOME/ssl
fi

if ! [[ -d /var/cache/nginx/ ]]; then
	mkdir -p /var/cache/nginx
fi

ROOT_SSL_DIR=/etc/letsencrypt/live/vpn.ctptech.dev
NGINX_SSL=$INSTALL_CONFIG_DIR/nginx/ssl/
# Copy files
gcloud compute scp $MASTER_MACHINE:/tmp/ssl/* ~/ssl/ \
	--scp-flag="-r" --project "$GCLOUD_PROJECT" --zone "$GCLOUD_ZONE"

gcloud compute scp $MASTER_MACHINE:/var/cache/nginx/vpn.ctptech.dev.der /var/cache/nginx/ \
	--scp-flag="-r" --project "$GCLOUD_PROJECT" --zone "$GCLOUD_ZONE"

cp -rf ~/ssl/* $NGINX_SSL
cp -rf ~/ssl/* $INSTALL_CONFIG_DIR/unbound/ssl/

mkdir -p $ROOT_SSL_DIR

if [[ -d $NGINX_SSL ]]; then
  for i in $NGINX_SSL/*; do
    if [ -r $i ]; then
        ln -s $i $ROOT_SSL_DIR
        ln -s $i* $ROOT_SSL_DIR
    fi
  done
  unset i
  ln -s $NGINX_SSL/* $ROOT_SSL_DIR
fi


rm -rf ~/ssl
