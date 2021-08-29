#!/bin/bash
echo "Starting cert manager"

# https://gist.github.com/tsaarni/14f31312315b46f06e0f1ecc37146bf3

HOST_SERVER=home.ctptech.dev
ROOT_KEY_DIR=/etc/letsencrypt

LIVE_KEY_DIR=$ROOT_KEY_DIR/live/$HOST_SERVER
ARHIVE_DIR=$ROOT_KEY_DIR/archive/$HOST_SERVER
# sudo rm -rf  $unbound/ssl/*
# MAY FIX IT TRY AFTER 05 == MAY CERTS EXPIRE THEN
# systemctl stop nginx
# rsa ecdsa
# ed25519 secp256r1 secp521r1
certbot renew -n \
        --webroot -w /var/www/html \
	--staple-ocsp \
	--elliptic-curve secp256r1 \
	--key-type rsa \
	--rsa-key-size 2048 \
        --no-redirect \
        --cert-name $HOST_SERVER 

# --test-cert --dry-run



#sudo certbot --cert-name vpn.ctptech.dev -d dns.ctptech.dev -d vpn.ctptech.dev -d doh.dns.ctptech.dev -d dot.ctptech.dev -n --nginx

cat $LIVE_KEY_DIR/fullchain.pem $LIVE_KEY_DIR/privkey.pem > $LIVE_KEY_DIR/combined.pem

if ! [[ -f $LIVE_KEY_DIR/dhparam.pem ]]; then
	openssl dhparam -dsaparam -out $LIVE_KEY_DIR/dhparam.pem 4096
fi

openssl x509 -outform der -in $LIVE_KEY_DIR/fullchain.pem -out fullchain.crt
openssl rsa -in $LIVE_KEY_DIR/combined.pem -out $LIVE_KEY_DIR/nopassword.key


certbot-ocsp-fetcher --output-dir=/var/cache/nginx/
certbot-ocsp-fetcher #/etc/letsen

# https://blog.pinterjann.is/ed25519-certificates.html
# ED25519
#openssl genpkey -algorithm ED25519 > ED25519.key
#openssl req -new -out $LIVE_KEY_DIR/fullchain-ED25519.csr -key $LIVE_KEY_DIR/ED25519.key -config $LIVE_KEY_DIR/openssl-25519.cnf
#openssl x509 -req -days 60 -in $LIVE_KEY_DIR/fullchain.csr -signkey $LIVE_KEY_DIR/ED25519.key -out $LIVE_KEY_DIR/combined.crt


echo "Cert Mananger done"
