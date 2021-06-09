#!/bin/bash

fail2ban-regex /var/log/ctp-dns/error.log /etc/fail2ban/filter.d/ctp-dns-1-block.conf | grep -E "${IP_REGEX}" | xargs  sudo fail2ban-client set ctp-dns-1-block banip ${PIHOLE_BAN_IPs[@]}
