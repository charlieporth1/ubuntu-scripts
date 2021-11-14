#!/bin/bash
ARGS="$@"
if [[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(pl|pre(-)?load(ed)?)'` ]]; then
	echo "Preloading not reloading"
	exit 0
fi

if [[ -z `echo "$ARGS" | grep -Eio '(\-\-|\-)(nv|no-var(s)?)'` ]]; then
source $PROG/all-scripts-exports.sh
# FILE NAMES
export GROUP_FILE_NAME=$ROUTE/standard-group-resolvers
export STD_RESOLVER_FILE_NAME=$ROUTE/standard-resolvers

export RAW_RESOLVER_FILE_NAME=$ROUTE/raw-resolvers
export BACKUP_RESOVLERS_FILE_NAME=$ROUTE/ctp-dns-back-up-resolvers

export WELL_KN_FILE_NAME=$ROUTE/well-known-resolvers
export WELL_KN_RESOVLERS_RT_GROUPS_FILE_NAME=$WELL_KN_FILE_NAME-retry-groups
export WELL_KN_GROUP_FILE_NAME=$ROUTE/well-known-groups

# FILES
export GROUP_FILE=$GROUP_FILE_NAME.toml
export RAW_RESOLVER_FILE=$RAW_RESOLVER_FILE_NAME.toml
export RESOLVER_FILE=$STD_RESOLVER_FILE_NAME.toml
export BACKUP_RESOVLERS_FILE=$BACKUP_RESOVLERS_FILE_NAME.toml

export WELL_KN_FILE=$WELL_KN_FILE_NAME.toml
export WELL_KN_RAW_FILE=$WELL_KN_FILE_NAME-raw.toml

export WELL_KN_RESOVLERS_RT_GROUPS_FILE=$WELL_KN_RESOVLERS_RT_GROUPS_FILE_NAME.toml
export WELL_KN_RESOVLERS_RT_RAW_GROUPS_FILE=$WELL_KN_RESOVLERS_RT_GROUPS_FILE_NAME-raw.toml

export WELL_KN_GROUP_FILE=$WELL_KN_GROUP_FILE_NAME.toml
export WELL_KN_RAW_GROUP_FILE=$WELL_KN_GROUP_FILE_NAME-raw.toml

# ITEM NAMES SIMPLE / BASE
export LOCAL_RESOLVER_NAME='ctp-dns-local-master'

export trancate_name='truncate-retry'

export GROUP_TITLE="ctp-dns_group"
export WELL_KN_GROUP_TITLE="well-known_group"

export NGINX_RESOLVER='ctp-dns_nginx-back-up'

# ITEM NAMES COMPLEX / STRUCTOR
export TRUCATE_GROUP=$GROUP_TITLE-$trancate_name-raw
export TRUCATE_GROUP_E=$GROUP_TITLE-$trancate_name-encrypted

export WELL_KN_TRUCATE_GROUP=$WELL_KN_GROUP_TITLE-$trancate_name-raw
export WELL_KN_TRUCATE_GROUP_E=$WELL_KN_GROUP_TITLE-$trancate_name-encrypted

export NGINX_RESOLVER_GROUP=$NGINX_RESOLVER-group


# RESOLVERS LIST
if [[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(dwk|do-well-known(s)?)'` ]]; then
	echo "Using well knowns resolvers"
	# Well known resolvers
	export WELL_KNOWN_RESOLVERS_LIST=$(grep -E "^.resolvers\..*" $WELL_KN_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
	export WELL_KNOWN_RESOLVERS_RAW_LIST=$(grep -E "^.resolvers\..*" $WELL_KN_RAW_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')

	if [[ -f $WELL_KN_RESOVLERS_RT_GROUPS_FILE ]]; then
		export WELL_KNOWN_RT_RESOLVERS_LIST=$(grep -E "^.groups\..*$WELL_KN_TRUCATE_GROUP_E.*" $WELL_KN_RESOVLERS_RT_GROUPS_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
		export WELL_KNOWN_RT_RESOLVERS_RAW_LIST=$(grep -E "^.groups\..*$WELL_KN_TRUCATE_GROUP.*" $WELL_KN_RESOVLERS_RT_RAW_GROUPS_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
	fi
else
	echo "Using ctp-dns resolvers"
	# CTP-DNS resolvers
	export GCP_RESOLVERS_LIST=$(grep -E "^.resolvers\..*gcp.*" $RESOLVER_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
	export HOME_RESOLVERS_LIST=$(grep -E "^.resolvers\..*home.*" $RESOLVER_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
	export AWS_RESOLVERS_LIST=$(grep -E "^.resolvers\..*aws.*" $RESOLVER_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')

	export ALL_RESOLVERS_LIST=$(grep -E "^.resolvers\..*(gcp|home|aws).*" $RESOLVER_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
	export RAW_RESOLVERS_LIST=$(grep -E "^.resolvers\..*(gcp|home|aws).*" $RAW_RESOLVER_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
	export BACKUP_RESOLVERS_LIST=$(grep -E "^.resolvers\..*$NGINX_RESOLVER.*" $BACKUP_RESOVLERS_FILE | awk -F. '{print $2}' | awk -F] '{print $1}')
fi

# RESOLVERS
if [[ -n `echo "$ARGS" | grep -Eio '(\-\-|\-)(dwk|do-well-known(s)?)'` ]]; then
	echo "Using well knowns resolvers"
	# Well known resolvers
	export WELL_KNOWN_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$WELL_KNOWN_RESOLVERS_LIST" ) --quotes --space ))
	export WELL_KNOWN_RESOLVERS_RAW=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$WELL_KNOWN_RESOLVERS_RAW_LIST" ) --quotes --space ))

	export WELL_KNOWN_RT_GROUPS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$WELL_KNOWN_RT_RESOLVERS_LIST" ) --quotes --space ))
	export WELL_KNOWN_RT_GROUPS_RAW=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$WELL_KNOWN_RT_RESOLVERS_RAW_LIST" ) --quotes --space ))
else
	echo "Using ctp-dns resolvers"
	# CTP-DNS resolvers
	export GCP_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$GCP_RESOLVERS_LIST" ) --quotes --space ))
	export HOME_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$HOME_RESOLVERS_LIST" ) --quotes --space ))
	export AWS_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$AWS_RESOLVERS_LIST" ) --quotes --space ))

	export ALL_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$ALL_RESOLVERS_LIST" ) --quotes --space ))
	export RAW_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$RAW_RESOLVERS_LIST" ) --quotes --space ))
	export BACKUP_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(printf '%s\n' "$BACKUP_RESOLVERS_LIST" ) --quotes --space ))
fi

# MISC
export DEFAULT_DOMAIN=dns.ctptech.dev
export MASTER_DOMAIN=master.$DEFAULT_DOMAIN
export DOMAIN=$DEFAULT_DOMAIN

export IP_ADDRESSES=`bash $PROG/get_ext_ip.sh $MASTER_DOMAIN`

export timeout=12
else
	shopt -s expand_aliases
	echo "Using no-vars"
fi

function format_file() {
	local args=$@
	bash $ROUTE/route-format.sh $args
}
export format_file_export=$(declare -f format_file)

quic_str="(doq|quic)"
alias doq-n-doh-filter=" grep -E \"($quic_str|doh)\""
alias doq-filter="grep -v \"doh\" | grep -E \"$quic_str\""
alias doh-quic-filter="grep -E \"(doh-$quic_str|$quic_str-doh)\""
alias doh-filter="grep -vE \"$quic_str\" | grep \"doh\""

