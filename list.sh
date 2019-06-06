for f in /usr/share/nano/*.nanorc;  do echo "include \"${f}\"" >> /etc/nanorc ; done;
echo done
