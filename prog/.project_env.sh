#!/bin/bash
git config --global credential.helper 'store --file ~/.git-credentials'
export SCRIPT_DIR=`realpath .`

echo """
----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :$SCRIPT_DIR:
________________________________________________________________________________________________________________
"""

[[ -n "$SUDO_USER" ]] && export USER="$SUDO_USER" || export USER="$USER"
export HOME="/home/$USER"
export PROG="$HOME/Programs"
export ROUTE="$PROG/route-dns"
round() {
    printf "%.${2:-0}f" "$1"
}
export CPU_CORE_COUNT=`cat /proc/stat | grep cpu | grep -E 'cpu[0-9]+' | wc -l`
export MEM_COUNT=$(round `grep MemTotal /proc/meminfo | awk '{print $2 / 1024}'` 0)


export INSTALL_CONFIG_DIR=/etc
export IP_REGEX="((([0-9]{1,3})((\.)?))"

export CONFIG_DIR=$SCRIPT_DIR/config
export CONF_PROG_DIR=$SCRIPT_DIR/prog
export SETUP_DIR=$SCRIPT_DIR/setup
export MASTER_DIR=$SCRIPT_DIR/master
export USR_DIR=$SCRIPT_DIR/user
export BIN_DIR=$USR_DIR/local/bin
export SBIN_DIR=$USR_DIR/local/sbin
export SHARE_DIR=$USR_DIR/share

export CONFIG_INSTALLED_STR='# CTP INSTALL -- DO NOT REMOVE THIS UNLESS YOU PLAN ON REMOVING INSTALL AND REINSTALLING'
DEFAUT_CONF_PROG_DIR=${CONF_PROG_DIR:-$PROG}
source $DEFAUT_CONF_PROG_DIR/all-scripts-exports.sh > /dev/null

#source $SCRIPT_DIR/bash_rc_sample
function load_env() {
	for env in $( grep -Ev ^# /etc/environment ); do export $(echo $env | grep -v '#' | sed -e 's/"//g') > /dev/null; done
	source /etc/environment
}
export -f load_env
load_env

function checkIsNotInstalled() {
 	local file="$1"
	if ! [[ -f $file ]]; then
		touch $file
	fi

	if [[ -z `grep -o "$CONFIG_INSTALLED_STR" $file` ]]; then
		echo "true"
	else
		echo "false"
	fi
}
function isNotInstalled() {
 	local file="$1"
	local result=`checkIsNotInstalled $file`
	if [[ "$result" == 'true' ]]; then
		(
			echo "$CONFIG_INSTALLED_STR" | sudo tee -a $file
		)>/dev/null
	fi
	echo "$result"
}
function check_admin() {
	set -e
	if [ "$(id -u)" -eq 0 ]
	then
    		if [ -n "$SUDO_USER" ]
    		then
			set +e
        		printf "OK, script run as root (with sudo) as a admin user\n"
    		else
        		printf "This script has to run as root (with sudo) not as root\n" >&2
        		exit 1
    		fi
	else
    		printf "This script has to run as root\n" >&2
    		exit 1
	fi
}
function is_user_sure() {
	set -e
	read -r -p "Are you sure you want to install this script? The user: $USER will be the default admin with the home dir of $HOME  [y/N]" response
	case "$response" in
    		[yY][eE][sS]|[yY])
        		echo "Ok...continuing"
			set +e
        		;;
    		*)
        		printf """
               			Try this
                		sudo -u ${USER} ./install.sh
                		Or...
                		sudo -u \${USER} ./install.sh
                		Ok exiting now
                		"""
			        exit 0
        		;;
		esac

}

export -f isNotInstalled
export -f checkIsNotInstalled
export -f is_user_sure
export -f check_admin

echo "DONE"
