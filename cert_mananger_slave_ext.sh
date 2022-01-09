#!/bin/bash
if [[ -z $ROOT_KEY_DIR ]]; then
	source $PROG/cert_manager.sh
fi
sudo mkdir -p $WWW/.well-known/{acme-challenge,pki-validation}/

HOST_SERVER=home.ctptech.dev
ROOT_KEY_DIR=/etc/letsencrypt

LIVE_KEY_DIR=$ROOT_KEY_DIR/live/$HOST_SERVER
ARHIVE_DIR=$ROOT_KEY_DIR/archive/$HOST_SERVER
#        --webroot -w $WWW \

sudo certbot certonly -n \
	$DEFAULT_CERT_OPTS \
	$INFO_SEC_CERT_OPTS \
	--standalone \
        --cert-name $HOST_SERVER \
	--domain home.dns.ctptech.dev \
	--domain $HOST_SERVER

#	--dns-rfc2136 \
cat $LIVE_KEY_DIR/fullchain.pem $LIVE_KEY_DIR/privkey.pem > $LIVE_KEY_DIR/combined.pem
openssl rsa -in $LIVE_KEY_DIR/combined.pem -out $LIVE_KEY_DIR/nopassword.key

HOST_SERVER=mbps.ctptech.dev

LIVE_KEY_DIR=$ROOT_KEY_DIR/live/$HOST_SERVER
ARHIVE_DIR=$ROOT_KEY_DIR/archive/$HOST_SERVER

sudo certbot certonly -n \
        --webroot -w $WWW/chrome_man_password_save \
	$DEFAULT_CERT_OPTS \
        $INFO_SEC_CERT_OPTS \
        --cert-name $HOST_SERVER \
	--http-01-port=80 \
	--domain $HOST_SERVER \
	--domain manual-browser-password-saver.ctptech.dev \
	--domain manual-browser-password-save.ctptech.dev \
	--domain manual-browsers-password-save.ctptech.dev \
	--domain manual-browsers-password-saver.ctptech.dev

cat $LIVE_KEY_DIR/fullchain.pem $LIVE_KEY_DIR/privkey.pem > $LIVE_KEY_DIR/combined.pem
openssl rsa -in $LIVE_KEY_DIR/combined.pem -out $LIVE_KEY_DIR/nopassword.key
