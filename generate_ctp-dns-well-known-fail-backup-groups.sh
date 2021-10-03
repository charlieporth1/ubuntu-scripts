#!/bin/bash
source $PROG/generate_ctp-dns-envs.sh

OUT_FILE=$WELL_KN_GROUP_FILE
OUT_FILE_R=$WELL_KN_RAW_GROUP_FILE

timeout=16

echo """# Generated by: $scriptName
# Generated at: `date`


""" | sudo tee $OUT_FILE


WELL_KNOWN_RESOLVERS_QUIC_LIST=$(printf '%s\n' "$WELL_KNOWN_RESOLVERS_LIST" |  doq-filter)
WELL_KNOWN_RESOLVERS_QUIC_DOH_LIST=$(printf '%s\n' "$WELL_KNOWN_RESOLVERS_LIST" | doh-quic-filter)
WELL_KNOWN_RESOLVERS_DOH_LIST=$(printf '%s\n' "$WELL_KNOWN_RESOLVERS_LIST" | doh-filter )

WELL_KNOWN_RESOLVERS_QUIC=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$WELL_KNOWN_RESOLVERS_QUIC_LIST" ) --quotes --space))
WELL_KNOWN_RESOLVERS_QUIC_DOH=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$WELL_KNOWN_RESOLVERS_QUIC_DOH_LIST" ) --quotes --space))
WELL_KNOWN_RESOLVERS_DOH=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$WELL_KNOWN_RESOLVERS_DOH_LIST" ) --quotes --space))

echo """
# FALLBACK
[groups.ctp-dns-failover-backup]
resolvers = [
	$(printf '%s\n' "$WELL_KNOWN_RESOLVERS_QUIC,
	$WELL_KNOWN_RESOLVERS_QUIC_DOH,
	$WELL_KNOWN_RT_GROUPS,
	$WELL_KNOWN_RESOLVERS_DOH," | sort -u )
]
type = \"fail-back\"
reset-after = $timeout
servfail-error = true
""" | sudo tee -a $OUT_FILE

echo """
# FASTEST
[groups.well-known_fastest]
resolvers = [
	$WELL_KNOWN_RESOLVERS
]
type = \"fastest\"
""" | sudo tee -a $OUT_FILE

echo """# Generated by: $scriptName
# Generated at: `date`

"""| sudo tee $OUT_FILE_R

echo """
# FALLBACK
[groups.well-known_fail-back-raw]
resolvers = [
	$WELL_KNOWN_RT_GROUPS_RAW,
]
type = \"fail-back\"
reset-after = $timeout
servfail-error = true
""" | sudo tee -a $OUT_FILE_R


echo """
# FASTEST
[groups.well-known_fastest-raw]
resolvers = [
	$WELL_KNOWN_RESOLVERS_RAW,
]
type = \"fastest\"
""" | sudo tee -a $OUT_FILE_R


format_file $OUT_FILE
format_file $OUT_FILE_R
