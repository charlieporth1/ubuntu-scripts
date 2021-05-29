#!/bin/bash
if ! [[ -f /etc/systemd/system/ctp-dns.service ]]; then
	sudo ln -s $PROG/ctp-dns.service /etc/systemd/system/
fi
sudo systemctl daemon-reload && sudo systemctl restart ctp-dns.service
sudo systemctl status ctp-dns.service
