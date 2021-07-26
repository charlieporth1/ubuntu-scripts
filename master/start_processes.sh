#!/usr/bin/bash
systemctl daemon-reload
source /etc/profile.d/bash-exports-global.sh
ln -s $ROUTE/lists/ /var/cache/ctp-dns/lists
bash $PROG/ssl_stripper.sh

PROG=/home/charlieporth1_gmail_com/Programs

bash $PROG/update.unbound-config.sh

function capture_stderr {
  [ $# -lt 2 ] && return 2
  local stderr="$1"
  shift
  {
    printf -v "$stderr" '%s' "$({ "$@" 1>&3; } 2>&1)"
  } 3>&1
}


function CONFIG_TEST_ERR() {
	CMD="$@"
	capture_stderr $CMD test
	OK_STR="OK: configuration test is successful\|OK\|successful\|success"
	if [[ -z `echo $test | grep -io "$OK_STR"` ]]; then
		echo $test > /tmp/`echo $CMD | awk '{print $1}'`.test.err
	fi
}

touch $LOG/fail2ban.log
touch $LOG/auth.log
rm -rf  /var/cache/bind/cache_file

mkdir -p /var/cache/netdata

mkdir -p /var/log/unbound
touch /var/log/unbound.log
chown -R unbound:unbound /var/log/unbound*

mkdir -p /var/log/nginx/
touch /var/log/nginx/access.log
touch /var/log/nginx/error.log
chown www-data:www-data -R /var/log/nginx/

mkdir -p /var/cache/dnsmasq
chown pihole:pihole -R /var/cache/dnsmasq/

mkdir -p /var/cache/bind
touch /var/cache/bind/cache_file
chown bind:bind -R /var/cache/bind
#chown root:root -R /var/cache/bind
#chmod 775 -R /var/cache/bind

mkdir -p /var/spool/mqueue-client/
chown -R root:smmsp /var/spool/mqueue-client
chmod 770 /var/spool/mqueue-client


mkdir -p /var/cache/apt-show-versions/
mkdir -p /var/cache/apt/archives/
mkdir -p /var/cache/lighttpd

mkdir -p /var/cache/nginx/{doh_cache,doh_json_cache}
certbot-ocsp-fetcher --output-dir=/var/cache/nginx/
chown -R www-data:www-data /var/cache/nginx/
#touch /var/cache/nginx/doh_cache

mkdir -p /var/log/lighttpd
mkdir -p /var/log/letsencrypt
mkdir -p /var/log/pihole
mkdir -p /var/log/pihole_lists
mkdir -p /var/log/apt

bash $PROG/cert_manager.sh
bash $PROG/PERMA_CACHE.sh

systemctl stop openvpn@server.service
systemctl disable openvpn@server.service
systemctl mask  openvpn@server.service

systemctl stop dnsmasq
systemctl disable dnsmasq

systemctl stop named
systemctl disable named

systemctl stop tor
systemctl disable tor

#systemctl stop nginx 2> /tmp/nginx.err
#systemctl disable nginx 2> /tmp/nginx.err
#systemctl mask dnsmasq

#pihole-FTL 2>  /tmp/pihole-FTL.cli.err
#wg-quick up wg1

sleep 3s
pihole enable | grep -oi "[✗]"  > /tmp/pihole.err
sync
pihole disable && sync && pihole enable | grep -oi "[✗]" > /tmp/pihole.test.err
pihole status | grep -oi "[✗]\|NOT" > /tmp/pihole.status.error.err
pihole restartdns | grep -oi "[✗]\|NOT" > /tmp/pihole.restartdns.error.err
sudo fail2ban-server --test -c $F2B/fail2ban.conf

fail2ban-server --test -c $F2B/fail2ban.conf 2> /tmp/fail2ban-server.error.err
fail2ban-client --test -c $F2B/fail2ban.conf 2> /tmp/fail2ban-client.error.err
pihole-FTL dnsmasq-test 2> /tmp/pihole-FTL.dnsmasq.config.err
pihole-FTL test 2> /tmp/pihole-FTL.config.err

nginx -t  2> /tmp/nginx.config.err
unbound-checkconf 2> /tmp/unbound.config.err
dnsmasq --test /tmp/dnsmasq.config.err
lighttpd -tt -f /etc/lighttpd/lighttpd.conf > /tmp/lighttpd.config.err
#wg-quick up wg0
sqlite3 /etc/pihole/gravity.db "PRAGMA integrity_check" > /tmp/gravity.check.err

#systemctl restart wg-quick@wg1 2> /tmp/wireguard1.err


#named-checkconf 2> /tmp/named.configtest.err
#named-checkconf /etc/bind/named.conf.default-zones 2> /tmp/named.configtest.default.err
#named-checkconf /etc/bind/named.conf.options 2> /tmp/named.configtest.options.err
#systemctl restart named-resolvconf 2> /tmp/named-resolvconf.err
#named-checkconf /etc/bind/named.conf.local 2> /tmp/named.configtest.local.err
bash $PROG/serveronline.sh

(
	bash $PROG/systemctl_status.sh -a
	sleep 5s
	for errFile in `ls /tmp/*.err`
	do
		fileErrors=`cat $errFile`
		if [[ -n "$fileErrors" ]]; then
			echo "$fileErrors"
				sleep 2s
				bash $PROG/alert_user.sh "Error starting process..."  "Error file: (START ERROR) $errFile :: $fileErrors (END ERROR);; process is in file name $HOSTNAME $USER BOOT"
		else
			if [[ -f $errFile ]]; then
				rm -rf $errFile
			fi
		fi
	done
)&
