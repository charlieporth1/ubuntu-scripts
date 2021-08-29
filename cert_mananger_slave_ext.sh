#!/bin/bash

certbot renew -n \
        --webroot -w $WWW \
        --staple-ocsp \
        --elliptic-curve secp256r1 \
        --key-type rsa \
        --rsa-key-size 2048 \
        --no-redirect \
        --cert-name home.ctptech.dev \
	--domain home.dns.ctptech.dev \
	--domain home.ctptech.dev
certbot renew -n \
        --webroot -w $WWW \
        --staple-ocsp \
        --elliptic-curve secp256r1 \
        --key-type rsa \
        --rsa-key-size 2048 \
        --no-redirect \
        --cert-name mbps.ctptech.dev \
	--domain mbps.ctptech.dev \
	--domain manual-browser-password-saver.ctptech.dev \
	--domain manual-browser-password-save.ctptech.dev \
	--domain manual-browsers-password-save.ctptech.dev \
	--domain manual-browsers-password-saver.ctptech.dev

