#!/bin/bash




sudo mkdir -p $WWW/.well-known/{acme-challenge,pki-validation}/

HOST_SERVER=home.ctptech.dev
ROOT_KEY_DIR=/etc/letsencrypt

LIVE_KEY_DIR=$ROOT_KEY_DIR/live/$HOST_SERVER
ARHIVE_DIR=$ROOT_KEY_DIR/archive/$HOST_SERVER

sudo certbot certonly -n \
        --webroot -w $WWW \
        --staple-ocsp \
        --elliptic-curve secp256r1 \
        --key-type rsa \
        --rsa-key-size 2048 \
        --no-redirect \
        --cert-name $HOST_SERVER \
	--domain home.dns.ctptech.dev \
	--domain $HOST_SERVER

cat $LIVE_KEY_DIR/fullchain.pem $LIVE_KEY_DIR/privkey.pem > $LIVE_KEY_DIR/combined.pem
openssl rsa -in $LIVE_KEY_DIR/combined.pem -out $LIVE_KEY_DIR/nopassword.key

HOST_SERVER=mbps.ctptech.dev

LIVE_KEY_DIR=$ROOT_KEY_DIR/live/$HOST_SERVER
ARHIVE_DIR=$ROOT_KEY_DIR/archive/$HOST_SERVER

sudo certbot certonly -n \
        --webroot -w $WWW \
        --staple-ocsp \
        --elliptic-curve secp256r1 \
        --key-type rsa \
        --rsa-key-size 2048 \
        --no-redirect \
        --cert-name $HOST_SERVER \
	--domain $HOST_SERVER \
	--domain manual-browser-password-saver.ctptech.dev \
	--domain manual-browser-password-save.ctptech.dev \
	--domain manual-browsers-password-save.ctptech.dev \
	--domain manual-browsers-password-saver.ctptech.dev

cat $LIVE_KEY_DIR/fullchain.pem $LIVE_KEY_DIR/privkey.pem > $LIVE_KEY_DIR/combined.pem
openssl rsa -in $LIVE_KEY_DIR/combined.pem -out $LIVE_KEY_DIR/nopassword.key
