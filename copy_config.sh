#!/bin/bash
SCRIPT_DIR=`realpath .`
bash $SCRIPT_DIR/links.sh
source $SCRIPT_DIR/.project_env.sh
source $SCRIPT_DIR/.install-args-proc.sh

sudo rm -rf  $INSTALL_CONFIG_DIR/unbound/unbound.conf.d/*

ROUTE=$PROG/route-dns
ALT_ROUTE=$PROG/alt-route-dns

CONFIG_ROUTE=$CONF_PROG_DIR/route-dns
CONFIG_ALT_ROUTE=$CONF_PROG_DIR/alt-route-dns

LIST_DIR=/var/{cache,tmp}/ctp-dns
mkdir -p $LIST_DIR

bash $PROG/doh_proxy_json.sh
DEFAULT_PROG=${PROG:-$CONF_PROG_DIR}
# CPs
sudo cp -rf $CONFIG_DIR/unbound/* $INSTALL_CONFIG_DIR/unbound/
sudo cp -rf $CONFIG_DIR/nginx/* $INSTALL_CONFIG_DIR/nginx/
sudo cp -rf $CONFIG_DIR/profile.d/* $INSTALL_CONFIG_DIR/profile.d/
sudo cp -rf $CONFIG_DIR/domains/ $INSTALL_CONFIG_DIR/
sudo cp -rf $CONFIG_DIR/dns-over-https/* $INSTALL_CONFIG_DIR/dns-over-https/
sudo cp -rf $CONFIG_DIR/* $INSTALL_CONFIG_DIR/
sudo cp -rf $CONFIG_DIR/www/* $WWW/
sudo cp -rf $BIN_DIR/* /usr/local/bin

# Sys LNs
sudo ln -s $CONF_PROG_DIR/ $PROG/
sudo ln -s $CONFIG_ROUTE $PROG
sudo ln -s $CONFIG_ALT_ROUTE $PROG/
sudo ln -s /etc/fail2ban/filter.d/ctp-custom-vars.conf   /etc/fail2ban/filter.d/common.local
sudo ln -s $SETUP_DIR/{copy_files,dns-route,doh_proxy_json}.sh $DEFAULT_PROG
sudo ln -s $CONF_PROG_DIR/{cat_comments,regexify,grepify,new_linify,csvify}.sh /usr/local/bin
sudo ln -s $CONF_PROG_DIR/cat_comments.sh /usr/local/bin/{cat_comments,ccat}
sudo ln -s $CONF_PROG_DIR/cat_comments.sh /usr/local/bin/ccat.sh
sudo ln -s $CONF_PROG_DIR/ctp-dns.service $DEFAULT_PROG
sudo ln -s $CONF_PROG_DIR/nginx-dns-rfc.service $DEFAULT_PROG
sudo ln -s $CONF_PROG_DIR/route-dns/ctp-dns.sh $ROUTE/
sudo ln -s $ROUTE/ctp-dns.sh /usr/local/bin/ctp-dns
sudo ln -s $ROUTE/ctp-dns.sh /usr/local/bin/
sudo ln -s $CONF_PROG_DIR/timeout3 /usr/local/bin
sudo ln -s $ROUTE/lists/ $LIST_DIR

# sudo bash $SETUP_DIR/master_config.sh
for i in $CONFIG_DIR/bash_rc/{.,}*
do
   if [ -r $i ]; then
	FILE_NAME=`realpath $i | rev | cut -d '/' -f 1 | rev`
	append_file=$ADMIN_HOME/$FILE_NAME

	if [[ -f $append_file ]]; then
		if [[ `isNotInstalled $append_file` ]]; then
			cat $i >> $append_file
		else
			sudo cp -rf $append_file $append_file.bk
			diff $append_file $i > $append_file.patch
			patch $append_file -i $append_file.patch -o $append_file.update
			mv $append_file.update $append_file
		fi
	else
		cat $i > $append_file
	fi
   fi
done
unset i

# Master
if [[ "$IS_MASTER" == 'true' ]]; then
	sudo ln -s $MASTER_DIR/ $DEFAULT_PROG/
	if [ -d $MASTER_DIR ]; then
	  for i in $MASTER_DIR/*.sh; do
	    if [ -r $i ]; then
	      ln -s $i $DEFAULT_PROG/
	    fi
	  done
	  unset i
	fi

else
# Slave
	sudo rm -rf /etc/fail2ban/jail.d/{pihole-dns,pihole-dns-1-block,pihole-lighttpd}.conf
	sudo rm -rf /etc/fail2ban/filter.d/{pihole-dns,pihole-dns-1-block}.conf
#	sudo rm -rf $SITES/dot
fi

if [[ -d $DEFAULT_PROG ]]; then
	for i in $CONF_PROG_DIR/*.{sh,service,bash,txt,list,regex}; do
  		if [ -r $i ]; then
       			ln -s $i $DEFAULT_PROG
    		fi
	done
	unset i
fi

sudo ln -s $CONF_PROG_DIR/ctp-dns.service /etc/systemd/system/
sudo ln -s $CONF_PROG_DIR/nginx-dns-rfc.service /etc/systemd/system/

# Chmod +x
sudo chmod 777 $ROUTE/ctp-dns.sh
sudo chmod 777 /usr/local/bin/ctp-dns{,.sh}
sudo chmod 777 /usr/local/bin/{ccat,cat_comments,regexify,grepify,new_linify,csvify}.sh
sudo chmod 777 /usr/local/bin/timeout3


bash $PROG/doh_proxy_json.sh
bash $PROG/bk_overwrite_files.sh

sudo cp -rf $CONFIG_DIR/dns-over-https/* $INSTALL_CONFIG_DIR/dns-over-https/
sudo cp -rf $ROUTE/{standard-group-resolvers,$HOSTNAME-resolvers,standard-resolvers,raw-resolvers}.toml $ALT_ROUTE/

sudo rm -rf /etc/unbound/unbound.conf.d/adblock.conf
sudo rm -rf $PROG/*.sh*.sh

echo "Done with coping config files"
