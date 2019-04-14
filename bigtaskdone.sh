#!/bin/bash
. /usr/bin/cred.sh
sendemail -f $USER@otih-oith.us.to -t $phonee  -m "Your GCLOUD TASK IS DONE AND THE COMPUTER HAS SHUTOFF" -s smtp.gmail.com:587 -o tls=yes -xu $usr -xp  $passwd
sleep 10
sudo poweroff -f
