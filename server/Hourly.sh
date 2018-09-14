#purge
sudo bash /home/charlieporth/Programs/killMemoryHogs.sh
#Clear RAM
sudo echo 3 > /proc/sys/vm/drop_caches
sudo echo 2 > /proc/sys/vm/drop_caches
sudo echo 1 > /proc/sys/vm/drop_caches
sudo rm -rf /tmp/*
#Start Cockpit
sudo systemctl start cockpit.socket
#sudo bash /home/charlieporth/startup/youtrack-2018.1.41051/bin/youtrack.sh start
sudo bash /home/*/Programs/filesystemparallel.sh
sudo bash /home/*/filesystemparallel.sh
sudo bash /home/*/Programs/jaildefaultunban.sh 
