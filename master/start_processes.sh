#!/usr/bin/bash
systemctl daemon-reload
source /etc/profile.d/bash-exports-global.sh
PROG=/home/charlieporth1_gmail_com/Programs

bash $PROG/.secure-exe-files.sh &
bash $PROG/update.unbound-config.sh &
bash $PROG/create_logging.sh

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
	if [[ -z `echo $test | grep -o "$OK_STR"` ]]; then
		echo $test > /tmp/`echo $CMD | awk '{print $1}'`.test.err
	fi
}


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

bash $PROG/cert_manager.sh &
bash $PROG/PERMA_CACHE.sh &

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

ctp-dns.sh --generate-log
ctp-dns.sh --generate-cache
ctp-dns.sh --generate-config

sleep 3s
pihole enable | grep -oi "[✗]"  > /tmp/pihole.err
sync
pihole disable && sync && pihole enable | grep -oi "[✗]" > /tmp/pihole.test.err
pihole status | grep -oi "[✗]\|NOT" > /tmp/pihole.status.error.err
pihole restartdns | grep -oi "[✗]\|NOT" > /tmp/pihole.restartdns.error.err

pihole-FTL dnsmasq-test 2> /tmp/pihole-FTL.config.err

CONFIG_TEST_ERR nginx -t
CONFIG_TEST_ERR unbound-checkconf
CONFIG_TEST_ERR dnsmasq --test
CONFIG_TEST_ERR fail2ban-server -t
CONFIG_TEST_ERR lighttpd -tt -f /etc/lighttpd/lighttpd.conf
#wg-quick up wg0

systemctl restart cockpit.socket 2> /tmp/cockpit.err
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
