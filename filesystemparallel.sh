#sudo sshfs -o idmap=user,nonempty,allow_other ubuntu@192.168.1.250:/home/ubuntu/sshfs/tegra-ubuntu 
#/home/charlieporth/sshfs/tegra-ubuntu sudo sshfs -o idmap=user,nonempty,allow_other ubuntu@192.168.1.250:/mnt/HDD 
#/home/charlieporth/sshfs/tegra-ubuntu sudo sshfs -o idmap=user,nonempty,allow_other ubuntu@192.168.1.250:/ 
#/home/charlieporth/sshfs/tegra-ubuntu sudo sshfs -o Ciphers=arcfour -o Compression=no -o 
#idmap=user,nonempty,allow_other,direct_io,kernel_cache,auto_cache,IdentityFile=/home/charlieporth/.ssh/id_rsa 
#ubuntu@192.168.1.250:/mnt/HDD /home/charlieporth/sshfs/tegra-ubuntu allow_other,allow_root

sudo mkdir /home/*/sshfs/ sudo mkdir /home/*/sshfs/tegra-ubuntu/
#sudo mkdir ~/tegra-ubuntu/

export arcfour=$(ssh -Q cipher localhost | paste -d , -s - | grep -o "arcfour")
export aes128=$(ssh -Q cipher localhost | paste -d , -s - | grep -o "aes128-cbc")
export rj=$(ssh -Q cipher localhost | paste -d , -s - | grep -o "rijndael-cbc@lysator.liu.se")
if [ ! -z "$arcfour" ]; then
export cipher="arcfour"
elif [ ! -z "$rj" ]; then
export cipher=$rj
else
export cipher=$aes128
fi
#sudo sshfs -o Ciphers=arcfour128 -o Compression=no -o idmap=user,nonempty,allow_root,direct_io,\
#kernel_cache,auto_cache,IdentityFile=/home/*/.ssh/id_rsa \
#ubuntu@192.168.1.250:/ /home/*/sshfs/tegra-ubuntu
#bash /home/charlieporth/startup/youtrack-2018.1.41051/bin/youtrack.sh start

#bash /home/charlieporth/startup/youtrack-2018.1.41051/bin/youtrack.sh start
mount -t tmpfs -o size=1512M tmpfs /home/*/sshfs/
#sudo sshfs -o cache_timeout=115200 -o attr_timeout=115200 -o entry_timeout=1200 -o max_readahead=90000 \
#-o Ciphers=$cipher -o Compression=no -o \
#idmap=user,nonempty,large_read,allow_root,direct_io,\
#kernel_cache,auto_cache,reconnect,default_permissions,big_writes,IdentityFile=/home/*/.ssh/id_rsa \
#tegra-ubuntu:/ /home/*/sshfs/tegra-ubuntu
sudo mount 192.168.1.250:/ ./sshfs/tegra-ubuntu -o fsc

