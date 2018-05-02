#sudo sshfs -o idmap=user,nonempty,allow_other ubuntu@192.168.1.250:/home/ubuntu/sshfs/tegra-ubuntu /home/charlieporth/sshfs/tegra-ubuntu
#sudo sshfs -o idmap=user,nonempty,allow_other ubuntu@192.168.1.250:/mnt/HDD /home/charlieporth/sshfs/tegra-ubuntu
#sudo  sshfs -o idmap=user,nonempty,allow_other ubuntu@192.168.1.250:/  /home/charlieporth/sshfs/tegra-ubuntu
#sudo sshfs -o Ciphers=arcfour -o Compression=no -o idmap=user,nonempty,allow_other,direct_io,kernel_cache,auto_cache,IdentityFile=/home/charlieporth/.ssh/id_rsa ubuntu@192.168.1.250:/mnt/HDD /home/charlieporth/sshfs/tegra-ubuntu
#allow_other,allow_root


sudo sshfs -o Ciphers=arcfour128 -o Compression=no -o idmap=user,nonempty,allow_root,direct_io,\
kernel_cache,auto_cache,IdentityFile=/home/charlieporth/.ssh/id_rsa \
ubuntu@192.168.1.250:/ /home/charlieporth/sshfs/tegra-ubuntu
bash /home/charlieporth/startup/youtrack-2018.1.41051/bin/youtrack.sh start
