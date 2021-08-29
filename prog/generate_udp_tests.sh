#!/bin/bash
DOT_FILE=$PROG/test_dot.sh
DTLS_FILE=$PROG/test_dtls.sh
cp -rf $DOT_FILE $DTLS_FILE
DOT_ARGS=`grep -E ^DOT_ARGS  $DTLS_FILE | cut -d '"' -f 2-2`

sed -i "s/$DOT_ARGS/$DOT_ARGS +notcp/g" $DTLS_FILE
sed -i "s/DOT/DTLS/gm" $DTLS_FILE
sed -i "s/DoT/DTLS/gm" $DTLS_FILE
sed -i "s/dot/DTLS/gm" $DTLS_FILE
sed -i "s/Dot/DTLS/gm" $DTLS_FILE
