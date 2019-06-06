#!/bin/bash
echo '\e[0;34m' > /etc/issues
figlet $HOSTNAME >> /etc/issues
echo '\e[1;36m' >> /etc/issues
echo "$(uname -s) $(uname -p)" >> /etc/issues
echo '\e[0;31m' >> /etc/issues
echo "EXT IP  $(curl -s ipinfo.io/ip)" >> /etc/issues
echo '\e[1;37m' >> /etc/issues
echo  "Charles Timothy Porth's Website OTIH-OITH http://otih-oith.us.to" >> /etc/issues
echo '\e[1;32m' >> /etc/issues
echo -e "********************************************************************" >> /etc/issue.net && sleep 1
echo -e "*                                                                  *" >> /etc/issue.net && sleep 1
echo -e "* This system is for the use of authorized users only.  Usage of   *" >> /etc/issue.net && sleep 1
echo -e "* this system may be monitored and recorded by system personnel.   *" >> /etc/issue.net && sleep 1
echo -e "*                                                                  *" >> /etc/issue.net && sleep 1
echo -e "* Anyone using this system expressly consents to such monitoring   *" >> /etc/issue.net && sleep 1
echo -e "* and is advised that if such monitoring reveals possible          *" >> /etc/issue.net && sleep 1
echo -e "* evidence of criminal activity, system personnel may provide the  *" >> /etc/issue.net && sleep 1  
echo -e "* evidence from such monitoring to law enforcement officials.      *" >> /etc/issue.net && sleep 1
echo -e "*                                                                  *" >> /etc/issue.net && sleep 1
echo -e "********************************************************************" >> /etc/issue.net && sleep 1
echo '\e[0m' >> /etc/issues
