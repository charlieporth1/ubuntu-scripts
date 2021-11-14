#!/bin/bash
DOT_FILE=$PROG/test_dot.sh
DNS_FILE=$PROG/test_dns.sh

DNS_UDP_FILE=$PROG/test_dns_udp.sh
DTLS_FILE=$PROG/test_dtls.sh

cp -rf $DOT_FILE $DTLS_FILE
DOT_ARGS=`grep -E '^DOT_ARGS' $DTLS_FILE | cut -d '"' -f 2-2`

sed -i "s/$DOT_ARGS/$DOT_ARGS +notcp/g" $DTLS_FILE
sed -i "s/+tcp//g" $DTLS_FILE
sed -i "s/DOT/DTLS/gm" $DTLS_FILE
sed -i "s/DoT/DTLS/gm" $DTLS_FILE
sed -i "s/dot/DTLS/gm" $DTLS_FILE
sed -i "s/Dot/DTLS/gm" $DTLS_FILE


cp -rf $DNS_FILE $DNS_UDP_FILE
DNS_ARGS=`grep -E '^DNS_ARGS' $DNS_FILE | cut -d '"' -f 2-2`
sed -i "s/$DNS_ARGS/$DNS_ARGS +notcp/g" $DNS_UDP_FILE
sed -i "s/+tcp//g" $DNS_UDP_FILE
sed -i "s/DNS/DNS UDP/gm" $DNS_UDP_FILE
sed -i "s/Dns/DNS UDP/gm" $DNS_UDP_FILE
sed -i "s/DnS/DNS UDP/gm" $DNS_UDP_FILE
