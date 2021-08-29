#!/bin/bash

declare -a master_services
pihole_services=(
	"lighttpd-auth"
	"pihole-dns-1-block"
	"pihole-dns"
)

declare -a JAILs
JAILs=(
        $( [[ "$IS_MASTER" == true ]] && echo "${pihole_services[@]}" )
	"sshd"
	"selinux-ssh"
	"dropbear"
	"pam-generic"
	"nginx-botsearch"
	"nginx-limit-req"
	"nginx-http-auth"
	"ctp-dns-1-block"
)


for jail in "${JAILs[@]}"
do
        echo "Enabling, restarting and umasking service $jail"
	sudo fail2ban-client add $jail
	sudo fail2ban-client start $jail
done
