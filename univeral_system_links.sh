#!/bin/bash

DEFAULT_PROG=${PROG:=$CONF_PROG_DIR}

sudo ln -s /etc/fail2ban/filter.d/ctp-custom-vars.conf   /etc/fail2ban/filter.d/common.local

sudo ln -s $DEFAULT_PROG/{regexify,grepify,new_linify,csvify}.sh /usr/local/bin
sudo ln -s $DEFAULT_PROG/csvify.sh /usr/local/bin/csvify
sudo ln -s $DEFAULT_PROG/regexify.sh /usr/local/bin/regexify
sudo ln -s $DEFAULT_PROG/new_linify.sh /usr/local/bin/new_linify
sudo ln -s $DEFAULT_PROG/grepify.sh /usr/local/bin/grepify

sudo ln -s $DEFAULT_PROG/timeout3 /usr/local/bin

sudo ln -s $DEFAULT_PROG/cat_comments.sh /usr/local/bin/cat_comments.sh
sudo ln -s $DEFAULT_PROG/cat_comments.sh /usr/local/bin/cat_comments
sudo ln -s $DEFAULT_PROG/cat_comments.sh /usr/local/bin/ccat.sh
sudo ln -s $DEFAULT_PROG/cat_comments.sh /usr/local/bin/ccat


sudo ln -s $ROUTE/ctp-dns.sh /usr/local/bin/ctp-dns
sudo ln -s $ROUTE/ctp-dns.sh /usr/local/bin/


sudo chmod 777 /usr/local/bin/ctp-dns{,.sh}
sudo chmod 777 /usr/local/bin/regexify,grepify,new_linify,csvify}{,.sh}
sudo chmod 777 /usr/local/bin/{cat_comments,ccat}{,.sh}
sudo chmod 777 /usr/local/bin/timeout3
