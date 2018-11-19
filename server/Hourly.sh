#purge
#sudo bash /home//Programs/killMemoryHogs.sh
#Clear RAM
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo rm -rf /tmp/*
if [ -z  ifconfig | grep -A 1 "eth0" | grep -o '192.168.1.91' ]; then 
sudo ntpdate -u 192.168.1.91
else 
sudo ntpdate -u ntp.your.org
fi
#Start Cockpit
ifconfig eth0 up
ifup eth0 
sudo systemctl start cockpit.socket
#sudo bash /home/charlieporth/startup/youtrack-2018.1.41051/bin/youtrack.sh start
sudo bash /home/*/Programs/filesystemparallel.sh
sudo bash /home/*/filesystemparallel.sh
sudo bash /home/*/Programs/jaildefaultunban.sh 
