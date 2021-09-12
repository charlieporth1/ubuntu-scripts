#!/bin/bahs
source $PROG/all-scripts-exports.sh
source $PROG/name-server-conf.sh
set +e
QUAD_LIST_GIST="https://gist.githubusercontent.com/roycewilliams/6cb91ed94b88730321ca3076006229f1/raw/678247521912792a32e0a65736f436fcdc868804/same-quad-list.txt"
QUAD_LIST_GIST_OUT_FILE=/tmp/quad_list.txt

curl -sSL $QUAD_LIST_GIST | grepip -o4 | ip-sort | sudo tee $QUAD_LIST_GIST_OUT_FILE

mapfile -t IP_ADDRESSES < $QUAD_LIST_GIST_OUT_FILE
echo ""  | sudo tee $QUAD_LIST_DNS_SERVERS_OUT_FILE

for dns_ip in "${IP_ADDRESSES[@]}"
do
        query_time=`dig @$dns_ip +timeout=$TIMEOUT +dnssec +retry=$TRIES +tries=$TRIES | query_regex`
        echo "Query time for $dns_ip is: $query_time"
        query_time_unit=`echo "$query_time" | grep -oE "$SECONDS_UNIT_REGEX"`
        query_time_seconds=`echo "$query_time" | grep -oE "$NUMBER_AND_DECSAML_REGEX"`
        converted_query_time=`convert_time_seconds "$query_time_seconds" "$query_time_unit"`
        converted_query_time=${converted_query_time:-$(( $MIN_QUERY_TIME_AMOUNT + 10 ))}
        if [[ $converted_query_time -le $MIN_QUERY_TIME_AMOUNT ]]; then
                echo "$dns_ip"  | sudo tee -a $QUAD_LIST_DNS_SERVERS_OUT_FILE
        fi
done

