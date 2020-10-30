#
# Script: /usr/local/bin/activate-sendmail.sh
#

#!/bin/bash
cd /etc/mail
make
#/usr/bin/newaliases
#systemctl restart sendmail.service
#systemctl restart spamassassin.service
sudo service sendmail restart
