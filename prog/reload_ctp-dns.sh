#!/bin/bash
SCRIPT_DIR=`realpath .`
source $SCRIPT_DIR/.project_env.sh
CTP_SERVICE=ctp-dns.service
SERVICE_DIR=/etc/systemd/system/
SERVICE_FILE=$SERVICE_DIR/$CTP_SERVICE

sudo ln -s $PROG/$CTP_SERVICE $SERVICE_DIR/
#if [[ "$IS_MASTER" != 'true' ]]; then
#	sudo rm -rf $SERVICE_FILE
#	sudo cp -rf $CONFIG_DIR/systemd/system/ctp-dns.service /etc/systemd/system/ && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns.service
#
#	sudo cp -rf $CONFIG_DIR/systemd/system/ctp-dns.service $SERVICE_DIR && \
#	sudo systemctl daemon-reload && \
#	sudo systemctl restart $CTP_SERVICE
#	systemctl status $CTP_SERVICE | grep ''
#else

#        if ! [[ -L $SERVICE_FILE ]]; then
#                echo "File was not a system link creating proper file"
#                sudo rm -rf $SERVICE_FILE
#                [[ -f $HOME/$CTP_SERVICE ]] && ROOT_SERICE_FILE=$HOME/$CTP_SERVICE || ROOT_SERICE_FILE=$PROG/$CTP_SERVICE
#                sudo ln -s $ROOT_SERICE_FILE $SERVICE_FILE
#                sudo systemctl daemon-reload
#        fi
#
#fi
sudo systemctl daemon-reload
sudo systemctl reset-failed $CTP_SERVICE
sudo systemctl restart $CTP_SERVICE
sudo systemctl enable $CTP_SERVICE
