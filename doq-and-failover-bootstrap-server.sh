#!/bin/bash
#ps -aux | grep 'dnsproxy'  | grep -v 'grep' | awk '{print $2}' | xargs sudo kill -9
#	sudo /home/$ADMIN_USR/doq-proxy/proxy -cert /etc/letsencrypt/live/vpn.ctptech.dev/cert.pem -listen 0.0.0.0:784 -key /etc/letsencrypt/live/vpn.ctptech.dev/privkey.pem -udp_backend 192.168.40.1:53
source /home/$ADMIN_USR/.gvm/scripts/gvm
#gvm install go1.15
#gvm use go1.15
LOG_FILE=$LOG/doq-dns-over-quic.log
export GOROOT=/home/$ADMIN_USR/go
if ! [[ -d $GOROOT ]]; then
	mkdir -p $GOROOT/{src,bin}
	mkdir -p $HOME/go/{src,bin}
fi
export GOPATH=$GOROOT/bin
export GOPATH_CURRENT=$HOME/go/bin
export PATH=$PATH:$GOPATH:$GOPATH_CURRENT
(go get github.com/AdguardTeam/dnsproxy)&

which dnsproxy
if [[ -z `which dnsproxy` ]]; then
	echo "BIN NOT FOUND EXTING"
	exit 1
fi
IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"
ROOT_NETWORK=`ifconfig | grep -E "(e(nx(.*)|th[0-9])|wlan[0-9])" -A 1 | grep -oE "inet $IP_REGEX" | grep -oE "$IP_REGEX"`
(dnsproxy --listen 0.0.0.0 --port=53 \
	--quic-port=784 --dnscrypt-port=7443 \
	--tls-port=853 --https-port=443 \
	--tls-crt=/etc/unbound/ssl/fullchain.pem \
	--tls-key=/etc/unbound/ssl/nopassword.key \
	--listen=$ROOT_NETWORK \
	--upstream=quic://master.dns.ctptech.dev \
	--upstream=tls://master.dns.ctptech.dev \
	--upstream=https://master.dns.ctptech.dev/dns-query \
	--upstream=master.dns.ctptech.dev \
        --fallback 35.192.105.158 --fallback 35.232.120.211 \
	--fallback=https://dns.adguard.com/dns-query \
	--fallback=tls://dns.adguard.com \
	--fallback=quic://dns.adguard.com \
	--bootstrap=35.192.105.158 --bootstrap=35.232.120.211 \
	--bootstrap=https://dns.adguard.com/dns-query \
	--bootstrap=tls://dns.adguard.com \
	--bootstrap=quic://dns.adguard.com \
	--cache --cache-size=3200000 --cache-min-ttl=15 \
	--fastest-addr --all-servers --udp-buf-size=64000 \
	---edns --verbose --output $LOG_FILE 2>&1 >> $LOG_FILE.out

#     --fallback=8.8.8.8 --fallback=8.8.4.4 \
#        --fallback=1.1.1.1 --fallback=1.0.0.1 --fallback=9.9.9.9 \
#	       --bootstrap=8.8.8.8 --bootstrap=1.1.1.1 \
#        --bootstrap=8.8.4.4 --bootstrap=1.0.0.1 --bootstrap=9.9.9.9 \

)& >> $LOG_FILE.outer

