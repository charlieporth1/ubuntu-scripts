#!/bin/bash
source /etc/environment
DEFAULT_PROG=${PROG:=$CONF_PROG_DIR}

# LN EXYRA
sudo ln -s /etc/fail2ban/filter.d/ctp-custom-vars.conf   /etc/fail2ban/filter.d/common.local

sudo ln -s $PROG/{ctp-dns,nginx-dns-rfc,ctp-fail-over-dns,ctp-auto-6to4,ctp-network-zeroteir}.service /etc/systemd/system/

if [[ "$HOSTNAME" == 'ctp-vpn' ]]; then
	sudo ln -s $PROG/{ctp-yt-ttl-dns,ctp-YouTube-Ad-Blocker,ctp-dns-dnscrypt,pihole-loadbalancer-ctp-dns}.service /etc/systemd/system/
fi

if [[ "$HOSTNAME" == 'ubuntu-server' ]]; then
	sudo ln -s $PROG/pihole-loadbalancer-ctp-dns.service /etc/systemd/system/
fi

# LN $PROG
sudo ln -s $DEFAULT_PROG/{regexify,grepify,new_linify,csvify,decsvify}.sh /usr/local/bin
sudo ln -s $DEFAULT_PROG/csvify.sh /usr/local/bin/csvify
sudo ln -s $DEFAULT_PROG/decsvify.sh /usr/local/bin/decsvify
sudo ln -s $DEFAULT_PROG/regexify.sh /usr/local/bin/regexify
sudo ln -s $DEFAULT_PROG/new_linify.sh /usr/local/bin/new_linify
sudo ln -s $DEFAULT_PROG/grepify.sh /usr/local/bin/grepify

sudo ln -s $DEFAULT_PROG/netpid.sh /usr/local/bin
sudo ln -s $DEFAULT_PROG/netpid.sh /usr/local/bin/netpid
sudo ln -s $DEFAULT_PROG/timeout3 /usr/local/bin
sudo ln -s $DEFAULT_PROG/cat_comments.sh /usr/local/bin/cat_comments.sh
sudo ln -s $DEFAULT_PROG/cat_comments.sh /usr/local/bin/cat_comments
sudo ln -s $DEFAULT_PROG/cat_comments.sh /usr/local/bin/ccat.sh
sudo ln -s $DEFAULT_PROG/cat_comments.sh /usr/local/bin/ccat

sudo ln -s $DEFAULT_PROG/ctp-pihole.sh /usr/local/bin/ctp-pihole.sh
sudo ln -s $DEFAULT_PROG/ctp-pihole.sh /usr/local/bin/ctp-pihole

# LN $ROUTE
sudo ln -s $ROUTE/ctp-dns.sh /usr/local/bin/ctp-dns
sudo ln -s $ROUTE/ctp-dns.sh /usr/local/bin/

# CHMOD $PROG
sudo chmod 777 $ROUTE/ctp-dns.sh
sudo chmod 777 $DEFAULT_PROG/{regexify,grepify,new_linify,csvify}.sh
sudo chmod 777 $DEFAULT_PROG/{cat_comments,netpid}.sh
sudo chmod 777 $DEFAULT_PROG/timeout3
sudo chmod 777 $DEFAULT_PROG/ctp-pihole.sh

# CHMOD /usr/local/bin/
sudo chmod 777 /usr/local/bin/ctp-{dns,pihole}{,.sh}
sudo chmod 777 /usr/local/bin/{regexify,grepify,new_linify,{de,}csvify}{,.sh}
sudo chmod 777 /usr/local/bin/{cat_comments,ccat,netpid}{,.sh}
sudo chmod 777 /usr/local/bin/{timeout3,certbot-ocsp-fetcher}
