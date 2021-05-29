
#!/bin/bash
export SCRIPT_DIR=`realpath .`
source $SCRIPT_DIR/.install-args-proc.sh 
source $SCRIPT_DIR/.project_env.sh

bash $SCRIPT_DIR/reload_ctp-dns.sh
sudo systemctl stop unbound-resolvconf.service
sudo systemctl disable unbound-resolvconf.service
sudo systemctl mask unbound-resolvconf.service 

#sudo systemctl restart netdata
#sudo systemctl enable netdata
sudo systemctl disable netdata
sudo systemctl mask netdata
if [[ -z $IS_MASTER ]] || [[ $IS_MASTER == 'false' ]] ; then
	sudo systemctl disable unbound
	sudo systemctl mask unbound
fi

declare -a SERVICES
SERVICES=(
	nginx
	doh-server
	fail2ban
)
for service in "${SERVICES[@]}"
do
	sudo systemctl restart $service
	sudo systemctl enable $service
done
if [[ "$IS_MASTER" == "true" ]]; then
	systemctl enable pihole-FTL
fi
