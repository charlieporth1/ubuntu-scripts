#!/bin/bash

export SCRIPT_NAME=`basename $0`
[[ "$SCRIPT_DIR" == '.' ]] && export SCRIPT_DIR=$PWD
[[ -n `which realpath` ]] && export SCRIPT_DIR=`realpath .`

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

export INSTALL_CONFIG_DIR=/etc
export IP_REGEX="((([0-9]{1,3})((\.)?))"

export CONFIG_DIR=$SCRIPT_DIR/config
export CONF_PROG_DIR=$SCRIPT_DIR/prog
export SETUP_DIR=$SCRIPT_DIR/setup
export MASTER_DIR=$SCRIPT_DIR/master

export CONFIG_INSTALLED_STR='# CTP INSTALL -- DO NOT REMOVE THIS UNLESS YOU PLAN ON REMOVING INSTALL AND REINSTALLING'

#source $SCRIPT_DIR/bash_rc_sample
function load_env() {
	for env in $( cat /etc/environment ); do export $(echo $env | grep -v '#' | sed -e 's/"//g') > /dev/null; done
	source /etc/environment
}
export -f load_env
load_env

function isNotInstalled() {
 	local file="$1"
	if ! [[ -f $file ]]; then
		touch $file
	fi
	if [[ -z `grep -o "$CONFIG_INSTALLED_STR" $file` ]]; then
		echo true
		(
			echo "$CONFIG_INSTALLED_STR" | sudo tee -a $file
		)>/dev/null
	else
		echo false
	fi

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
export -f is_user_sure
export -f check_admin
echo "DONE"
