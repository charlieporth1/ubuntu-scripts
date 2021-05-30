#!/bin/bash
ARGS="$@"

INSTALL_DIR=/usr/local/bin
CTP_DNS_LOG_DIR=/var/log/ctp-dns

if ! [[ -f $INSTALL_DIR/h ]]; then
	curl -s https://github.com/paoloantinori/hhighlighter/blob/master/h.sh | sudo tee $INSTALL_DIR/h
	sudo chmod 777 $INSTALL_DIR/h
elif [[ -f $INSTALL_DIR/h.sh ]]; then
	source h.sh
elif [[ -f $INSTALL_DIR/h ]]; then
	chmod 777 $INSTALL_DIR/h
	source h
fi

helpString="""
   -h --help
   -qbl --query-blocklist-log
   -qal --query-allowlist-log
   -t --tail

"""

for i in "$@"; do
    case $i in
        --help | -h ) shift; echo "$helpString" ; exit 0 ;;
        -q | --query ) shift ; optNoLocal=1;;
        -qbl | qbl | --qbl | --query-blocklist-log | --query-blacklist-log ) shift ; grep --color=auto "matched blocklist" $CTP_DNS_LOG_DIR/*.log;;
        -qal | -qwl | qwl | qbl | --qwl | --qal | --query-allowlist-log | --query-whitelist-log ) shift ; grep --color=auto "matched allowlist" $CTP_DNS_LOG_DIR/*.log;;
        -l | -t | --l | --t | --tail | --log ) shift ; tail -f $CTP_DNS_LOG_DIR/*.log | h 'matched blocklist' 'matched allowlist' ;;
    esac
done
