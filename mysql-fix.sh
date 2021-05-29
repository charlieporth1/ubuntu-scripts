#bash 
ps -A|grep mysql
sudo pkill mysql
echo mysql killed
ps -A|grep mysqld
sudo pkill mysqld
echo mysqld killed 
echo restarting mysql
service mysql restart
echo done 
