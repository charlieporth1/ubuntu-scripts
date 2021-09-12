#!/bin/bash


export GCP_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*gcp.*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
export HOME_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*home.*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
export AWS_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*aws.*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
export ALL_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*(gcp|home|aws).*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
export RAW_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*(gcp|home|aws).*" $ROUTE/raw-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))


export LOCAL_RESOLVER_NAME='ctp-dns-local-master'
export GROUP_FILE=$ROUTE/standard-group-resolvers.toml

export GROUP_TITLE="ctp-dns_group"
export TRUCATE_GROUP=$GROUP_TITLE-truncate-retry-raw
export TRUCATE_GROUP_E=$GROUP_TITLE-truncate-retry-encrypted

echo """
##########################
###### truncate-retry ####
##########################
# Try UDP first, if truncated use the alernative (TCP)
# ecrypted
[groups.$TRUCATE_GROUP_E-gcp-ip-1]
type = \"truncate-retry\"
resolvers = [ \"ctp-dns_gcp-dtls-ip-1\" ]
retry-resolver = \"ctp-dns_gcp-dot-ip-1\"

[groups.$TRUCATE_GROUP_E-gcp-ip-2]
type = \"truncate-retry\"
resolvers = [ \"ctp-dns_gcp-dtls-ip-2\" ]
retry-resolver = \"ctp-dns_gcp-dot-ip-2\"

[groups.$TRUCATE_GROUP_E-home]
type = \"truncate-retry\"
resolvers = [ \"ctp-dns_home-dtls\" ]
retry-resolver = \"ctp-dns_home-dot\"

[groups.$TRUCATE_GROUP_E-aws]
type = \"truncate-retry\"
resolvers = [ \"ctp-dns_aws-dtls\" ]
retry-resolver = \"ctp-dns_aws-dot\"

# RAW
[groups.$TRUCATE_GROUP-gcp-ip-1]
type = \"truncate-retry\"
resolvers = [ \"ctp-dns-ip-gcp-1-udp\" ]
retry-resolver = \"ctp-dns-ip-gcp-1-tcp\"

[groups.$TRUCATE_GROUP-gcp-ip-2]
type = \"truncate-retry\"
resolvers = [ \"ctp-dns-ip-gcp-2-udp\" ]
retry-resolver = \"ctp-dns-ip-gcp-2-tcp\"

[groups.$TRUCATE_GROUP-home]
type = \"truncate-retry\"
resolvers = [ \"ctp-dns-home-udp\" ]
retry-resolver = \"ctp-dns-home-tcp\"

[groups.$TRUCATE_GROUP-aws]
type = \"truncate-retry\"
resolvers = [ \"ctp-dns-aws-udp\" ]
retry-resolver = \"ctp-dns-aws-tcp\"



###################
###### FASTEST ####
###################
[groups.$GROUP_TITLE-fastest-masters]
resolvers = [
	\"$TRUCATE_GROUP_E-gcp-ip-1\",
	\"$TRUCATE_GROUP_E-gcp-ip-2\",
	\"$TRUCATE_GROUP_E-home\",
	\"$TRUCATE_GROUP_E-aws\",
	$( printf '%s\n' $ALL_RESOLVERS | grep 'quic\|doh' ),
]
type = \"fastest\"

[groups.$GROUP_TITLE-fastest-gcp-external]
resolvers = [
	\"$TRUCATE_GROUP_E-gcp-ip-1\",
	\"$TRUCATE_GROUP_E-gcp-ip-2\",
	$( printf '%s\n' $GCP_RESOLVERS | grep 'quic\|doh' ),
]
type = \"fastest\"

[groups.$GROUP_TITLE-fastest-home-external]
resolvers = [
	\"$TRUCATE_GROUP_E-home\",
	$( printf '%s\n' $HOME_RESOLVERS | grep 'quic\|doh' ),
]
type = \"fastest\"

[groups.$GROUP_TITLE-fastest-aws-external]
resolvers = [
	\"$TRUCATE_GROUP_E-aws\",
	$( printf '%s\n' $AWS_RESOLVERS | grep 'quic\|doh' ),
]
type = \"fastest\"

[groups.$GROUP_TITLE-fastest-raw]
resolvers = [
	\"$TRUCATE_GROUP-gcp-ip-1\",
	\"$TRUCATE_GROUP-gcp-ip-2\",
	\"$TRUCATE_GROUP-home\",
	\"$TRUCATE_GROUP-aws\",
	$RAW_RESOLVERS
]
type = \"fastest\"


#####################
### FAIL BACK #######
#####################
[groups.$GROUP_TITLE-fail-back-masters]
resolvers = [
	\"$TRUCATE_GROUP_E-gcp-ip-1\",
	\"$TRUCATE_GROUP_E-gcp-ip-2\",
	\"$TRUCATE_GROUP_E-home\",
	\"$TRUCATE_GROUP_E-aws\",
	$( printf '%s\n' $ALL_RESOLVERS | grep 'quic\|doh' ),
	\"$TRUCATE_GROUP-gcp-ip-1\",
	\"$TRUCATE_GROUP-gcp-ip-2\",
	\"$TRUCATE_GROUP-home\",
	\"$TRUCATE_GROUP-aws\",
]
type = \"fail-back\"
reset-after = 16
servfail-error = true

[groups.$GROUP_TITLE-fail-back-gcp]
resolvers = [
	\"$TRUCATE_GROUP_E-gcp-ip-1\",
	\"$TRUCATE_GROUP_E-gcp-ip-2\",
	$( printf '%s\n' $GCP_RESOLVERS | grep 'quic\|doh' ),
	\"$TRUCATE_GROUP-gcp-ip-1\",
	\"$TRUCATE_GROUP-gcp-ip-2\",
]
type = \"fail-back\"
reset-after = 16
servfail-error = true

[groups.$GROUP_TITLE-fail-back-home]
resolvers = [
	\"$TRUCATE_GROUP_E-home\",
	$( printf '%s\n' $HOME_RESOLVERS | grep 'quic\|doh' ),
	\"$TRUCATE_GROUP-home\",
]
type = \"fail-back\"
reset-after = 16
servfail-error = true

[groups.$GROUP_TITLE-fail-back-aws]
resolvers = [
	\"$TRUCATE_GROUP_E-aws\",
	$( printf '%s\n' $AWS_RESOLVERS | grep 'quic\|doh' ),
	\"$TRUCATE_GROUP-aws\",
]
type = \"fail-back\"
reset-after = 16
servfail-error = true

[groups.$GROUP_TITLE-fail-back-raw]
resolvers = [
	\"$TRUCATE_GROUP-gcp-ip-1\",
	\"$TRUCATE_GROUP-gcp-ip-2\",
	\"$TRUCATE_GROUP-home\",
	\"$TRUCATE_GROUP-aws\",
	$RAW_RESOLVERS
]
type = \"fail-back\"
reset-after = 4
servfail-error = true


#####################
### FAIL ROTATE #####
#####################

[groups.$GROUP_TITLE-fail-rotate-masters]
resolvers = [
	\"$TRUCATE_GROUP_E-gcp-ip-1\",
	\"$TRUCATE_GROUP_E-gcp-ip-2\",
	\"$TRUCATE_GROUP_E-home\",
	\"$TRUCATE_GROUP_E-aws\",
	$( printf '%s\n' $ALL_RESOLVERS | grep 'quic\|doh' ),
	\"$TRUCATE_GROUP-gcp-ip-1\",
	\"$TRUCATE_GROUP-gcp-ip-2\",
	\"$TRUCATE_GROUP-home\",
	\"$TRUCATE_GROUP-aws\",
]
type = \"fail-rotate\"
servfail-error = true

[groups.$GROUP_TITLE-fail-rotate-gcp]
resolvers = [
	\"$TRUCATE_GROUP_E-gcp-ip-1\",
	\"$TRUCATE_GROUP_E-gcp-ip-2\",
	$( printf '%s\n' $GCP_RESOLVERS | grep 'quic\|doh' ),
	\"$TRUCATE_GROUP-gcp-ip-1\",
	\"$TRUCATE_GROUP-gcp-ip-2\",
]
type = \"fail-rotate\"
servfail-error = true

[groups.$GROUP_TITLE-fail-rotate-home]
resolvers = [
	\"$TRUCATE_GROUP_E-home\",
	$( printf '%s\n' $HOME_RESOLVERS | grep 'quic\|doh' ),
	\"$TRUCATE_GROUP-home\",
]
type = \"fail-rotate\"
servfail-error = true


[groups.$GROUP_TITLE-fail-rotate-aws]
resolvers = [
	\"$TRUCATE_GROUP_E-aws\",
	$( printf '%s\n' $AWS_RESOLVERS | grep 'quic\|doh' ),
	\"$TRUCATE_GROUP-aws\",
]
type = \"fail-rotate\"
servfail-error = true

[groups.$GROUP_TITLE-fail-rotate-raw]
resolvers = [
	\"$TRUCATE_GROUP-gcp-ip-1\",
	\"$TRUCATE_GROUP-gcp-ip-2\",
	\"$TRUCATE_GROUP-home\",
	\"$TRUCATE_GROUP-aws\",
	$RAW_RESOLVERS
]
type = \"fail-rotate\"
servfail-error = true
""" | sudo tee $GROUP_FILE


perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $GROUP_FILE
