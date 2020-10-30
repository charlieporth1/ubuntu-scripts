mount -t tmpfs -o size=1G tmpfs /mywebsite/wp-content/cache/wp-rocket
echo "tmpfs  /home/ubuntuserver/sshfs/ tmpfs defaults,size=1G 0 0" >> /etc/fstab;
