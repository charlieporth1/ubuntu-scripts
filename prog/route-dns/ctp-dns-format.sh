#!/bin/bash
source ctp-dns.sh --sourced
source $PROG/generate_ctp-dns-envs.sh --no-vars
shopt -s extglob
shopt -s nullglob
JOBS=1
PROC=4
R_DIR=$ROUTE
LOCAL_AD_RE='local-address = "(192\.168\.99\.9|10\.128\.0\.9)"'
if [[ `config_test $R_DIR` == 'false' ]] && [[ -d $R_DIR ]]; then
#	ls $R_DIR/*.toml | parallel -j $JOBS -P $PROC sudo bash -c "function $format_file_export; format_file {}"
	parallel -j $JOBS -P $PROC sudo bash $ROUTE/route-format.sh  ::: $R_DIR/*.toml
fi
if [[ "$HOSTNAME" != 'ctp-vpn' ]] && [[ `grep -oE "$LOCAL_AD_RE" $R_DIR/*.toml` ]] && [[ `config_test $R_DIR` == 'false' ]] && [[ -d $R_DIR ]]; then
	parallel -j $JOBS -P $PROC sudo bash $ROUTE/route-format.sh  ::: $R_DIR/*.toml
fi

R_DIR=$FAIL_ROUTE
if [[ `config_test $R_DIR` == 'false' ]] && [[ -d $R_DIR ]]; then
	parallel -j $JOBS -P $PROC sudo bash $ROUTE/route-format.sh  ::: $R_DIR/*.toml
fi

R_DIR=$ALT_ROUTE
if [[ `config_test $R_DIR` == 'false' ]] && [[ -d $R_DIR ]]; then
	parallel -j $JOBS -P $PROC sudo bash $ROUTE/route-format.sh  ::: $R_DIR/*.toml
fi

if [[ $IS_MASTER == true ]] || [[ "$HOSTNAME" == 'ctp-vpn' ]]; then

	R_DIR=$PIHOLE_MIDDLEWARE
	if [[ `config_test $R_DIR` == 'false' ]] && [[ -d $R_DIR ]]; then
		parallel -j $JOBS -P $PROC sudo bash $ROUTE/route-format.sh  ::: $R_DIR/*.toml
	fi
fi

if [[ "$HOSTNAME" == 'ctp-vpn' ]]; then
	R_DIR=$YT_ROUTE
	if [[ `config_test $R_DIR` == 'false' ]] && [[ -d $R_DIR ]]; then
		parallel -j $JOBS -P $PROC sudo bash $ROUTE/route-format.sh  ::: $R_DIR/*.toml
	fi
fi
exit 0
