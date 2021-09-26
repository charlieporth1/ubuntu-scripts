#!/bi/bash
source $PROG/all-scripts-exports.sh
source $PROG/name-server-conf.sh

OUT_FILE=$DNSMASQ/10-servers-generated.conf

MIN_QUERY_TIME_AMOUNT=`convert_time_seconds 20 m`
IP_ADDRESSES=`cat $DNS_LIST_FILE | grepip -o4 | ip-sort | grep -v "${PIHOLE_ACTIVE_DNS_GREPIFY}"`

echo """# Generated by: $scriptName
# Generated at: `date`
# Max time for query: $MIN_QUERY_TIME_AMOUNT usec

""" | sudo tee $OUT_FILE

qname='.'
qtype='NS'
IFS=$'\n'

for dns_ip in $IP_ADDRESSES
do
	query_time=`dig @$dns_ip +timeout=$TIMEOUT +dnssec +retry=$TRIES +tries=$TRIES $qname -t $qtype | query_regex`
	echo "Query time for $dns_ip is: $query_time"
	query_time_unit=`echo "$query_time" | grep -oE "$SECONDS_UNIT_REGEX"`
	query_time_seconds=`echo "$query_time" | grep -oE "$NUMBER_AND_DECSAML_REGEX"`
	converted_query_time=`convert_time_seconds "$query_time_seconds" "$query_time_unit"`
	converted_query_time=${converted_query_time:-$(( $MIN_QUERY_TIME_AMOUNT + 10 ))}
	if [[ $converted_query_time -le $MIN_QUERY_TIME_AMOUNT ]]; then
		echo "# DNS $dns_ip, $converted_query_time usec, Query Time $query_time" | sudo tee -a $OUT_FILE
		echo "$dns_ip" | parallel --lb echo 'server={}' | sudo tee -a $OUT_FILE
		echo "" | sudo tee -a $OUT_FILE
	fi
done

#if [[ -z `cat $OUT_FILE` ]]; then
#	grep -oE "$IP_REGEX" $OG_FILE | ip-sort | grep -v "${PIHOLE_ACTIVE_DNS_GREPIFY}" | parallel --lb echo 'server={}' | sudo tee $OUT_FILE
#
#else
#	grep -oE "$IP_REGEX" $OG_FILE | ip-sort | grep -v "${PIHOLE_ACTIVE_DNS_GREPIFY}" | parallel --lb echo 'server={}' | sudo tee -a $OUT_FILE
#	grep -oE "$IP_REGEX" $OUT_FILE | ip-sort | grep -v "${PIHOLE_ACTIVE_DNS_GREPIFY}" | parallel --lb echo 'server={}' | sudo tee $OUT_FILE.tmp
#	mv $OUT_FILE.tmp $OUT_FILE
#
#fi
#sleep 2s
#grep -vE "server=$IP_REGEX$" $OG_FILE | sudo tee $OG_FILE.tmp
#mv  $OG_FILE.tmp $OG_FILE
