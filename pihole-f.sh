#!/bin/bash
echo "Regenerating & Running  $PROG/generate_vulnerability-blacklist.sh is bg once"
sudo bash $PROG/generate_vulnerability-blacklist.sh 2>&1 >> /dev/null &
pihole -w www.google.com > /dev/null
while true
do
	pihole -t
done
