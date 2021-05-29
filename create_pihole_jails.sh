#!/bin/bash
sudo fail2ban-client add pihole-dns
sudo fail2ban-client add pihole-dns-1-block

sudo fail2ban-client start pihole-dns
sudo fail2ban-client start pihole-dns-1-block
