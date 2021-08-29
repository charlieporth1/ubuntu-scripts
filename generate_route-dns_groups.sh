#!/bin/bash


export GCP_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*gcp.*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
export GCP_HOME_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*(gcp|home).*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
export GCP_AWS_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*(gcp|aws).*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
export GCP_HOME_AWS_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*(gcp|home|aws).*" $ROUTE/standard-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))
export RAW_RESOLVERS=$(bash $PROG/new_linify.sh $(bash $PROG/csvify.sh $(grep -E "^.resolvers\..*(gcp|home|aws).*" $ROUTE/raw-resolvers.toml | awk -F. '{print $2}' | awk -F] '{print $1}') --quotes --space))

export LOCAL_RESOLVER_NAME='ctp-dns-local-master'

export GROUP_FILE=$ROUTE/standard-group-resolvers.toml

export GROUP_TITLE="ctp-dns_group"
echo """
###################
###### FASTEST ####
###################
[groups.$GROUP_TITLE-fastest-gcp-external]
resolvers = [
	$GCP_RESOLVERS
]
type = \"fastest\"

[groups.$GROUP_TITLE-fastest-gcp_home-external]
resolvers = [
	$GCP_HOME_RESOLVERS
]
type = \"fastest\"

[groups.$GROUP_TITLE-fastest-masters]
resolvers = [
	$GCP_HOME_AWS_RESOLVERS
]
type = \"fastest\"

[groups.$GROUP_TITLE-fastest-raw]
resolvers = [
	$RAW_RESOLVERS
]
type = \"fastest\"


#####################
### FAIL BACK #######
#####################
[groups.$GROUP_TITLE-fail-back-masters]
resolvers = [
	$GCP_HOME_AWS_RESOLVERS
]
type = \"fail-back\"
timeout = 30
reset-after = 30
servfail-error = true

[groups.$GROUP_TITLE-fail-back-gcp]
resolvers = [
	$GCP_RESOLVERS
]
type = \"fail-back\"
timeout = 30
reset-after = 30
servfail-error = true

[groups.$GROUP_TITLE-fail-back-raw]
resolvers = [
	$RAW_RESOLVERS
]
type = \"fail-back\"
timeout = 8
reset-after = 8
servfail-error = true


#####################
### FAIL Rotate #####
#####################
[groups.$GROUP_TITLE-fail-rotate-masters]
resolvers = [
	$GCP_HOME_AWS_RESOLVERS
]
type = \"fail-rotate\"
timeout = 30
reset-after = 30
servfail-error = true

[groups.$GROUP_TITLE-fail-rotate-raw]
resolvers = [
	$RAW_RESOLVERS
]
type = \"fail-rotate\"
timeout = 8
reset-after = 8
servfail-error = true
""" | sudo tee $GROUP_FILE


perl -0777 -i -pe 's/^"ctp/\t"ctp/gm' $GROUP_FILE
