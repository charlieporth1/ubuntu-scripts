#!/bin/bash
ARGS="$@"
LOG_FILE=error.log
INSTALL_DIR=/usr/local/bin
CTP_DNS_LOG_DIR=/var/log/ctp-dns

if ! [[ -f $INSTALL_DIR/h ]]; then
	curl -s https://raw.githubusercontent.com/paoloantinori/hhighlighter/master/h.sh | sudo tee $INSTALL_DIR/h
	sudo chmod 777 $INSTALL_DIR/h
	sudo chown bin:bin $INSTALL_DIR/h
	sudo apt install -y ack > /dev/null
	source h
	echo "Finished loading h"
elif [[ -f $INSTALL_DIR/h.sh ]]; then
	source h.sh
elif [[ -f $INSTALL_DIR/h ]]; then
	source h
fi

helpString="""
   -h --help
   -qbl --query-blocklist-log
   -qal --query-allowlist-log
   -t --tail
   -q=* --query=*

"""

for i in "$@"; do
    case $i in
        --help | -h | --h ) shift; echo "$helpString" ; exit 0 ;;
        -qbl | qbl | --qbl | --query-blocklist-log | --query-blacklist-log ) shift ; grep --color=auto "matched blocklist" $CTP_DNS_LOG_DIR/$LOG_FILE;;
        -qal | -qwl | qwl | qbl | --qwl | --qal | --query-allowlist-log | --query-whitelist-log ) shift ; grep --color=auto "matched allowlist" $CTP_DNS_LOG_DIR/$LOG_FILE;;
        -l | -t | --l | --t | --tail | --log ) shift ; tail -f $CTP_DNS_LOG_DIR/$LOG_FILE | h 'matched blocklist' 'matched allowlist' 'ctp-dns-time-router-yt-ttl-gcp' 'ctp-dns-time-router-yt-gcp';;
        -q=* | --query=* ) shift ; grep --color=auto "$( echo ${i} | awk -F= '{print $2 }') " $CTP_DNS_LOG_DIR/$LOG_FILE;;
        * ) shift; echo "$helpString" ; exit 0 ;;
    esac
done
