#!/bin/bash
if [ "$(ls -s /var/log | grep syslog | awk '{print $1}')" > 69084 ];then  
	echo "bigger than recomanded"
	sudo rm -rf  /var/log/syslog 
	sudo touch  /var/log/syslog 
else 
	echo "not large enough"
fi
echo "done"
if [ "$(ls -s /var/log | grep wtmp | awk '{print $1}')" > 69084 ];then  
	echo "bigger than recomanded"
	sudo rm -rf  /var/log/wtmp
	sudo touch  /var/log/wtmp 
else 
	echo "not large enough"
fi
echo "done"
if [ "$(ls -s /var/log | grep kern.log | awk '{print $1}')" > 69084 ];then  
	echo "bigger than recomanded"
	sudo rm -rf  /var/log/kern.log
	sudo touch  /var/log/kern.log
else 
	echo "not large enough"
fi
echo "done"
if [ "$(ls -s /var/log | grep dpkg.log | awk '{print $1}')" > 69084 ];then  
	echo "bigger than recomanded"
	sudo rm -rf  /var/log/dpkg.log
	sudo touch  /var/log/dpkg.log
else 
	echo "not large enough"
fi
echo "done"
if [ "$(ls -s /var/log/clamav/ | grep freshclam.log | awk '{print $1}')" > 69084 ];then  
	echo "bigger than recomanded"
	sudo rm -rf  /var/log/dpkg.log
	sudo touch  /var/log/dpkg.log
else 
	echo "not large enough"
fi
if [ "$(ls -s /var/log | grep dpkg.log | awk '{print $1}')" > 69084 ];then  
	echo "bigger than recomanded"
	sudo rm -rf  /var/log/dpkg.log
	sudo touch  /var/log/dpkg.log
else 
	echo "not large enough"
fi
if [ "$(ls -s /var/log | grep dpkg.log | awk '{print $1}')" > 69084 ];then  
	echo "bigger than recomanded"
	sudo rm -rf  /var/log/dpkg.log
	sudo touch  /var/log/dpkg.log
else 
	echo "not large enough"
fi
echo "done"
exit 0
