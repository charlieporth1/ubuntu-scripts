#!/bin/bash
if [ "$(ls -s /var/log | grep syslog | awk '{print $1}')" > 69084 ];then  
echo "bigger than recomanded"
sudo rm -rf  /var/log/syslog 
sudo touch  /var/log/syslog 
else 
echo "not large enough"
fi
echo "done"
