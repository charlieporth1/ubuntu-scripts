sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo pihole -g
sudo bash setup/cron.sh 
sudo nano setup/cron.sh 
sudo ./update.sh 
systemctl status ctp-dns
systemctl status pihole-FTL.service 
pihole status
ifconfig
pihole status
systemctl status pihole-FTL.service 
systemctl status doh-server.service 
systemctl status nginx
systemctl status ctp-dns.service 
tail -f /var/log/ctp-dns/default.log 
sudo nano ctp-dns.service 
sudo nano ctp-dns.service  -l
systemctl status ctp-dns.service 
sudo nano ctp-dns.service  -l
sudo nano /mnt/HDD/Programs/reload_ctp-dns.sh
ll /etc/systemd/system/ctp-dns.service
cp -rf ctp-dns.service $PROG
sudo nano ctp-dns.service  -l
sudo nano /mnt/HDD/Programs/reload_ctp-dns.sh
systemctl status pihole-FTL.service fi
sudo systemctl daemon-reload && sudo systemctl restart ctp-dns.service
sudo systemctl status ctp-dns.service
sudo nano /mnt/HDD/Programs/reload_ctp-dns.sh
sudo nano ctp-dns.service  -l
cat ctp-dns.service | grep IP_R
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})"; /bin/systemctl set-environment FAILOVER2=$( [
[ -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.
15 )'
sudo nano ctp-dns.service  -l
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})"; /bin/systemctl set-environment FAILOVER2=$( [[ -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.
15 )'
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})";sudo /bin/systemctl set-environment FAILOVER2=$( [[ -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.15 )'
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})";  [[ -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.15 )'
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})";  [[ -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.15 '
sudo nano ctp-dns.service  -l
grep IP_R ctp-dns.service 
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"; /bin/systemctl set-environment FAILOVER2=$( [[ -
n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.15 
)'
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"; /bin/systemctl set-environment FAILOVER2=$( [[ -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.15 )'
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"; $([[   -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.15 )'
/bin/bash -c "; $([[   -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) ]])'
/bin/bash -c  $([[   -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) ]])'
/bin/bash -c  '$([[   -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) ]])'
/bin/bash -c '  -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" )'
/bin/bash -c '   $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" )'
/bin/bash -c '   $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev )'
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})";  $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}" ) '
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})";  dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}"  '
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})";  dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev 
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})";  dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev '
/bin/bash -c 'export IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})";  dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}"  '
/bin/bash -c 'export IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})";  dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "$IP_REGEX"  '
/bin/bash -c 'export IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})";  dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "${IP_REGEX}"  '
/bin/bash -c 'export IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})";  dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -o "([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"  '
nano ../ctp-dns.service 
sudo nano ../ctp-dns.service 
sudo cp -rf ../ctp-dns.service $PROG/
sudo nano /mnt/HDD/Programs/reload_ctp-dns.sho
sudo nano /mnt/HDD/Programs/reload_ctp-dns.sh
 nano /mnt/HDD/Programs/reload_ctp-dns.sh
sudo sudo systemctl daemon-reload && sudo systemctl restart ctp-dns.service
sudo systemctl daemon-reload && sudo systemctl restart ctp-dns.service
 nano /mnt/HDD/Programs/reload_ctp-dns.sh
sudo systemctl status ctp-dns.service
/bin/bash -c 'export IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})";  dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -Eo "([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"  '
grep IP_
grep IP_ ../ctp-dns.service 
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"; /bin/systemctl set-environment FAILOVER2=$( [[ -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -oE "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.15 )'
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"; /bin/systemctl set-environment sudo FAILOVER2=$( [[ -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -oE "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.15 )'
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"; echo $( [[ -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -oE "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.15 )'
sudo systemctl daemon-reload && sudo systemctl restart ctp-dns.service
sudo systemctl status ctp-dns.service
/bin/bash -c 'IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"; echo $( [[ -n $( dig +timeout=10 +tries=5 +short www.google.com @gcp.ctptech.dev | grep -oE "${IP_REGEX}" ) ]] && echo 35.232.120.211 || echo 94.140.15.15 )'
sudo nano ../ctp-dns.service 
/bin/systemctl set-environment 
/bin/systemctl unset-environment
/bin/systemctl unset-environment FAILOVER1
sudo /bin/systemctl unset-environment FAILOVER1
sudo ./update.sh --master --no-restart
systemctl status ctp-dns.service 
tail -f /var/log/nginx/home-*.log
curl -Ls https://github.com/ipinfo/cli/releases/download/ipinfo-1.1.0/deb.sh | sh
curl https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh | bash
grepip
echo 192.168.44.1 | grepip --ipv4 
sudo ./update.sh --master --no-restart
echo 192.168.44.1 | grepip --ipv4 
echo 192.168.44.1 | grepip 
echo 192.168.44.1 | grepip --help
echo 192.168.44.1 | grepip -o
sudo ./update.sh --master --no-restart
sudo docker ps
sudo docker logs 2ca8f660d921
sudo docker logs -f 2ca8f660d921
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
ll /var/www/html/
chown www-data:www-data /var/www/html/
sudo chown -R www-data:www-data /var/www/html/
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
curl 'https://home.ctptech.dev/phone_lookup'
curl 'https://home.ctptech.dev/phone_lookup/'
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
curl 'https://home.ctptech.dev/phone_lookup/'
git clone https://github.com/famavott/osint-scraper
cd osint-scraper/
ls
pip3 install -r requirements.txt 
pip2 install -r requirements.txt 
python  setup.py install
sudo python  setup.py install
pip2 install -r requirements.txt 
pserve development.ini --reload
nano development.ini 
pserve development.ini --reload
pip3 install -r requirements.txt 
sudo python3  setup.py install
curl http://localhost:6543
curl 'http://localhost:6543'
pserve development.ini --reload
sudo python3  setup.py install
pip3 install -r requirements.txt 
pip install -e .
pip3 install -e .
sudo pip3 install -e .
python3 -m venv ENV
sudo python3 -m venv ENV
sudo apt-get install python3-venv
sudo python3 -m venv ENV
source ENV/bin/activate
python3 -m pip install -r requirements.txt
sudo python3 -m pip install -r requirements.txt
source ENV/bin/activate
pserve development.ini --reload
pip3 install pytest
sudo pip3 install pytest
sudo pserve development.ini --reload
sudo pip3 install bs4
curl 'http://localhost:6543'
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo ngix -t
sudo ngnix -t
sudo nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo ngnix -t
sudo nginx -t
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
curl -i https://home.ctptech.dev/osint1/
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
curl -i https://home.ctptech.dev/osint1/
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
curl -i https://home.ctptech.dev/osint1/
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
curl -i https://home.ctptech.dev/osint1/
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
curl -i https://home.ctptech.dev/osint1/
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
curl -i https://home.ctptech.dev/osint1/
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nano /etc/nginx/snippets/security_header.conf 
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
curl -i https://home.ctptech.dev/osint1/
sudo nano /etc/nginx/sites-enabled/home.conf 
curl -i https://home.ctptech.dev/osint1/
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nano /etc/nginx/snippets/security_header.conf 
sudo nano /etc/nginx/snippets/unblocker_header.conf 
sudo nano /etc/nginx/snippets/security_header.conf 
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
curl -i https://home.ctptech.dev/osint1/
sudo systemctl restart nginx
curl -i https://home.ctptech.dev/osint1/
sudo nano /etc/nginx/sites-enabled/home.conf 
dig www.ads.com @home.ctptech.dev
sudo nano /etc/cron.d/ubuntu-server-update-gravity 
history grep update
history | grep update
sudo ./update.sh --master
sudo nano ~/ctp-dns.service 
sudo ./update.sh --master
sudo ./update.sh --master --no-restart
systemctl status ctp-dns.service 
journalctl -xe
tail -f /var/log/health-check.log 
tail -100 /var/log/health-check.log 
tail -f /var/log/health-check.log 
sudo ./update.sh --master --no-restart
ls
sudo git pull
adb shell settings put global bluetooth_on 1
dig www.ads.com @home.ctptech.dev
sudo bash /mnt/HDD/Programs/copy_gravity.sh 
dig www.ads.com @home.ctptech.dev
pihole restartdns
dig www.ads.com @home.ctptech.dev
systemctl status ctp-dns.service 
systemctl status ctp-dns.service q
systemctl status ctp-dns.service 
systemctl status ctp-dns.service q
systemctl status ctp-dns.service qq
systemctl status ctp-dns.service 
tail -f /var/log/health-check.log
tail -60 /var/log/health-check.log
systemctl status nginx
tail -60 /var/log/health-check.log
pihole status
systemctl status ctp-dns.service 
systemctl status pihole-FTL.service 
systemctl status ctp-dns.service 
cd Pihole-Slave-Install/
sudo git pull
sudo tail -f /var/log/health-check.log
sudo fail2ban-client  status pihole-dns
sudo fail2ban-client  status pihole-dns | grep 84
sudo fail2ban-client  status pihole-dns | grep 1744
sudo fail2ban-client  status pihole-dns | grep 174
sudo fail2ban-client  status pihole-dns-1-block | grep 174
dig @68.86.235.193
dig @162.151.138.9
dig @96.120.48.225
dig @96.108.53.37
dig @96.110.40.101
dig @96.110.38.118
dig @75.75.75.75
exit
tail -f /var/log/nginx/doh-*.log
sudo nano /etc/nginx/sites-enabled/home.conf 
systemctl restart nginxx
systemctl restart nginx
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
systemctl status ctp-dns
systemctl status ctp-dns
systemctl status ctp-dns
tail -f $log/health-check.log 
exit
tail -f $log/health-check.log 
sudo nank $prog/test_doh.sh
sudo nano $prog/test_doh.sh
pihole status
systemctl status nginx
tail -f /var/log/nginx/doh-*.log
ls /tmp/nginx/0000001316"
ls /tmp/nginx/0000001316
ls /tmp/nginx/
mkdir /tmp/nginx
systemctl status rc-local.service 
sudo ./update.sh --master 
dig http://compozelabs.com/
dig compozelabs.com
dig www.compozelabs.com
dig www.compozelabs.com @home.ctptech.dev
dig compozelabs.com @home.ctptech.dev
dig www.compozelabs.com @home.ctptech.dev
dig www.compozelabs.com
dig -t AAAA www.compozelabs.com
dig -t any  www.compozelabs.com
dig -t any  compozelabs.com
last
last -20
tail -f /var/log/nginx/doh-*.log
sudo chown -R www-data:www-data /tmp/ngix
sudo chown -R www-data:www-data /tmp/nginx
sudo nano $sites/doh
systemctl restart nginx
sudo systemctl restart nginx
sudo nginx -t
sudo ./update.sh --master
tail -f /var/log/nginx/doh-*.log
sudo nano $sites/doh
systemctl restart nginx
sudo systemctl restart nginx
tail -f /var/log/nginx/doh-*.log
sudo nano /etc/nginx/sites-enabled/home.conf 
nano /etc/nginx/snippets/security_header.conf 
sudo nano /etc/nginx/sites-enabled/home.conf 
systemctl restart nginx
sudo systemctl restart nginx
tail -f /var/log/nginx/doh-*.log
tail -f /var/log/nginx/home--*.log
sudo pserve development.ini --reload
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
nano development.ini 
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
ifconfig
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
tail -f /var/log/nginx/home-*.log
sudo pserve development.ini --reload
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo pserve production.ini --reload
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nginx -t
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nano /etc/nginx/snippets/security_header.conf 
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nano /etc/nginx/snippets/security_header.conf 
sudo nano /etc/nginx/snippets/unblocker_header.conf 
sudo nano /etc/nginx/snippets/security_header.conf 
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo pserve development.ini --reload
ls
nano nano run
bash run
sudo bash run
nano run
sudo bash run
sudo nano  run
nano runapp.py 
nano run
nano runapp.py 
nano run
sudo nano /etc/nginx/sites-enabled/home.conf 
tail -f /var/log/nginx/home--*.log
sudo bash run
ls
ls dist
ls build
tail -f /var/log/nginx/home-*.log
sudo nano $sites/doh
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
dig bootswatch.com @dns.ctptech.dev
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
touch /var/www/html/osint-login/
mkdir -p /var/www/html/osint-login/
sudo mkdir -p /var/www/html/osint-login/
sudo nano  /var/www/html/osint-login/login.php
sudo nano  /var/www/html/osint-login/logout.php
sudo nano  /var/www/html/osint-login/login.php
sudo apt-get install php-fpm php-mcrypt php-cli php-mysql
sudo nano /etc/php/7.4/fpm/php.ini
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nano /etc/nginx/snippets/php.conf 
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nginx -t
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nano /etc/nginx/nginx.conf
sudo nginx -t
sudo nano /etc/nginx/nginx.conf
sudo nginx -t
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nano /etc/nginx/sites-enabled/doh
sudo nano /etc/nginx/sites-enabled/doh.bk 
sudo cp -rf  /etc/nginx/sites-enabled/doh.bk  /etc/nginx/sites-enabled/doh
sudo nano /etc/nginx/sites-enabled/doh
sudo cp -rf  /etc/nginx/sites-enabled/doh  /etc/nginx/sites-enabled/doh.bk
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nginx -t
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo sh -c "echo -n 'charlieporth1:' >> /etc/nginx/.htpasswd"
"openssl passwd -apr1
openssl passwd -apr1
sudo sh -c "openssl passwd -apr1 >> /etc/nginx/.htpasswd"
cat /etc/nginx/.htpasswd
sudo sh -c "openssl passwd -apr1cogdfzwherfddewgovklsewfeivdxkwergovjdewreivxdwoevkxczewoicekdf >> /etc/nginx/.htpasswd"
cat /etc/nginx/.htpasswd
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
systemctl status asn.service 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
curl http://127.0.0.1:49200/asn_lookup;
curl 'http://127.0.0.1:49200/asn_lookup'
systemctl status asn.service 
curl 'http://127.0.0.1:49200/asn_lookup'
nano /etc/systemd/system/asn.service 
curl 'http://127.0.0.1:49200/asn_lookup'
nano /etc/systemd/system/asn.service 
sudo nano /etc/systemd/system/asn.service 
sudo systemctl restart nginx
sudo systemctl restart asn.service 
sudo systemctl daemon-reload
sudo systemctl restart asn.service 
sudo nano /etc/systemd/system/asn.service 
curl 'http://127.0.0.1:49200/asn_lookup'
sudo nano /etc/nginx/sites-enabled/home.conf 
curl 'http://127.0.0.1:49200/asn_lookup'
curl -i 'http://127.0.0.1:49200/asn_lookup'
curl -i 'http://127.0.0.1:49200/asn_lookup/
curl -i 'http://127.0.0.1:49200/asn_lookup/'
systemctl status asn.service 
curl -i 'http://127.0.0.1:49200/asn_lookup/'
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo nano /etc/systemd/system/asn.service 
/usr/bin/asn
sudo nano /etc/systemd/system/asn.service 
sudo systemctl daemon-reload
sudo systemctl restart asn.service 
curl -i 'http://127.0.0.1:49200/asn_lookup/'
curl -i 'http://127.0.0.1:49200/asn_lookup'
curl -i 'http://192.168.44.250:49200/asn_lookup'
systemctl status asn.service 
sudo nano /etc/systemd/system/asn.service 
curl "https://raw.githubusercontent.com/nitefood/asn/master/asn" > /usr/bin/asn && chmod 0755 /usr/bin/asn
sudo nano /etc/systemd/system/asn.service 
sudo /bin/bash -c 'curl "https://raw.githubusercontent.com/nitefood/asn/master/asn" > /usr/bin/asn && chmod 0755 /usr/bin/asn'
asn --help
asn -d -l
sudo nano /etc/systemd/system/asn.service 
/usr/bin/asn -d -s -o -l 127.0.0.1 49200
/usr/bin/asn -d -s -l 127.0.0.1 49200
/usr/bin/asn -d  -l 127.0.0.1 49200
/usr/bin/asn   -l 127.0.0.1 49200
curl -i 'http://127.0.0.1:49200/asn_lookup'
curl -i 'http://127.0.0.1:49200/asn_lookup/'
curl -i 'http://127.0.0.1:49200/asn_lookup&122.122.122.122'
sudo nano /etc/systemd/system/asn.service 
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
curl 'https://home.ctptech.dev/osint/phone_lookup/'
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo  nano snippets/security_header.conf
sudo  nano $snippets/security_header.conf
sudo  nano snippets/security_header.conf
sudo  nano $snippets/security_header.conf
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo bash run
ls ~/osint-scraper/run
sudo nano ../phoneinfoga/start_osint.sh 
cd ..
git clone https://github.com/smicallef/spiderfoot.git
cd spiderfoot
pip3 install -r requirements.txt
sudo nano /etc/nginx/sites-enabled/home.conf 
ping 192.168.44.129
nmap -T4  192.168.44.129
dig nakedsecurity.sophos.com @gcp.ctptech.dev
curl --resolve=35.232.120.211:443 'http://nakedsecurity.sophos.com/blockpage/index.php'
curl --resolve=35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/blockpage/index.php'
curl --resolve 35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/blockpage/index.php'
curl --resolve 35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/'
curl --resolve 35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/blockpage/index.php'
curl --resolve 35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/admin'
curl --resolve 35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/.well-known/'
curl --resolve 35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/blockpage/index.php'
curl --resolve 35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/'
curl --resolve 35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/blockpage/index.php'
curl --resolve 35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/blockpage/'
curl --resolve 35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/blockpage/index.php'
curl --resolve 35.232.120.211:443:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/blockpage'
curl --resolve 35.232.120.211:80:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/blockpage'
curl --resolve 35.232.120.211:80:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/blockpage/index.php'
curl --resolve 35.232.120.211:80:nakedsecurity.sophos.com 'http://nakedsecurity.sophos.com/index.php'
curl 35.232.120.211
curl 35.232.120.211/index.php
curl 35.232.120.211/blockpage/index.php
curl 35.232.120.211:2443/index.php
curl 35.232.120.211:3000/index.php
curl 35.232.120.211:7000/index.php
curl 35.232.120.211:7000/blockpage/index.php
curl 35.232.120.211
curl http://35.232.120.211
curl https://35.232.120.211/blockpage/index.php?url=35.232.120.211
curl 'http://35.232.120.211/blockpage/index.php?url=35.232.120.211'
curl 'https://35.232.120.211/blockpage/index.php?url=35.232.120.211'
curl --insecure 'https://35.232.120.211/blockpage/index.php?url=35.232.120.211'
sudo pip3 install -r requirements.txt
 python3 ./sf.py -l 127.0.0.1:5001
sudo python3 ./sf.py -l 127.0.0.1:5001
sudo python3 ~/spiderfoot//sf.py -l 127.0.0.1:5001
ls ~/spiderfoot//sf.py 
ls ~/spiderfoot/sf.py 
sudo nano ../phoneinfoga/start_osint.sh 
sudo ln -s  ~/phoneinfoga/start_osint.sh  ~/
sudo nano ../phoneinfoga/start_osint.sh 
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
sudo systemctl restart nginx
sudo python3 ~/spiderfoot//sf.py -l 127.0.0.1:5001
cd ..
git clone https://github.com/saeeddhqan/maryam.git
cd maryam
pip install -r requirements
sudo pip install -r requirements
sudo pip3 install -r requirements
python3 maryam -e help
sudo pip3 install -r requirements
python3 maryam -e help
python3 -v
python3 -V
python3 maryam -e help
pip3 install flask
sudo pip3 install flask
exit
nano ~/start_osint.sh 
cd /home/ubuntuserver/spiderfoot/
ls
sudo pip3 install -r requirements.txt 
cd ..
cd maryam/
sudo pip3 install -r requirements.txt 
sudo pip3 install -r requirements 
python3 maryam -e help
python3 maryam web api
python3 maryam web api -s
curl http://127.0.0.1:1313/
curl -i http://127.0.0.1:1313/
python3 maryam -e web api -s
python3 maryam -e web 
sudo nano /etc/nginx/sites-enabled/home.conf 
htop
sudo systemctl restart nginx
python3 maryam -e web api  127.0.0.1:1313
python3 maryam -e web  127.0.0.1:1313
python3 maryam -s web  127.0.0.1:1313
python3 maryam -e web  127.0.0.1:1313
/api/framework
python3 maryam -e show modules
./maryam
python3 maryam -e web  127.0.0.1:1313
ls
python3 maryam -e web api  127.0.0.1:1313
cd  ..
git clone https://github.com/jmortega/osint_tools_security_auditing
git clone https://github.com/loseys/Oblivion
cd Oblivion/
ls
cd Linux/
ls
 kdig -t ANY -d @gcp.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev pizzaseo +dnssec +edns
 kdig -t RRSIG -d @gcp.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev pizzaseo +dnssec +edns
sudo nano /mnt/HDD/Programs/test_doh.sh
nano /mnt/HDD/Programs/test_doh.sh
curl         -H 'accept: application/dns-message'         --resolve dns.ctptech.dev:443:$EXTENRAL_IP -sw '\n'         "https://dns.ctptech.dev:443/dns-query?dns=$(dns2doh --A dns.ctptech.dev)"
nano /mnt/HDD/Programs/test_doh.sh
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev/resolve?name=www.google.com&type=A"
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev/dns-query?dns=$(dns2doh --A dns.ctptech.dev)""
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev/dns-query?dns=$(dns2doh --A dns.ctptech.dev)"
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev/dns-query?dns=$(dns2doh --A dns.ctptech.dev)" --ouput -
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev/dns-query?dns=$(dns2doh --A pizzaseo)" --ouput -
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev/dns-query?dns=$(dns2doh --A pizzaseo)" --output -
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev/dns-query?dns=$(dns2doh --A pizzaseo)" --output - | hexdump -C
dns2doh
dns2doh --A pizzaseo
dns2doh --A pizzaseo.org
dns2doh 
which dns2doh 
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev/dns-query?dns=$(dns2doh --A pizzaseo)" --output - | hexdump -C
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev/dns-query?dns=$(dns2doh --A pizzaseo)"  | hexdump -C
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev:4443/dns-query?dns=$(dns2doh --A pizzaseo)"  | hexdump -C
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev:4443/dns-query?dns=$(dns2doh --A pizzaseo.org)"  | hexdump -C
curl --resolve  -w '\n' "https://gcp.ctptech.dev:4443/dns-query?dns=$(dns2doh --A pizzaseo.org)"  | hexdump -C
dns2doh --A pizzaseo.org)
dns2doh --A pizzaseo.org
dns2doh -h
dns2doh --help
$(dns2doh --A pizzaseo.org)
echo $(dns2doh --A pizzaseo.org)
echo $(dns2doh --AAAA  pizzaseo.org)
echo $(dns2doh --NS  pizzaseo.org)
dig pizzaseo.org
dig pizzaseo.net
dig pizzaseo.com
dns2doh --A pizzaseo.com
curl --resolve dns.ctptech.dev:443:35.192.105.158 -w '\n' "https://dns.ctptech.dev:4443/dns-query?dns=$(dns2doh --A pizzaseo.com)"  | hexdump -C
systemctl status ctp-dns.service 
tail -f /var/log/health-check.log 
sudo nano /mnt/HDD/Programs/test_doh.sh
tail -f /var/log/health-check.log 
cd Pihole-Slave-Install/
sudo ./update.sh --master
sudo fail2ban-client  status nginx-auth
sudo fail2ban-client  status
sudo fail2ban-client  status nginx-http-auth
sudo fail2ban-client  unbanip 192.168.44.1
sudo fail2ban-client  unbanip nginx-http-auth 192.168.44.1
sudo fail2ban-client unban nginx-http-auth 192.168.44.1
sudo fail2ban-client ignoreip nginx-http-auth 192.168.44.1
sudo nano /etc/fail2ban/jail.conf 
sudo ./update.sh --master --no-restart
sudo tail -f /var/log/health-check.
sudo tail -f /var/log/health-check.log
systemctl status ctp-dns.service 
systemctl status ctp-dns | grep -oE 'de?activating'`
systemctl status ctp-dns | grep -oE 'de?activating'
systemctl status ctp-dns.service 
systemctl restart ctp-dns.service 
sudo systemctl restart ctp-dns.service 
systemctl status ctp-dns | grep -oE 'de?activating'`
sudo systemctl daemon-reload
sudo systemctl restart ctp-dns.service 
htop
sudo systemctl restart ctp-dns.service 
systemctl status ctp-dns | grep -oE 'de?activating'`
systemctl status ctp-dns | grep -oE 'de?activating'
systemctl status ctp-dns 
systemctl status ctp-dns | grep -oE 'de?activating'
systemctl status ctp-dns | grep -oE '(de|)activating'
systemctl status ctp-dns | grep -oE '(de)activating'
systemctl status ctp-dns | grep -oE '(de|)activating'
tail -f /var/log/nginx/home-*.log
which doh
systemctl status ctp-dns 
sudo tail -f /var/log/health-check.log
sudo git pull
cp -rf /etc/nginx/sites-enabled/doh.bk $sites/doh
sudocp -rf /etc/nginx/sites-enabled/doh.bk $sites/doh
sudo cp -rf /etc/nginx/sites-enabled/doh.bk $sites/doh
systemctl restart nginx
sudo systemctl restart nginx
sudo nano /mnt/HDD/Programs/health-check.sh
sudo nano /mnt/HDD/Programs/pm.health-check.sh
git pull
sudo git pull
sudo tail -f /var/log/health-check.log
dig @home.ctptech.dev
sudo nano /mnt/HDD/Programs/pm.health-check.sh
sudo tail -f /var/log/health-check.log
systemctl status doh-server.service 
systemctl status ctp-dns 
$PROG/grepify.sh $(bash $PROG/get_ext_ip.sh)
bash $PROG/get_ext_ip.sh --current-ip
EXTENRAL_IP=`bash $PROG/get_ext_ip.sh --current-ip`
HOST=dns.ctptech.dev
QUERY=www.google.com
TIMEOUT=5
TRIES=2
IP_REGEX="([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})"
timeout $TIMEOUT doh -rdns.ctptech.dev:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST/dns-query:4443"
doh_remote_ctp=`timeout $TIMEOUT doh -rdns.ctptech.dev:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST/dns-query:4443"`
echo "$doh_remote_ctp" | grepip --ipv4 -o | xargs
echo "$doh_remote_ctp" | grepip --ipv4 -o
echo "$doh_remote_ctp" | grepip  -o 
sudo git pull
systemctl status ctp-dns 
systemctl status ctp-dns q
systemctl status ctp-dns 
sudo nano /mnt/HDD/Programs/pm.health-check.sh
systemctl status ctp-dns 
sudo fail2ban-client status pihole-dns-1-block
sudo fail2ban-client status ctp-dns-1-block
systemctl status fail2ban.service 
sudo fail2ban-client start ctp-dns-1-block
sudo nano /etc/environment
sudo git pull
ls config/fail2ban/filter.d/ctp-dns-1-block.conf 
ls /etc/
ls /etc/fail2ban/filter.d/ctp-dns-1-block.conf 
sudo ./update.sh 
sudo ./copy_config.sh 
sudo ./update.sh  --master
sudo nano /etc/environment
sudo ./update.sh  --master
sudo nano /etc/environment
[[ -e $IS_MASTER ]]
[[ -e $IS_MASTER ]] && true
[[ -e $IS_MASTER ]] && echo true
[[ -e IS_MASTER ]] && echo true
[[  -n $IS_MASTER ]] && echo true
[[  -v $IS_MASTER ]] && echo true
sudo ./update.sh  --master
rm -rf /home/ubuntuserver/Programs/copy_gravity.sh
cd Pihole-Slave-Install/
sudo ln -s ~/Pihole-Slave-Install/master/copy_gravity.sh /home/ubuntuserver/Programs/copy_gravity.sh
sudo ln -s ~/Pihole-Slave-Install/master/*.sh /home/ubuntuserver/Programs/copy_gravity.sh
sudo ln -s ~/Pihole-Slave-Install/master/copy_master_pihole_config.sh /home/ubuntuserver/Programs/copy_gravity.sh
sudo ln -s ~/Pihole-Slave-Install/master/copy_master_pihole_config.sh /home/ubuntuserver/Programs/copy_master_pihole_config.sh 
rm -rf /home/ubuntuserver/Programs/copy_master_pihole_config.sh
sudo ln -s ~/Pihole-Slave-Install/master/copy_master_pihole_config.sh /home/ubuntuserver/Programs/copy_master_pihole_config.sh 
sudo ln -s ~/Pihole-Slave-Install/master/nginx_doh_setup.sh /home/ubuntuserver/Programs/nginx_doh_setup.sh
sudo ./setup/master_config.sh 
systemctl status ctp-dns 
systemctl status pihole-FTL.service 
sudo git pull
sudo fail2ban-client start ctp-dns-1-block 
ls /etc/fail2ban/jail.d/ctp-dns-1-block.conf 
sudo fail2ban-client reload
sudo nano  /etc/fail2ban/jail.d/ctp-dns-1-block.conf 
sudo fail2ban-client reload
sudo nano  /etc/fail2ban/jail.d/ctp-dns-1-block.conf 
sudo nano  /etc/fail2ban/filter.d/ctp-dns-1-block.conf 
sudo ./copy_config.sh 
systemctl status ctp-dns 
systemctl status ctp-dns.service 
sudo fail2ban-client status ctp-dns-1-block | grep 54
sudo fail2ban-client status ctp-dns-1-block | 
sudo fail2ban-client status ctp-dns-1-block 
sudo fail2ban-client status pihole-dns
sudo fail2ban-client status pihole-dns | 192
sudo fail2ban-client status pihole-dns | grep 192
sudo fail2ban-client status pihole-dns | grep 174
sudo fail2ban-client status pihole-dns | grep 54
sudo fail2ban-client status pihole-dns | grep 20
sudo fail2ban-client status pihole-dns | grep 20\.
sudo fail2ban-client status pihole-dns | grep 20
sudo fail2ban-client status pihole-dns | grep 35
sudo fail2ban-client status pihole-dns | grep 35.192
sudo fail2ban-client status pihole-dns | grep 192.35
sudo fail2ban-client status pihole-dns-1-block
sudo fail2ban-client status pihole-dns-1-block | grep 192
sudo fail2ban-client status pihole-dns-1-block | grep 174
systemctl status ctp-dns.service 
sudo nano /mnt/HDD/Programs/pm.health-check.sh
sudo bash /mnt/HDD/Programs/pm.health-check.sh
systemctl status ctp-dns.service 
curl --insecure -H 'accept: application/dns-json' -sw '\n' "http://localhost:8053/dns-query?name=www.google.com&type=A"
systemctl status doh-server.service 
systemctl restart doh-server.service 
sudo systemctl restart doh-server.service 
curl --insecure -H 'accept: application/dns-json' -sw '\n' "http://localhost:8053/dns-query?name=www.google.com&type=A"
sudo nano /etc/dns-over-https/doh-server.conf
sudo systemctl restart doh-server.service 
curl --insecure -H 'accept: application/dns-json' -sw '\n' "http://localhost:8053/dns-query?name=www.google.com&type=A"
systemctl status doh-server.service 
sudo nano /etc/dns-over-https/doh-server.conf
sudo systemctl restart doh-server.service 
curl --insecure -H 'accept: application/dns-json' -sw '\n' "http://localhost:8053/dns-query?name=www.google.com&type=A"
sudo tail -f /var/log/health-check.log
sudo nano /etc/dns-over-https/doh-server.conf
sudo tail -f /var/log/health-check.log
sudo systemctl start ctp-dns.service
sudo tail -f /var/log/health-check.log
history | grep dig
 kdig -t RRSIG -d @gcp.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev pizzaseo +dnssec +edns
systemctl status nginx
systemctl status ctp-dns.service 
systemctl status pihole-FTL.service 
systemctl status ctp-dns.service 
sudo nano /etc/dns-over-https/doh-server.conf
systemctl status ctp-dns.service 
systemctl status pihole-FTL.service 
systemctl status ctp-dns.service 
systemctl status nginx
 kdig -t RRSIG -d @gcp.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev pizzaseo +dnssec +edns
 kdig -t RRSIG -d @gcp.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev pizzaseo.com +dnssec +edns
 kdig -t RRSIG -d @gcp.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +dnssec +edns
tail -f /var/log/nginx/doh-*.log
sudo ./update.sh --master
sudo cp -rf /etc/nginx/sites-enabled/doh.bk /etc/nginx/sites-enabled/doh
git pull
sudo git pull
sudo ./update.sh --master --no-restart
cd Pihole-Slave-Install/
sudo ./update.sh --master --no-restart
ls
pihole -t
sudo ./apply_config.sh 
sudo su
sudo ./apply_config.sh 
systemctl statusss ctp-dns
systemctl status ctp-dns
nano ~/ctp-dns.service 
sudo nano ~/ctp-dns.service 
sudo fail2ban-client statuss 
sudo fail2ban-client status
sudo fail2ban-client status sshd
sudo fail2ban-client set sshd unban 192.168.44.29
sudo fail2ban-client set sshd unbanip 192.168.44.29
last -l
last -10
last -20
sudo nano /etc/bash.bashrc 
cd Pihole-Slave-Install/
ls
git pull
sudo ./install.sh --oac
history | grep dig
 dig -t RRSIG -d @gcp.ctptech.dev +tcp www.google.com +dnssec +edns
 dig -t RRSIG  @gcp.ctptech.dev +tcp pizzaseo.com +dnssec +edns
pihole -t
cd Pihole-Slave-Install/
git pull
sudo git pull
sudo ./install.sh --oac
systemctl status ctp-dns.service 
systemctl status nginx
sudo nano /etc/nginx/sites-enabled/home.conf 
dnsproxy --help
dnsproxy -v
dnsproxy -V
dnsproxy --version
git clone https://github.com/gwen001/pentest-tools
cd pentest-tools/
ls
python domain-finder.py 
python domain-finder.py  --help
ls
pip3 install -r requirements3.txt 
python domain-finder.py  --help
python3 domain-finder.py  --help
python3 domain-finder.py -c google.com
cd ..
git clone https://github.com/shadowcodex/domain-finder
cd domain-finder/
ls
python3  domainfinder.py 
whois
whois google.com
python3  domainfinder.py 
nano domain_log.txt 
nano domain*
ls
gem install fortune-finder
ssudo gem install fortune-finder
sudo gem install fortune-finder
fortune-finder
fortune-finder --help
cd ..
cd Pihole-Slave-Install/
git pull
sudo git pull
./reload_ctp-dns.sh 
systemctl status ctp-dns
sudo su
cd Pihole-Slave-Install/
ls
sudo git pull
sudo ./copy_config.sh 
sudo bash master/copy_master_pihole_config.sh 
sudo nano /home/charlieporth1_gmail_com/Programs/heath-check.sh
mv /tmp/heath-check.sh ~/Programs
sudo mv /tmp/heath-check.sh ~/Programs
sudo crontab -e
ls
nao prog/health-check.sh 
nano prog/health-check.sh 
sudo nano /mnt/HDD/Programs/health-check.sh
sudo git pull 
ls
ls master/
sudo bash  master/copy_master_pihole_config.sh 
mv /tmp/start_processes.sh /home/charlieporth1_gmail_com/Programs/start_processes.sh 
ls /tmp/heath-check.sh 
sudo nano  /tmp/heath-check.sh 
sudo nano /tmp/start_processes.sh 
sudo mv /tmp/start_processes.sh /home/charlieporth1_gmail_com/Programs/start_processes.sh 
sudo mv /tmp/start_processes.sh /home/charlieporth1_gmail_com/Programs/
sudo cp -rf /tmp/start_processes.sh /home/charlieporth1_gmail_com/Programs/
sudo cp -rf /tmp/start_processes.sh $PROG
sudo cp -rf /tmp/{start_processes.sh,heath-check.sh} $PROG
sudo git pull
sudo crontab -e
sudo ./update.sh 
sudo nano /etc/dnsmasq.d/88-custom-dns-servers.conf 
sudo rm -rf /etc/unbound/unbound.conf.d/{03-auth-dns.conf,05*}
cd Pihole-Slave-Install/
sudo ./update.sh 
sudo fail2ban-client status
sudo fail2ban-client status sshd
sudo fail2ban-client status sshd | grep 192
git pull
sudo fail2ban-client status sshd | grep 192
sudo ./update.sh 
htop
sudo nano $prog/cpu_groups.sh
cgset
sudo apt install cgroup-tools
sudo nano $prog/cpu_groups.sh
htop
sudo nano /mnt/HDD/Programs/cpu_group.sh
sudo nano ACESTREAM/Dockerfile 
sudo nano ACESTREAM/run.sh 
sudo nano ~/start_osint.sh 
htop
sudo reboot
sudo 
pihole -t
systemctl status pihole-FTL
systemctl restart pihole-FTL
sudo systemctl restart pihole-FTL
mkdir -p /var/cache/dnsmasq/
sudo mkdir -p /var/cache/dnsmasq/
sudo nano /mnt/HDD/Programs/start-config.sh
sudo nano /etc/rc.local
sudo systemctl restart pihole-FTL
sudo mkdir -p /var/cache/dnsmasq/
sudo systemctl restart pihole-FTL
pihole restartdns
touch  /var/cache/dnsmasq/dnsmasq_dnssec_timestamp
sudo touch  /var/cache/dnsmasq/dnsmasq_dnssec_timestamp
pihole restartdns
cd Pihole-Slave-Install/
sudo git pull
htop
pihole -g
pihole -g -r
sudo bash /mnt/HDD/Programs/copy_gravity.sh 
sudo nano /mnt/HDD/Programs/copy_gravity.sh 
 rclone -vvv copy remote:SERVER_DATA/gravity.db /etc/pihole
sudo  rclone -vvv copy remote:SERVER_DATA/gravity.db /etc/pihole
 n/#n/
dig --help
dig --help all
dig -h | more
pihole restartdns
lolcat
pihole restartdns
cd Pihole-Slave-Install/
pihole restartdns
sudo nano /etc/dnsmasq.d/01-pihole.conf 
sudo nano /etc/dnsmasq.d/10-servers.conf 
pihole restartdns
htop
qq
systemctl stop fail2ban
sudo nano /etc/logrotate.d/ctp-dns 
sudo nano /etc/logrotate.conf 
htop
killall fail2ban
sudo killall fail2ban-server
sudo systemctl stop fail2ban
htop
htop
pihole disable
pihole status
pihole enable
systemctl stop pihole-FTL
killal pihole-FTL
killall pihole-FTL
sudo systemctl stop pihole-FTL
killall ps
sudo killall ps
sudo killall pgrep
sudo apt purge haproxy
sudo apt purge haproxy dns2tcpd memcached
rm -rf /var/lib/dpkg/lock-
rm -rf /var/lib/dpkg/lock*
sudo rm -rf /var/lib/dpkg/lock*
sudo apt purge haproxy dns2tcpd memcached
killall bash
sudo killall bash
sudo killall netdata
pihole -t
sudo apt purge haproxy dns2tcpd memcached lxcfs 
htop
sudo crontab -e
killall awk
sudo killall awk
sudo killall awk ps grep bash pgrep 
sudo nano /mnt/HDD/Programs/Hourly.sh 
sudo nano /etc/nginx/nginx.conf
systemctl restart nginx
sudo systemctl restart nginx
sudo nano /etc/nginx/nginx.conf
sudo systemctl restart nginx
killall pm
killall `pgrep pm`
sudo killall `pgrep pm`
sudo killall `pgrep pm | xargs`
sudo killall `pgrep pm\. | xargs`
sudo killall `pgrep pm\.hea | xargs`
sudo killall `pgrep pm.hea | xargs`
sudo killall `pgrep 'pm.hea' | xargs`
sudo nano /mnt/HDD/Programs/Hourly.sh 
htop
pgrep pm
pgrep pm.heal
pgrep pm.hea
pgrep pm.h
pgrep pm
pgrep bash
sudo nano /mnt/HDD/Programs/Hourly.sh 
sudo nano /etc/nginx/nginx.conf
sudo systemctl restart nginx
sudo ./update.sh 
htop
]
pihole restartdns
sudo dpkg --configure -a
sudo apt purge haproxy dns2tcpd memcached lxcfs 
pihole -t
sudo nano /etc/dnsmasq.d/10-servers.conf 
pihole -t
sudo bash $prog/ctp-dn
exit
sudo nano /etc/cron.d/ubuntu-server-fill_cache 
pihole restartdns
cd Pihole-Slave-Install/
systemctl status unbound
systemctl enable unbound
sudo systemctl enable unbound
sudo systemctl unmask unbound
sudo nano /etc/dnsmasq.d/88-custom-dns-servers.conf 
sudo nano /etc/dnsmasq.d/10-servers.conf 
sudo nano /etc/dnsmasq.d/88-custom-dns-servers.conf 
sudo nano /etc/cron.d/ubuntu-server-fill_cache 
sudo nano /etc/cron.d/ubuntu-server-load_to_cache 
pihole -t
sudo nano /etc/pihole/pihole-FTL.conf 
sudo nano /etc/pihole/setupVars.conf
pihole -w stackoverflow.com
sudo nano /etc/pihole/setupVars.conf
pihole -w stackoverflow.com
cd Pihole-Slave-Install/
sudo git pull
htop
sudo nano /mnt/HDD/Programs/Hourly.sh 
 dig www.ads.com @gcp.ctptech.dev
 dig www.ads.com @dns.ctptech.dev
systemctl status ctp-dns
sudo nano ~/ctp-dns.service 
sudo crontab -e
  cp -rf /home/ubuntuserver/ctp-dns.service  /home/ubuntuserver/Programs/ && sudo systemctl daemon-reload
sudo  cp -rf /home/ubuntuserver/ctp-dns.service  /home/ubuntuserver/Programs/ && sudo systemctl daemon-reload
systemctl status ctp-dns
cd Pihole-Slave-Install/
sudo git pull
ifconfig
sudo git pull
cd Pihole-Slave-Install/
sudo git pull
pihole -t
sudo crontab -e
gcloud compute instances stop --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"
sudo crontab -e
gcloud compute instances start  --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"
systemctl status ctp-dns.service 
gcloud compute instances start  --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"
sudo nano /mnt/HDD/Programs/ctp-dns.service 
gcloud compute instances stop --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521" &&  && gcloud compute instances start  --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"
gcloud compute instances stop --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"  && gcloud compute instances start  --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"
systemctl status ctp-dns.service 
sudo su
cd Pihole-Slave-Install/
sudo git pull
sud git stash
sudo git pull
sudo git stash
sudo git pull
rm -rf prog/ctp-dns.service
sudo git pull
sudo bash /mnt/HDD/Programs/copy_certs.sh
ls
sudo bash setup/dns-route.sh 
ls 
ls /home/ubuntuserver/Programs/route-dns/slave-resolvers.toml:
ls /home/ubuntuserver/Programs/route-dns
ls prog/route-dns/
ln -s ~/Pihole-Slave-Install/prog/route-dns/ $PROG/
ln -s ~/Pihole-Slave-Install/prog/route-dns/* $PROG/
sudo git pull
sudo bash setup/dns-route.sh 
sudo nano /mnt/HDD/Programs/route-dns/slave-listeners.toml 
sudo git pull
sudo bash setup/dns-route.sh 
sudo nano /mnt/HDD/Programs/route-dns/slave-
sudo nano /mnt/HDD/Programs/route-dns/slave-listeners.toml 
sudo git stash
git pull
sudo git pull
sudo bash setup/dns-route.sh 
nano /mnt/HDD/Programs/route-dns/slave-listeners.toml 
ROUTE=$PROG/route-dns
 rm -rf $ROUTE/slave-listeners.toml
sudo git pull
sudo bash setup/dns-route.sh 
sudo git pull
sudo bash setup/dns-route.sh 
nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml 
sudo nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml 
sudo bash setup/dns-route.sh 
sudo git pull
sudo nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml 
sudo bash setup/dns-route.sh 
sudo nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml 
sudo git pull
sudo bash setup/dns-route.sh 
sudo nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml 
sudo bash setup/dns-route.sh 
sudo nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml 
git stash
sudo git stash
sudo git pull
sudo bash setup/dns-route.sh 
sudo nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml 
sudo bash /mnt/HDD/Programs/reload_ctp-dns.sh
systemctl status ctp-dns
sudo crontab -e
systemctl status ctp-dns
sudo rm -rf /mnt/HDD/Programs/ctp-dns.service 
cd Pihole-Slave-Install/
sudo git pull
sudo bash setup/dns-route.sh 
sudo bash reload_ctp-dns.sh 
ls /etc/systemd/system/ctp-dns.service
sudo rm -rf /etc/systemd/system/ctp-dns.service
sudo bash reload_ctp-dns.sh 
sudo bash setup/new_server.sh 
sudo bash reload_ctp-dns.sh 
ls $PROG/ctp-dns.service
ls prog/ctp-dns.service 
ln -s ~/Pihole-Slave-Install/prog/ctp-dns.service $PROG/
sudo bash reload_ctp-dns.sh 
systemctl status ctp-dns
systemctl restart ctp-dns
sudo systemctl restart ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo su
sud osu
sudo su
cd Pihole-Slave-Install/
sudo git pull
sudo systemctl restart ctp-dns
systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
touch /var/cache/ctp-dns/b976be1f0298ecec514ac4c879fbadff689928e48af0a49fc2f05ff4e3a9e8ff
sudo touch /var/cache/ctp-dns/b976be1f0298ecec514ac4c879fbadff689928e48af0a49fc2f05ff4e3a9e8ff
tail -f /var/log/ctp-dns/*.log
sudo systemctl restart ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo touch /var/cache/ctp-dns/b976be1f0298ecec514ac4c879fbadff689928e48af0a49fc2f05ff4e3a9e8ff
sudo systemctl restart ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo touch /var/cache/ctp-dns/b976be1f0298ecec514ac4c879fbadff689928e48af0a49fc2f05ff4e3a9e8ff
sudo systemctl restart ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo systemctl restart ctp-dns
tail -f /var/log/ctp-dns/*.log
systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo touch /var/cache/ctp-dns/7213abfbe3a861b484d58dbb37852fedad000d42df45d86465442b765a48d25a
tail -f /var/log/ctp-dns/*.log
sudo git pull
tail -f /var/log/ctp-dns/*.log
systemctl status ctp-dns
systemctl status ctp-dnsqq
systemctl status ctp-dnsq
systemctl status ctp-dns
journalctl -xe
systemctl status ctp-dns
tail -f /var/log/health-check.log 
cd Pihole-Slave-Install/
sudo git pull
tail -f /var/log/health-check.log 
sudo git pull
tail -f /var/log/health-check.log 
sudo git pull
which grepip
curl -s -w '\n' "http://localhost/dns-query?name=www.google.com&type=A"
curl -s -w '\n' "http://localhost:8053/dns-query?name=www.google.com&type=A"
curl -s -H 'accept: application/dns-message' "https://dns.ctptech.dev/dns-query?dns=q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB"
curl -H 'accept: application/dns-message' "https://dns.ctptech.dev/dns-query?dns=q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB"
curl -H 'accept: application/dns-message' "https://dns.ctptech.dev/dns-query?dns=q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB" --ouput -
curl -H 'accept: application/dns-message' "https://dns.ctptech.dev/dns-query?dns=q80BAAABAAAAAAAAA3d3dwdleGFtcGxlA2NvbQAAAQAB" --output -
curl -s -w '\n' "http://localhost:8053/dns-query?name=www.google.com&type=A"
curl  --insecure -s -w '\n' "http://localhost:8053/dns-query?name=www.google.com&type=A"
sudo git pull
systemctl status ctp-dns
sudo nano /mnt/HDD/Programs/route-dns/route-dns.toml 
tail -f /var/log/health-check.log 
sudo git pull
cd Pihole-Slave-Install/
sudo git pull
source ~/.bashrc
sudo git pull
systemctl status ctp-dns
sudo systemctl restart ctp-dns
systemctl status ctp-dns
ls
sudo nano /mnt/HDD/Programs/route-dns/route-dns.toml 
sudo bash /mnt/HDD/Programs/copy_master_pihole_config.sh 
tail -f /var/log/health-check.log 
pihole -t
cd Pihole-Slave-Install/
ls
sudo bash /mnt/HDD/Programs/copy_master_pihole_config.sh 
mv /tmp/heath-check.sh $PROG/
sudo mv /tmp/heath-check.sh $PROG/
sudo git pull
ls
ifconfig
sudo nano /etc/pihole/setupVars.conf
systemctl status unbound
systemctl enable unbound
sudo systemctl enable unbound
sudo systemctl unmask unbound
ls /etc/unbound
sudo apt install unbound
sudo dpkg --configure -a
sudo rm -rf /var/lib/dpkg/updates/
sudo dpkg --configure -a
mkdir /var/lib/dpkg/updates/
sudo mkdir /var/lib/dpkg/updates/
sudo dpkg --configure -a
sudo apt install unbound
ls $unbound
ls /etc/unbound/root.hints 
nano /etc/unbound/root.hints 
sudo rm -rf  /etc/unbound/unbound.conf.d/*
sudo nano /mnt/HDD/Programs/Hourly.sh 
mkdir -p /var/cache/dnsmasq/
cd Pihole-Slave-Install/
pihole restartdns
gi
sudo git pull
sudo nano /mnt/HDD/Programs/Hourly.sh 
ps -aux | grep 'pm.stal\|test_' | awk '{print $2}' | xargs sudo kill -9
systemctl status ctp-dns
ps -aux | grep 'pm.stal\|test_' | awk '{print $2}' | xargs sudo kill -9
killall ps
sudo killall ps
sudo nano /mnt/HDD/Programs/Hourly.sh 
sudo killall awk ps grep pgrep
sudo nano /mnt/HDD/Programs/Hourly.sh 
sudo crontab -e
ps -aux | grep 'pm.stal\|test_' | awk '{print $2}' | xargs sudo kill -9
ps -aux | grep 'pm.stal\|test_' | awk '{print $2}' | xargs sudo kill -8
ps -aux | grep 'pm.stal\|test_' | awk '{print $2}' | xargs sudo kill -9
ps -aux | grep 'pm.stal\|test_\|pm.hea' | awk '{print $2}' | xargs sudo kill -9
ps -aux | grep 'pm.stal\|test_\|pm.hea' | grep -v 'grep' | awk '{print $2}' | xargs sudo kill -9
sudo nano /mnt/HDD/Programs/Hourly.sh 
htop
sudo crontab -e
sudo apt purge memcachd
sudo apt purge lxcfs memcached
sudo apt purge haproxy privproxy
sudo apt purge haproxy privoxy postfix dns2tcpd
htop
wget https://raw.githubusercontent.com/netdata/netdata/master/packaging/installer/netdata-uninstaller.sh
chmod +x ./netdata-uninstaller.sh
sudo apt purge haproxy privoxy postfix dns2tcp
htop
rm -rf /var/lib/haproxy/dev
sudo rm -rf /var/lib/haproxy/
./netdata-uninstaller.sh --yes --env 
sudo systemctl stop netdata
htop
sudo ./netdata-uninstaller.sh --yes --env 
systemctl disable netdata
sudo systemctl disable netdata
htop
systemctl status ctp-ds
systemctl status ctp-dns
sudo systemctl restart ctp-dns
systemctl status ctp-dns
htop
systemctl status unbound
sudo systemctl restart unbound
systemctl status unbound
dig @127.0.0.1 -p 5053
ls
ls $unbconf
ls /etc/unbound/unbound.conf.d/
cd Pihole-Slave-Install/
sudo git pull
sudo ./copy_config.sh 
ls
ls /etc/unbound/unbound.conf.d/
sudo systemctl restart unbound
sudo unbound-checkconf 
sudo nano /etc/unbound/unbound.conf.d/06-infosec.conf
sudo git pull && sudo ./copy_config.sh 
sudo git pull
ping google.com
sudo nano /etc/resolv.conf
systemctl disable unbound-resolvconf.service 
sudo systemctl disable unbound-resolvconf.service 
sudo git pull
sudo nano /etc/resolv.conf
sudo ./copy_config.sh 
sudo unbound-checkconf 
sudo nano /etc/unbound/unbound.conf.d/06-infosec.conf
sudo unbound-checkconf 
mkdir /etc/unbound/local.d/
sudo mkdir /etc/unbound/local.d/
sudo bash /mnt/HDD/Programs/update_ads.sh
sudo unbound-checkconf 
nano /etc/unbound/local.d/adblock.conf
sudo nano /etc/unbound/local.d/adblock.conf
sudo nano /etc/unbound/unbound.conf.d/adblock.conf
sudo unbound-checkconf 
sudo nano /etc/unbound/unbound.conf.d/adblock.conf
sudo rm -rf /etc/unbound/unbound.conf.d/adblock.conf
sudo unbound-checkconf 
sudo rm -rf /etc/unbound/unbound.conf.d/01-auth-rec-server.conf 
sudo unbound-checkconf 
sudo bash /mnt/HDD/Programs/update.unbound-config.sh
sudo git pull
systemctl mask unbound-resolvconf.service 
sudo systemctl mask unbound-resolvconf.service 
sudo nano /etc/resolv.conf
systemctl status resolvconf
sudo systemctl status resolvconf
sudo systemctl start  resolvconf
sudo systemctl status resolvconf
sudo unbound-checkconf 
sudo nano /mnt/HDD/Programs/update.unbound-config.sh
sudo git pull
sudo bash /mnt/HDD/Programs/update.unbound-config.sh
sudo unbound-checkconf 
ls /var/lib/unbound/
pihole -t
wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
nano /var/lib/unbound/root.hints
wget https://www.internic.net/domain/named.root -qO-
curl https://www.internic.net/domain/named.root
ping www.internic.net
sudo nano /etc/resolv.conf
sudo nano /etc/resolvconf/resolv.conf.d/head 
sudo nano /etc/resolvconf/resolv.conf.d/base 
sudo nano /etc/resolv.conf
systemctl restart resolvconf
sudo systemctl restart resolvconf
ping www.internic.net
curl https://www.internic.net/domain/named.root
wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
ping www.internic.net
nano /var/lib/unbound/root.hints
sudo unbound-checkconf 
systemctl mask unbound-resolvconf.service 
sudo systemctl restart unbound.service 
sudo systemctl status unbound.service 
 dig @127.0.0.1 -p 5053
sudo bash /mnt/HDD/Programs/copy_master_pihole_config.sh 
cd Pihole-Slave-Install/
sudo git pull
sudo nano /etc/resolv.conf
systemctl status resolvconf
sudo systemctl status resolvconf
sudo systemctl restart resolvconf
sudo systemctl status resolvconf
sudo nano /etc/resolv.conf
/sbin/resolvconf --enable-updates
sudo /sbin/resolvconf --enable-updates
sudo nano /etc/resolv.conf
/sbin/resolvconf --enable-updates --help
sudo /sbin/resolvconf --enable-updates 
nano /lib/systemd/system/resolvconf.service
systemctl status unbound-resolvconf.service 
sudo systemctl status resolvconf
sudo systemctl enable resolvconf
sudo systemctl status resolvconf
sudo nano /lib/systemd/system/resolvconf.service
sudo nano /etc/resolv.conf
systemd-resolve --status
sudo systemd-resolve --status
sudo systemd-resolve 
sudo systemd-resolve --status
sudo systemd-resolve restart
sudo systemd-resolve --help
sudo nano /etc/resolv.conf
sudo /sbin/resolvconf --enable-updates
sudo nano /etc/resolv.conf
systemctl status resolvconf
sudo systemctl restart resolvconf
systemctl status resolvconf
sudo /sbin/resolvconf --enable-updates 
sudo nano /etc/resolv.conf
echo 'nameserver 1.1.1.1' | sudo tee -a /etc/resolv.conf 
sudo nano $prog/nameservers_update.sh
sudo crontab -e
bash /home/ubuntuserver/Programs/nameservers_update.sh
sudo nano $prog/nameservers_update.sh
bash /home/ubuntuserver/Programs/nameservers_update.sh
sudo nano $prog/nameservers_update.sh
 dig @127.0.0.1 -p 5053
ls
sudo bash /mnt/HDD/Programs/copy_master_pihole_config.sh 
pihole restartdns
dig @127.0.0.1 -p 5053
pihole -t
systemctl status nginx
pihole -w www.ipdeny.com
curl -1sLf   'https://dl.cloudsmith.io/public/honeydb/honeydb-agent/setup.deb.sh'   | sudo -E bash
pihole -t
pihole restartdns
systemctl status pihole-FTL.service 
ls /etc/init.d/pihole-FTL 
sudo reboot 
systemctl status pihole-FTL.service 
pihole restartdns
sudo chown pihole:pihole /var/cache/dnsmasq/dnsmasq_dnssec_timestamp
pihole restartdns
pihole -t
pihole restartdns
pihole -t
systemctl status pihole-FTL.service 
pihole -t
pihole restartdns
pihole -t
history | grep gcp
history | grep gc
nano ~/reverse_ssh.sh 
     GCLOUD_ZONE="us-central1-a"
        GCLOUD_INSTANCE="ctp-vpn"
        GCLOUD_PROJECT="galvanic-pulsar-284521"
nano ~/reverse_ssh.sh 
gcloud beta compute ssh                         --zone "$GCLOUD_ZONE" "$GCLOUD_INSTANCE"                         --project "$GCLOUD_PROJECT" \
ssh gcp.ctptech.dev
ssh gcp.ctptech.dev -i ~/.ssh/id_rsa 
ssh gcp.ctptech.dev -i ~/.ssh/google_compute_engine 
history | grep gc
 gcloud compute instances stop --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"  && gcloud compute instances start  --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"
cd Pihole-Slave-Install/
sudo git pull
sudo git stash
sudo git pull
sudo crontab -e
sudo crontab | tee -a ee
sudo crontab -e
sudo git pull
 gcloud compute instances stop --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"  && gcloud compute instances start  --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"
bash $PROG/get_ext_ip.sh master.dns.ctptech.dev
sudo nano /etc/environment
nano /etc/environment
 gcloud compute instances stop --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"  && gcloud compute instances start  --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"
 gcloud compute instances stop --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"  && gcloud compute instances start  --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"
systemctl status ctp-dns
sudo systemctl restart ctp-dns
sudo nano /etc/cron.d/ubuntu-server-health_check 
sudo ./up
sudo ./update.sh 
dig @192.168.44.1
dig @192.168.44.2
dig @192.168.44.11
dig @192.168.44.1
sudo nano /etc/dnsmasq.d/88-custom-dns-servers.conf 
sudo nano /etc/dnsmasq.d/11-local-servers.conf 
sudo rm /etc/dnsmasq.d/11-local-servers.conf 
sudo rm /etc/dnsmasq.d/05-addint.conf 
sudo nano /etc/dnsmasq.d/05-addint.conf 
ifconfig
sudo nano /etc/dnsmasq.d/05-addint.conf 
sudo nano /etc/dnsmasq.d/12-records.conf 
sudo nano /etc/dnsmasq.d/99-custom-settings.conf 
sudo nano /etc/dnsmasq.d/13-perf.conf 
systemctl status ctp-dns
systemctl restart ctp-dns
sudo systemctl restart ctp-dns
systemctl restart ctp-dns
systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
sud ogit pull
sudo git pull
sudo nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml
sudo git pull && /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
sudo git stash && sudo git pull && /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
sudo nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml
systemctl restart ctp-dns
sudo systemctl restart ctp-dns
systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo systemctl restart ctp-dns
systemctl status ctp-dns
sudo systemctl restart ctp-dns
sudo git stash && sudo git pull && /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
sudo systemctl restart ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo git pull
sudo git stash && sudo git pull && /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
sudo systemctl restart ctp-dns
sudo nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml
sudo git stash && sudo git pull && /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
sudo systemctl restart ctp-dns
tail -f /var/log/ctp-dns/*.log
systemctl status ctp-dns
 systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo systemctl restart ctp-dns
 systemctl status ctp-dns
tail -f /var/log/pm.health-check.log 
sudo git stash && sudo git pull && /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
sudo bash setup/cron.sh 
systemctl status ctp-dns
htop
systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
tail -f /var/log/pm.health-check.log 
sudo git pull
bash $PROG/get_ext_ip.sh --current-ip
dig +short myip.opendns.com @resolver1.opendns.com
tail -f /var/log/pm.health-check.log 
sudo nano /mnt/HDD/Programs/test_doh.sh
HOST=dns.ctptech.dev
QUERY=www.google.com
doh -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
doh_remote_ctp=`timeout $TIMEOUT doh -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"`
TIMEOUT=8
TRIES=2
doh_remote_ctp=`timeout $TIMEOUT doh -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"`
echo "$doh_remote_ctp" | grepip --ipv4 -o
doh_remote_ctp=`timeout $TIMEOUT doh -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"`
echo "$doh_remote_ctp" | grepip --ipv4 -o
nano /mnt/HDD/Programs/test_doh.sh
doh_remote_ctp=`timeout $TIMEOUT doh -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST/dns-query"`
sudo nano /mnt/HDD/Programs/test_doh.sh
doh_remote_ctp=`timeout $TIMEOUT doh -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST/dns-query"`
echo "$doh_remote_ctp" | grepip --ipv4 -o
doh_remote_ctp=`timeout $TIMEOUT doh -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"`
echo "$doh_remote_ctp" | grepip --ipv4 -o
doh_remote_ctp=`timeout $TIMEOUT doh -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"`
doh_remote_ctp=`timeout $TIMEOUT doh -r"$HOST:4443:$EXTENRAL_IP" -tA $QUERY "https://$HOST:4443/dns-query"`
systemctl status ngin
systemctl status nginx
systemctl status ctp-dns
doh_remote_ctp=`timeout $TIMEOUT doh -r"$HOST:4443:$EXTENRAL_IP" -tA $QUERY "https://$HOST:4443/dns-query"`
systemctl status ctp-dns
doh_remote_ctp=`timeout $TIMEOUT doh -r"$HOST:4443:$EXTENRAL_IP" -tA $QUERY "https://$HOST:4443/dns-query"`
doh --help
doh_remote_ctp=`timeout $TIMEOUT doh -v -r"$HOST:4443:$EXTENRAL_IP" -tA $QUERY "https://$HOST:4443/dns-query"`
EXTENRAL_IP=`bash $PROG/get_ext_ip.sh --current-ip`
doh_remote_ctp=`timeout $TIMEOUT doh -v -r"$HOST:4443:$EXTENRAL_IP" -tA $QUERY "https://$HOST:4443/dns-query"`
timeout $TIMEOUT doh -v -r"$HOST:4443:$EXTENRAL_IP" -tA $QUERY "https://$HOST:4443/dns-query"
timeout $TIMEOUT doh -v -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
doh
timeout $TIMEOUT doh -vT -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
timeout $TIMEOUT doh -v -T -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
timeout $TIMEOUT doh  -T -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
timeout $TIMEOUT doh   -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
timeout $TIMEOUT doh --help   -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
timeout $TIMEOUT doh -4   -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
doh --help
systemctl status ctp-dns
sudo bash /mnt/HDD/Programs/test_dot.sh --mo
sudo git pull
sudo bash /mnt/HDD/Programs/test_dot.sh --mo
sudo git pull
sudo git pull -ff
sudo git stash
sudo git pull -ff
sudo bash setup/dns-route.sh
history | grep git
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
nano /mnt/HDD/Programs/route-dns/route-dns.toml 
nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml
bash $PROG/csvify.sh `grep -E "^.resolvers\..*gcp.*" $ROUTE/slave-resolvers.toml | awk -F'.' '{print $2}' | awk -F']' '{print $1}'` --quotes
ROUTE=$PROG/route-dns
bash $PROG/csvify.sh `grep -E "^.resolvers\..*gcp.*" $ROUTE/slave-resolvers.toml | awk -F'.' '{print $2}' | awk -F']' '{print $1}'` --quotes
grep -E "^.resolvers\..*gcp.*" $ROUTE/slave-resolvers.toml | awk -F'.' '{print $2}' | awk -F']' '{print $1}'
grep -E "^.resolvers\..*gcp.*" $ROUTE/slave-resolvers.toml | awk -F'.' '{print $2}' 
grep -E ".resolvers\..*gcp.*" $ROUTE/slave-resolvers.toml | awk -F'.' '{print $2}' 
ls /mnt/HDD/Programs/route-dns
grep -E ".resolvers\..*gcp.*" /mnt/HDD/Programs/route-dns/slave-resolvers.toml | awk -F'.' '{print $2}' 
grep -E ".resolvers\..*gcp.*" /mnt/HDD/Programs/route-dns/slave-resolvers.toml 
grep -E "^.resolvers\..*gcp.*" /mnt/HDD/Programs/route-dns/slave-resolvers.toml 
nano  /mnt/HDD/Programs/route-dns/slave-resolvers.toml 
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
echo "ctp-dns-master-gcp-tcp","ctp-dns-master-gcp-udp","ctp-dns-master-gcp-dot","ctp-dns-master-gcp-quic","ctp-dns-master-doh-gcp-post","ctp-dns-master-doh-gcp-get","ctp-dns-master-doh-gcp-quic","| rev | cut -d ',' -f 2- | rev 
echo '"ctp-dns-master-gcp-tcp","ctp-dns-master-gcp-udp","ctp-dns-master-gcp-dot","ctp-dns-master-gcp-quic","ctp-dns-master-doh-gcp-post","ctp-dns-master-doh-gcp-get","ctp-dns-master-doh-gcp-quic","'| rev | cut -d ',' -f 2- | rev 
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
echo ""ctp-dns-local-master-udp", "ctp-dns-master-gcp-tcp","ctp-dns-master-gcp-udp","ctp-dns-master-gcp-dot","ctp-dns-master-gcp-quic","ctp-dns-master-doh-gcp-post","ctp-dns-master-doh-gcp-get","ctp-dns-master-doh-gcp-quic",""
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
echo "'ctp-dns-master-gcp-tcp','ctp-dns-master-gcp-udp','ctp-dns-master-gcp-dot','ctp-dns-master-gcp-quic','ctp-dns-master-doh-gcp-post','ctp-dns-master-doh-gcp-get','ctp-dns-master-doh-gcp-quic','" | rev | cut -d ',' -f 2- | rev 
echo "'ctp-dns-master-gcp-tcp','ctp-dns-master-gcp-udp','ctp-dns-master-gcp-dot','ctp-dns-master-gcp-quic','ctp-dns-master-doh-gcp-post','ctp-dns-master-doh-gcp-get','ctp-dns-master-doh-gcp-quic','" | rev | cut -d ',' -f 3- | rev 
echo "'ctp-dns-master-gcp-tcp','ctp-dns-master-gcp-udp','ctp-dns-master-gcp-dot','ctp-dns-master-gcp-quic','ctp-dns-master-doh-gcp-post','ctp-dns-master-doh-gcp-get','ctp-dns-master-doh-gcp-quic','" | rev | cut -d ',' -f 1- | rev 
echo "'ctp-dns-master-gcp-tcp','ctp-dns-master-gcp-udp','ctp-dns-master-gcp-dot','ctp-dns-master-gcp-quic','ctp-dns-master-doh-gcp-post','ctp-dns-master-doh-gcp-get','ctp-dns-master-doh-gcp-quic','" | rev | cut -d ',' -f 2- | rev 
echo "'ctp-dns-master-gcp-tcp','ctp-dns-master-gcp-udp','ctp-dns-master-gcp-dot','ctp-dns-master-gcp-quic','ctp-dns-master-doh-gcp-post','ctp-dns-master-doh-gcp-get','ctp-dns-master-doh-gcp-quic','" | rev | cut -d ',' -f 2-1 | rev 
echo "'ctp-dns-master-gcp-tcp','ctp-dns-master-gcp-udp','ctp-dns-master-gcp-dot','ctp-dns-master-gcp-quic','ctp-dns-master-doh-gcp-post','ctp-dns-master-doh-gcp-get','ctp-dns-master-doh-gcp-quic','" | rev | cut -d ',' -f -2 | rev 
echo "'ctp-dns-master-gcp-tcp','ctp-dns-master-gcp-udp','ctp-dns-master-gcp-dot','ctp-dns-master-gcp-quic','ctp-dns-master-doh-gcp-post','ctp-dns-master-doh-gcp-get','ctp-dns-master-doh-gcp-quic','" | rev | cut -d ',' -f -1 | rev 
echo "'ctp-dns-master-gcp-tcp','ctp-dns-master-gcp-udp','ctp-dns-master-gcp-dot','ctp-dns-master-gcp-quic','ctp-dns-master-doh-gcp-post','ctp-dns-master-doh-gcp-get','ctp-dns-master-doh-gcp-quic','" | rev | cut -d ',' -f 1- | rev 
echo "'ctp-dns-master-gcp-tcp','ctp-dns-master-gcp-udp','ctp-dns-master-gcp-dot','ctp-dns-master-gcp-quic','ctp-dns-master-doh-gcp-post','ctp-dns-master-doh-gcp-get','ctp-dns-master-doh-gcp-quic','" | rev | cut -d ',' -f 2- | rev 
sudo nano /mnt/HDD/Programs/csvify.sh
REGEX_EXCLUDE"'ctp-dns-master-gcp-tcp','ctp-dns-master-gcp-udp','ctp-dns-master-gcp-dot','ctp-dns-master-gcp-quic','ctp-dns-master-doh-gcp-post','ctp-dns-master-doh-gcp-get','ctp-dns-master-doh-gcp-quic','"
REGEX_EXCLUDE="'ctp-dns-master-gcp-tcp','ctp-dns-master-gcp-udp','ctp-dns-master-gcp-dot','ctp-dns-master-gcp-quic','ctp-dns-master-doh-gcp-post','ctp-dns-master-doh-gcp-get','ctp-dns-master-doh-gcp-quic','"
echo "${REGEX_EXCLUDE}" | rev | cut -d ',' -f 2- | rev 
REGEX_EXCLUDE="$( echo "${REGEX_EXCLUDE}" | rev | cut -d ',' -f 2- | rev )"
 REGEX_EXCLUDE="\"${REGEX_EXCLUDE}"
echo $REGEX_EXCLUDE
echo "$REGEX_EXCLUDE" | awk -F-- '{print $1}'
sudo git pull
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
bash $PROG/csvify.sh `grep -E "^.resolvers\..*gcp.*" $ROUTE/slave-resolvers.toml | awk -F'.' '{print $2}' | awk -F']' '{print $1}'` --quotes
tail -f /var/log/pm.health-check.log 
cd Pihole-Slave-Install/
sudo git pull
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
systemctl restart ctp-dns
sudo systemctl restart ctp-dns
sudo systemctl statusctp-dns
sudo systemctl status ctp-dns
sudo bash /mnt/HDD/Programs/test_dot.sh --mo
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
sudo bash /mnt/HDD/Programs/test_dot.sh --mo
tail -f /var/log/ctp-dns/*.log
sudo su
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh
sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
sudo git pull && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
systemctl status  ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo crontab -e
which sleep
sudo git pull && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
journalctl -xe
sudo git pull && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
journalctl -xe
sudo git pull && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
journalctl -xe
sudo git pull && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
htop
ls 
ls /etc/letsencrypt/live/
sudo ls /etc/letsencrypt/live/
sudo ls /etc/letsencrypt/live/
sudo ls /etc/letsencrypt/live/vpn.ctptech.dev
sudo bash prog/copy_certs.sh 
systemct status ctp-dns
systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
ls
cat /mnt/HDD/Programs/route-dns/*.toml | grep master.ctptech.dev
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml
systemctl status ctp-dns
sud ogit pull
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
sud ogit stash 
sudo git stash 
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
git add .
ls
rm -rf fullchain.crt 
rm -rf ee
sudo nano /mnt/HDD/Programs/route-dns/slave-resolvers.toml
pihole status
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
systemctl status ctp-dns
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
systemctl status ctp-dns
sudo bash /mnt/HDD/Programs/test_dot.sh --mo
systemctl status ctp-dns
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh && sudo systemctl daemon-reload 
sudo bash /mnt/HDD/Programs/test_dot.sh --mo
pihole -w gtq6.sct.sc-prod.net
pihole -w internal-api.snapkit.com
tail -f /var/log/ctp-dns/*.log
tail -f /var/log/pm.health-check.log 
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
tail -f /var/log/pm.health-check.log 
systemctl status ctp-dns
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
sudo nano /mnt/HDD/Programs/test_dot.sh
 kdig -d @gcp.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev cf-st.sc-cdn.net +timeout=4 +dnssec +edns
 kdig -d @dns.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev cf-st.sc-cdn.net +timeout=4 +dnssec +edns
 kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev cf-st.sc-cdn.net +timeout=4 +dnssec +edns
grep block /var/log/ctp-dns/*.log
grep "matched blocklist" /var/log/ctp-dns/*.log
sudo git pull
sudo git stash && sudo git pull && sudo /home/ubuntuserver/Pihole-Slave-Install/setup/dns-route.sh && sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
 kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev cf-st.sc-cdn.net +timeout=4 +dnssec +edns
 kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev sc-cdn.net +timeout=4 +dnssec +edns
grep "matched blocklist" /var/log/ctp-dns/*.log
systemctl status ctp-dns
sudo git pull
systemctl status ctp-dns
sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
which ln
sudo nano /etc/environment
sudo ./update.sh 
sudo git stash
sudo ./update.sh 
git rm --cached prog/route-dns/lists/lists
sudo git rm --cached prog/route-dns/lists
sudo git rm -r --cached prog/route-dns/lists
sudo ./update.sh 
sudo git pull
sudo nano /mnt/HDD/Programs/route-dns/route-dns.toml 
sudo git pull
sudo  git pull --ff --force    --autostash  --rebase origin master
sudo git pull
sudo  git pull --ff --force    --autostash  --rebase origin master 
| --abort | --skip)
git rebase --continue 
sudo git rebase --continue 
sudo git rebase --continue  origin master 
sudo git rebase --continue   master 
sudo git rebase --continue  origin  master 
sudo git rebase --continue  origin  
sudo git rebase --continue
sudo git rebase --continue origin
sudo git rebase --continue master
git pull
sudo git pull
git rm -rf prog/route-dns/lists/lists
sudo git rm -rf prog/route-dns/lists/lists
sudo rm -rf prog/route-dns/lists/lists
sudo git pull
sudo ./update.sh 
sudo nano /etc/environment
sudo git rebase --continue mastersudo systemctl daemon-reload && sudo systemctl restart ctp-dns
sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
systemctl status ctp-dns
sudo ./update.sh 
cho ${ROUTE_LIST}
echo ${ROUTE_LIST}
sudo nano /etc/environment
cd Pihole-Slave-Install/
sudo git pull
systemctl status ctp-dns
sudo ./update.sh  --master
sudo git pull
sudo systemctl daemon-reload && sudo systemctl restart ctp-dns
systemctl status ctp-dns
systemctl status ctp-dnsq
systemctl status ctp-dns
tail -f /var/log/pm.health-check.log 
sudo git pull
sudo ./update.sh --master
sudo git pull
sudo ./copy_config.sh 
sudo git pull
EXTENRAL_IP=`bash $PROG/get_ext_ip.sh --current-ip`
HOST=dns.ctptech.dev
QUERY=www.google.com
TIMEOUT=8
TRIES=2
EXTENRAL_IP=`bash $PROG/get_ext_ip.sh --current-ip`
bash $PROG/get_ext_ip.sh --current-ip
doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
doh  -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
systemtl status ctp-dns
systemtl  status ctp-dns
systemctl   status ctp-dns
doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
systemctl status ctp-dns | grep -oE '(de|)activating'
doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query" | grepip --ipv4 -o
timeout $TIMEOUT doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query" | grepip --ipv4 -o
doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
sudo git pull
doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"`
doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
systemctl status ctp-dns | grep -oE '(de|)activating'
systemctl status ctp-dns 
tail -f /var/log/pm.health-check.log 
kdig @ctp-vpn.local $isAuto +tls-host=$HOST $QUERY $DOT_ARGS
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
+timeout
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo git pull
systemctl status ctp-dns 
tail -f /var/log/pm.health-check.log 
sudo ./apply_config.sh 
tail -f /var/log/pm.health-check.log 
sudo nginx -t
sudo nginx -t
sudo git pull && sudo ./apply_config.sh 
systemctl status ctp-dns 
cd Pihole-Slave-Install/
sudo git pull
exit
sudo git pull
tail -f /var/log/pm.health-check.log 
htop
sudo nano /etc/default/grub 
sudo grub-install 
sudo update-grub2
cd Pihole-Slave-Install/
sudo git pull
ls /var/log/ctp-dns
systemctl status ctp-dns
 grep -i "matched blocklist" /var/log/ctp-dns/*.log
sudo git pulll
sudo git pull
systemctl status ctp-dns
sudo git pull
sudo bash setup/cron.sh 
systemctl status ctp-dns
sudo bash /home/ubuntuserver/Programs/route-dns/ctp-dns.sh --qbl
sudo bash /home/ubuntuserver/Programs/route-dns/ctp-dns.sh -qbl
sudo git pull
 grep -i "matched blocklist" /var/log/ctp-dns/*.log
systemctl restart ctp-dns
sudo systemctl restart ctp-dns
 grep -i "matched blocklist" /var/log/ctp-dns/*.log
sudo bash /home/ubuntuserver/Programs/route-dns/ctp-dns.sh -qbl
sudo git pull
sudo ln -s $ROUTE/ctp-dns.sh /usr/local/bin
 grep -i "matched blocklist" /var/log/ctp-dns/*.log
ctp-dns.sh
chmod 777 ctp-dns.sh
sudo git pull
sudo bash setup/dns-route.sh
sudo git pull
sudo bash setup/
sudo bash setup/dns-route.sh
sudo git pull && sudo bash setup/dns-route.sh
systemctl status nginc
systemctl status nginx
sudo git pull
sudo bash setup/cron.sh 
cgexec -g cpu:cpulimited 
systemctl status ctp-dns
sudo systemctl restart ctp-dns
systemctl status ctp-dns
cd Pihole-Slave-Install/
sudo git pull
tail -f /var/log/pm.health-check.log 
doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
HOST=dns.ctptech.dev
QUERY=www.google.com
TIMEOUT=15
TRIES=5
doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
sudo git pull
htop
doh -4 -r$HOST:4443:$EXTENRAL_IP -tA $QUERY "https://$HOST:4443/dns-query"
tail -f /var/log/pm.health-check.log 
sudo git pull
sudo nano /mnt/HDD/Programs/test_dot.sh 
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo fail2ban-client status pihole-dns
sudo fail2ban-client status ctp-dns
sudo fail2ban-client status pihole-dns-1-block
sudo fail2ban-client status ctp-dns-1-block
ls /etc/fail2ban/jail.d/
ls /etc/fail2ban/filter.d/ctp-dns-1-block.conf 
sudo fail2ban-client status ctp-dns-1-block
systemctl status fail2ban.service 
sudo fail2ban-client status ctp-dns-1-block
sudo fail2ban-client start ctp-dns-1-block
sudo fail2ban-client start ctp-dns
sudo fail2ban-client status ctp-dns-1-block
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo nano /home/ubuntuserver/Programs/route-dns/slave-listeners.toml 
sudo nano /home/ubuntuserver/Programs/route-dns/slave-resolvers.toml
systemctl status ctp-dns
ystemctl status ctp-dns
htop
systemctl status ctp-dns
sudo systemctl enable ctp-dns
cd Pihole-Slave-Install/
sudo git pull
sudo git pull
systemctl status ctp-dns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
tail -f /var/log/ctp-dns/*.log
sudo bash setup/dns-route.sh
tail -f /var/log/ctp-dns/*.log
which test
sudo git pull && sudo systemctl daemon-reload  && sudo systemctl restart ctp-dns.service
tail -f /var/log/ctp-dns/*.log
sudo git pull && sudo systemctl daemon-reload  && sudo systemctl restart ctp-dns.service
tail -f /var/log/ctp-dns/*.log
ls /var/tmp/ctp-dns/lists
ll /var/tmp/ctp-dns/lists
rm -rf  /var/tmp/ctp-dns/lists
sudo rm -rf  /var/tmp/ctp-dns/lists
tail -f /var/log/ctp-dns/*.log
sudo git pull && sudo systemctl daemon-reload  && sudo systemctl restart ctp-dns.service
tail -f /var/log/ctp-dns/*.log
ls '/var/tmp/ctp-dns/lists
ls /var/tmp/ctp-dns/lists
ls $R_LIST 
ls /var/tmp/ctp-dns/lists
sudo git pull && sudo systemctl daemon-reload  && sudo systemctl restart ctp-dns.service
tail -f /var/log/ctp-dns/*.log
sudo git pull && sudo systemctl daemon-reload  && sudo systemctl restart ctp-dns.service
tail -f /var/log/ctp-dns/*.log
ls /var/tmp/ctp-dns/lists
ls /var/tmp/ctp-dns/
ls /var/tmp/ctp-dns/lists
/var/tmp/ctp-dns/lists
ls /var/tmp/ctp-dns/lists
cd ..
cd ~/Pihole-Slave-Install/
tail -f /var/log/ctp-dns/*.log
 sudo git pull
source ~/.bashrc
cd Pihole-Slave-Install/
sudo git pull
sudo git stash
sudo git pull
sudo bash /mnt/HDD/Programs/dns-route.sh 
sudo bash setup/dns-route.sh
sudo ./copy_config.sh 
systemctl status ctp-dns
sudo systemctl daemon-reload
sudo git pull
sudo bash setup/dns-route.sh
sudo git pull
gut stash
sudo git stash
gut stash
sudo git pull
sudo bash setup/dns-route.sh
sudo git pull
udo systemctl status ctp-dns
sudo systemctl status ctp-dns
sudo git pull
sudo systemctl status ctp-dns
ping 35.232.120.211
sudo git pull
sudo ./apply_config.sh --no-restart
ls /opt
sudo nano /opt/phoneone.sh 
sudo nano /mnt/HDD/SLACK/slack-bash-bot/
sudo nano /mnt/HDD/SLACK/slack-bash-bot/bot.sh
sudo nano .gitignore
ls /mnt/HDD/Programs/phoneone.sh
nano /mnt/HDD/Programs/phoneone.sh
sudo nano .gitignore
git add .
sudo igt add .
sudo git add .
git init
sudo git push
git push -ff
sudo nano .gitignore
ls
sudo nano .gitignore
cd $prog/
nano ~/.gitignore
ls
git add .
git commit -m "Updated"
sudo git commit -m "Updated"
sudo git add .
df -h
sudo git init
sudo git add .
sudo git rebase
sudo git rebase --force
sudo git add .
ls 4393116
nano .gitignore 
sudo git add .
nano .gitignore 
sudo git add .
nano .gitignore 
sudo git add .
nano .gitignore 
sudo git add .
ls
sudo git add .
rm -rf error,
sudo mv error,/ ~/
sudo git add .
nano .gitignore 
sudo git add .
nano .gitignore 
sudo git add .
unlink iptables/Kali-Linux-on-Ubuntu/
ls iptables/Kali-Linux-on-Ubuntu/
ls iptables
ls iptables/Kali-Linux-on-Ubuntu/
iptables
iptables/
ls
rm -rf Kali-Linux-on-Ubuntu/
sudo rm -rf Kali-Linux-on-Ubuntu/
cd ..
ls
rm -rf /mnt/HDD/Programs/GitBSLR\:/GitBSLR\:/
sudo rm -rf /mnt/HDD/Programs/GitBSLR\:/GitBSLR\:/
ls
sudo rm -rf absolute/absolute/
sudo rm -rf absolute/error,/
sudo rm -rf 4393116/4393116/
sudo rm -rf Embedded-Systems---Wifi-scanner/error,/
sudo rm -rf Embedded-Systems---Wifi-scanner/Embedded-Systems---Wifi-scanner/
ls
sudo git add .
sudo rm -rf iptables/iptables
sudo git add .
sudo rm -rf iptables/responceoversms/
sudo git add .
sudo rm -rf path/path/
sudo rm -rf path/
sudo git add . 
sudo rm -rf responceoversms/responceoversms/
sudo git add . 
sudo rm -rf responceoversms/server/
sudo git add . 
sudo rm -rf server/server/
sudo git add . 
sudo git server/terminals-are-sexy/
sudo rm  server/terminals-are-sexy/
sudo rm -rf  server/terminals-are-sexy/
sudo git add . 
sudo rm -rf  unexpected/unexpected/
sudo git add . 
sudo git commit -m "Fixed errors"
git push
sudo git push -ff
cd ..
.
..
ls
cd ~/Pihole-Slave-Install/
ls
tail -f /var/log/pm.health-check.log 
sudo git pull
ls /mnt/HDD/Programs/dns-route.sh
sudo bash setup/dns-route.sh
bash /mnt/HDD/Programs/dns-route.sh
sudo nano /mnt/HDD/Programs/dns-route.sh
nano /mnt/HDD/Programs/dns-route.sh
rm -rf /mnt/HDD/Programs/dns-route.sh
cd setup/
SCRIPT_DIR=`realpath .`
ln -s $SCRIPT_DIR/dns-route.sh $PROG/
sudo bash setup/dns-route.sh
bash setup/dns-route.sh
bash /mnt/HDD/Programs/dns-route.sh
history | grep start
gcloud compute instances stop --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"  && gcloud compute instances start  --zone "us-central1-a" "ctp-vpn" --project "galvanic-pulsar-284521"
ping 35.232.120.211 
sudo nano /usr/local/bin/
sudo nano /usr/local/bin/cred.sh
sudo nano setup/dns-route.sh
sudo nano /usr/local/bin/cred.sh
sudo nano /usr/local/sbin/cred.sh
sudo nano /usr/bin/cred.sh 
sudo git pull
tail -f /var/log/pm.health-check.log 
cd ..
sudo git pull
sudo bash ./apply_config.sh 
systemctl unmask unbound
sudo git pull
sudo systemctl unmask unbound
sudo systemctl enable unbound
sudo systemctl start unbound
pihole -t
cd Pihole-Slave-Install/
sudo git pull && sudo ./apply_config.sh 
sudo git stash && sudo git pull && sudo ./apply_config.sh 
sudo ./update.sh 
systectl enable unbound
systemctl enable unbound
pihole restartdns
pihole -t
pihole restartdns
cd Pihole-Slave-Install/
sudo ./update.sh 
sudo git pull
sudo systemctl unmask unbound
htop
sudo git pull
sudo su
systemctl status ctp-dns.service
ctp-dns.sh -qbl
ctp-dns.sh -qal
sudo git pull
cd Pihole-Slave-Install/
sudo git pull
systemctl status ctp-dns
sudo git pull
tail -f /var/log/ctp-dns/*.log
sudo bash setup/dns-route.sh
cd Pihole-Slave-Install/[A
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo git pull
tail -f /var/log/ctp-dns/*.log
systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
systemctl status ctp-dns
sudo git pull
systemctl status ctp-dns
sudo systemctl restart ctp-dns
systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo git pull
sudo systemctl restart ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo systemctl restart ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo git pull
tail -f /var/log/pm.health-check.log 
ps -aux | grep pm
killall pm
tail -f /var/log/pm.health-check.log 
sudo nano /mnt/HDD/Programs/Hourly.sh 
sudo git pull
sudo bash setup/dns-route.sh
sudo git pull
sudo systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo bash setup/dns-route.sh
g
sudo git pull
tail -f /var/log/pm.health-check.log 
systectl status ctp-dns
systemctl status ctp-dns
tail -f /var/log/pm.health-check.log 
sudo nano /mnt/HDD/Programs/test_doq.sh
        LATEST_VERSION=`curl --silent "https://api.github.com/repos/natesales/q/tags" | jq -r '.[0].name'`
        echo $LATEST_VERSION
        RELEASE=`echo $LATEST_VERSION | awk -Fv '{print $2}'`
        REST_FILE=_linux_amd64.deb
        VP=q_$RELEASE$REST_FILE
#       wget https://github.com/natesales/q/releases/latest/download/$LATEST_VERSION/$VP -O ~/$VP
        wget https://github.com/natesales/q/releases/latest/download/$VP -O ~/$VP
        dpkg -i ~/$VP   dpkg -i ~/$VP
sudo        dpkg -i ~/$VP   dpkg -i ~/$VP
sudo        dpkg -i ~/$VP   
systemctl status ctp-dns
sudo ./update.sh 
tail -f /var/log/pm.health-check.log 
htop
sudo git pull
htop
cd Pihole-Slave-Install/
pihole -t
sudo git pull
sudo ./update.sh 
htop
sudo apt-get install libblas-dev liblapack-dev libatlas-base-dev gfortran
systemctl stop ctp-dns
sudo systemctl stop ctp-dns
sudo systemctl stop docker.socket
systemctl stop ctp-dns
htop
sudo crontab -e
sudo systemctl stop ctp-dns
sudo nano /etc/cron.d/ubuntu-server-health_check*
sudo systemctl stop ctp-dns
htop
systemctl stop nginx
sudo apt-get install libblas-dev liblapack-dev libatlas-base-dev gfortran python3-matplotlib python3-scipy
sudo systemctl stop nginx
htop
sudo systemctl stop ctp-dns
sudo crontab -e
ifconfig
ls
pip3 install jupyter-notebook
sudo apt install python3-pip python3-dev
htop
killall routedns 
sudo killall routedns 
pip3 install jupyterlab
sudo pip3 install jupyterlab
sudo crontab -e
systemctl mask ctp-dns
sudo systemctl mask ctp-dns
pip3 install jupyterlab --user
pip install --force-reinstall virtualenv
cd Identify_Customer_Segments/
ls
pip3 -m virtualenv env/bin/activate
pip3 install --force-reinstall virtualenv
'/home/ubuntuserver/.local/bin/virtualenv env/bin/activate
/home/ubuntuserver/.local/bin/virtualenv env/bin/activate
pip3 uninstall  launchpadlib
source env/bin/activate
source env/bin/activate/
source env/bin/activate/bin/
rm -rf env
/home/ubuntuserver/.local/bin/virtualenv env
source env/bin/activate
sudo /home/ubuntuserver/.local/bin/virtualenv env
sudo python3 -m /home/ubuntuserver/.local/bin/virtualenv env
sudo python3 -m virtualenv env
sudo pip3 uninstall  launchpadlib
virtualenv my_project_env
htop
sudo -H pip3 install virtualenv
killall routedns
sudo killall routedns
sudo systemctl mask ctp-dns
cd Identify_Customer_Segments/
virtualenv my_project_env
sudo virtualenv my_project_env
virtualenv my_project_env
which virtualenv 
/usr/local/bin/virtualenv virtualenv 
/usr/local/bin/virtualenv my_project_env
sudo apt install python3-virtualenv
python3 -m venv my_env
sudo 
sudo  python3 -m venv my_env
source my_env/bin/activate
pip install jupyter
pip install jupyter --user
chown $USER:$USER /home/ubuntuserver/Identify_Customer_Segments/
chown $USER:$USER -R /home/ubuntuserver/Identify_Customer_Segments/
sudo chown $USER:$USER -R /home/ubuntuserver/Identify_Customer_Segments/
pip install jupyter
jupyter notebook
jupyter notebook  Identify_Customer_Segments.ipynb --ip 192.168.44.250
killall routedns
htop
ps aux | grep toGithub
ps aux | grep toGithub | awk '{print $2}'
ps aux | grep toGithub | awk '{print $2}' | xargs sudo kill -9
sudo apt  install jupyter-core
jupyter notebook  Identify_Customer_Segments.ipynb --ip 192.168.44.250
jupyter  Identify_Customer_Segments.ipynb --ip 192.168.44.250
python3 -m install jupyter
python3 -m  jupyter
python3 -m  pip3 install jupyter
htop
sudo crontab -e
python3 -m  pip install jupyter
systemctl stop nginx
sudo systemctl stop nginx
htop
sudo crontab -e
htop
ps -aux | grep Weekly|set_
ps -aux | grep 'Weekly\|set_'
ps -aux | grep 'Weekly\|set_|Daily'
ps -aux | grep 'Weekly\|set_||Daily' 
ps -aux | grep 'Weekly\|set_\|Daily' 
ps -aux | grep 'Weekly\|set_\|Daily'  | awk '{print $2}' | xargs sudo kill
sudo crontab -e
source my_env/bin/activate
pandas seaborn pycocotools scipy  scikit-learn==0.19.2  matplotlib
pip ininstall pandas seaborn pycocotools scipy  scikit-learn==0.19.2  matplotlib
htop
systemctl stop fail2ban
sudo systemctl stop fail2ban
htop
journalctl --help
journalctl  --vacuum-size=100M
sudo journalctl  --vacuum-size=100M
sudo journalctl  --vacuum-size=50M
htop
pip install pandas seaborn pycocotools scipy  scikit-learn==0.19.2  matplotlib
pip install wheel
q
htop
sudo git pull
 \-#\-
sudo ./copy_config.sh 
cd Pihole-Slave-Install/
ls
ifconfig
htop
systemctl stop doh-server.service 
sudo systemctl stop doh-server.service 
sudo systemctl stop containerd.service 
htop
pihole status
dig github.com
htop
ls /var/tmp
df -h
ls
htop
sudo git pull
sudo ./copy_config.sh 
dig @35.35.35.35
ping 35.35.35.35
dig @34.72.149.182
sudo git pull
htop
sudo git pull
htop
killall find
sudo killall find
htop
killall updatedb.mlocate 
sudo killall updatedb.mlocate 
htop
sudo git pull
htop
pls
ls
ls env/
ls env/lib/
ls env/lib/python3.8/site-packages/
ls env/bin
ls my_env/
rm -rf env
ls my_env/bin
ls my_env/lib
ls my_env/lib/python3.8/site-packages/
ls my_env/
ls my_env/include/
htop
a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2a]2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
 ~0#~0
a~0a~0a~0a~0a~0a~0a~0a~0a~0a~0a~0a~0a~0a~0a~0a~0a~0a~0a~0
htop
ls /usr/local/bin/cred.sh
ls /usr/local/sbin/cred.sh
source cred.sh
htop
cd Pihole-Slave-Install/
sudo git pull
jupyter notebook  Identify_Customer_Segments.ipynb --ip 192.168.44.250
sudo nano /etc/cron.d/ubuntu-server-health_check*
systemctl start ctp-dns
sudo systemctl start ctp-dns nginx doh-server 
sudo systemctl daemon-reload && sudo systemctl start ctp-dns nginx doh-server 
systemctl status ctp-dns
ifconfig
tail -f /var/log/pm.health-check.log 
exit
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
sudo systemctl restart ctp-dns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo systemctl restart ctp-dns
systemctl status ctp-dns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
cd Pihole-Slave-Install/
sudo git pull
sudo apt install mbuffer
tail -f /var/log/ctp-dns/*.log
systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
/bin/bash -c "/root/go/bin/routedns ${ROUTE}/*.toml \
        --log-level=5 | mbuffer -T /tmp/ctp-dns.buffer -m 50M | tee -a ${LOG_FILE}"
/bin/bash -c "/root/go/bin/routedns ${ROUTE}/*.toml \
        --log-level=5 | mbuffer -T /tmp/ctp-dns.buffer -m 50M | tee -a ${LOG_FILE}"
sudo su
sudo git pull
tail -f /var/log/ctp-dns/*.log
sudo git pull
tail -f /var/log/ctp-dns/*.log
sudo git pull
tail -f /var/log/ctp-dns/*.log
sudo su
tail -f /var/log/ctp-dns/*.log
ystemctl status ctp-dns
stemctl status ctp-dns
systemctl status ctp-dns
cd Pihole-Slave-Install/
tail -f /var/log/ctp-dns/*.log
systemctl status ctp-dns
tail -f /var/log/pm.health-check.
tail -f /var/log/pm.health-check.log 
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
tail -f /var/log/pm.health-check.log 
systemctl status ctp-dns
udo su
sudo su
tail -f /var/log/ctp-dns/*.log
htop
cd Pihole-Slave-Install/
sudo git pull
tail -f /var/log/ctp-dns/*.log
rm -rf /var/log/ctp-dns/{default,error,access}.log 
rm -rf /var/log/ctp-dns/'{default,error,access}.log'
sudo rm -rf /var/log/ctp-dns/'{default,error,access}.log'
tail -f /var/log/ctp-dns/*.log
cd Pihole-Slave-Install/
tail -f /var/log/ctp-dns/*.log
systemctl status ctp-dns
tail -f /var/log/ctp-dns/*.log
exit
cd Pihole-Slave-Install/
sudo git pull
tail -f /var/log/ctp-dns/*.log
systemctl restart  ctp-dns
sudo systemctl restart  ctp-dns
systemctl daemon-reload 
sudo systemctl daemon-reload 
sudo systemctl restart  ctp-dns
cd Pihole-Slave-Install/
sudo git pull
exit
cd Pihole-Slave-Install/
sudo 
sudo git pull
sudo systemctl daemon-reload 
sudo systemctl restart  ctp-dns
journalctl -xe
sudo systemctl restart  ctp-dns
sudo systemctl status  ctp-dns
which tee
ls /bin/tee
exit
sudo systemctl status  ctp-dns
cd Pihole-Slave-Install/
sudo git pull
sudo systemctl restart  ctp-dns
sudo systemctl daemon-reload && sudo systemctl restart  ctp-dns
sudo systemctl status  ctp-dns
sudo systemctl daemon-reload && sudo systemctl restart  ctp-dns
sudo systemctl status  ctp-dns
sudo systemctl daemon-reload && sudo systemctl restart  ctp-dns
sudo systemctl status  ctp-dns
tail -f /var/log/ctp-dns/*.log
sudo systemctl status  ctp-dns
tail -f /var/log/pm.health-check.log 
sudo systemctl status  ctp-dns
sudo nano /mnt/HDD/Programs/ctp-dns.service 
sudo systemctl status  ctp-dns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo fail2ban-client status ctp-dns
systemctl start fail2ban
sudo systemctl start fail2ban
sudo systemctl status nginx
sudo fail2ban-client status ctp-dns
sudo fail2ban-client status ctp-dns-1-block
sudo fail2ban-client status pihole-dns
sudo fail2ban-client status pihole-dns-1-block
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
sudo nano /etc/cron.d/ubuntu-server-health_check*
sudo systemctl restart ctp-dns.service 
systemctl status ctp-dns
sudo systemctl restart ctp-dns.service 
systemctl status ctp-dns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo lsof -i :853
sudo lsof -i :53
sudo nano /home/ubuntuserver/Programs/route-dns/slave-resolvers.toml
sudo nano /home/ubuntuserver/Programs/route-dns/slave-listeners.toml 
sudo systemctl restart ctp-dns.service 
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo nano /home/ubuntuserver/Programs/route-dns/slave-listeners.toml 
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
sudo systemctl restart ctp-dns.service 
systemctl status ctp-dns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
sudo systemctl restart ctp-dns.service 
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo systemctl restart ctp-dns.service 
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
sudo systemctl restart ctp-dns.service 
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
sudo su
systemctl status ctp-dns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo systemctl restart ctp-dns.service 
systemctl status ctp-dns
sudo systemctl restart ctp-dns.service 
systemctl status ctp-dns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo su
sudo systemctl restart ctp-dns.service 
systemctl status ctp-dns
exit
cd Pihole-Slave-Install/
sudo git pull
sudo systemctl restart ctp-dns.service 
sudo systemctl daemon-reload' && sudo systemctl restart ctp-dns.service 
sudo systemctl daemon-reload && sudo systemctl restart ctp-dns.service 
systemctl status ctp-dns
sudo su
sudo systemctl daemon-reload && sudo systemctl restart ctp-dns.service 
cd ..
cd Identify_Customer_Segments/
git add .
git commit -m "MMMgit "
tail -f /var/log/ctp-dns/*.log
systemctl status ctp-dns
tail -f /var/log/pm.health-check.log 
 kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
tail -f /var/log/ctp-dns/*.log
 kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
 kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns +tcp
git push
 kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
cd Pihole-Slave-Install/
sudo git pull
 kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns +tcp
git lfs install
sudo apt search lts
sudo apt search lfs
sudo apt install git-lf
sudo apt install git-lfs
git lfs install
git add .
git commit -m "MMM"
git push
git-lf
git lfs install
git rebase
git lfs track *.csv
git add .
git commit -m "Added LFS "
git push
git rm --cached *.csv
git commit -m "Remved lfs"
git push
ls
git push -ff
git filter-branch --force --index-filter   "git rm --cached --ignore-unmatch path/to/your/large/file"   --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter   "git rm --cached --ignore-unmatched *.csv"   --prune-empty --tag-name-filter cat -- --all
ls
cp -rf *.csv ../
git commit -m "MMM"
git filter-branch --force --index-filter   "git rm --cached --ignore-unmatched *.csv"   --prune-empty --tag-name-filter cat -- --all
mv *.csv ../
git filter-branch --force --index-filter   "git rm --cached --ignore-unmatched *.csv"   --prune-empty --tag-name-filter cat -- --all
git add .
git commit -m "MMM"
ls
mv AZDIAS_Feature_Summary.csv ../
git add .
git commit -m "MM"
git filter-branch --force --index-filter   "git rm --cached --ignore-unmatched *.csv"   --prune-empty --tag-name-filter cat -- --all
git commit -m "MM"
git add .
git commit -m "MM"
git stash
git filter-branch --force --index-filter   "git rm --cached --ignore-unmatched *.csv"   --prune-empty --tag-name-filter cat -- --all
ls
ls ..
git filter-branch --force --index-filter   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv"   --prune-empty --tag-name-filter cat -- --all
git push
git add --all
git filter-branch --force --index-filter   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv"   --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv"   --prune-empty --tag-name-filter cat -- --all -f HEAD
git status
git filter-branch --force --index-filter   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv"   --prune-empty --tag-name-filter cat -- --all
git filter-repo --force --index-filter   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv"   --prune-empty --tag-name-filter cat -- --all
git filter-rop --force --index-filter   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv"   --prune-empty --tag-name-filter cat -- --all
git filter-repo --force --index-filter   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv"   --prune-empty --tag-name-filter cat -- --all
sudo apt install git-filter-repo
sudo apt search git-filter-repo
sudo apt install git-filter-repo
ip3 install git-filter-repo
pip3 install git-filter-repo
git filter-repo --force --index-filter   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv"   --prune-empty --tag-name-filter cat -- --all
cp -a git-filter-repo $(git --exec-path)
cp -rf ~/.local/bin/git-filter-repo $(git --exec-path)
sudo cp -rf ~/.local/bin/git-filter-repo $(git --exec-path)
git filter-repo --force --index-filter   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv"   --prune-empty --tag-name-filter cat -- --all
git filter-repo --force --index-filter   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv" --tag-name-filter cat -- --all
git lfs uninstall
git filter-repo --force --index-filter   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv" --tag-name-filter cat -- --all
git filter-repo --force   "git rm --cached --ignore-unmatched Udacity_AZDIAS_Subset.csv" --tag-name-filter cat -- --all
  git filter-repo --invert-paths --path *.csv
  git filter-repo --invert-paths --path *.csv --force
git push
git remote add origin https://github.com/charlieporth1/Identify_Customer_Segments
git push
 git push --set-upstream origin master
  git filter-repo --invert-paths --path Udacity_AZDIAS_Subset.csv --force
git push
git push --set-upstream origin master
systemctl status ctp-dns
sudo nano /mnt/HDD/Programs/test_dot.sh
sudo git pull
cd ..
cd Pihole-Slave-Install/
sudo git pull
sudo nano /mnt/HDD/Programs/test_dot.sh
htop
sudo git pull
systemctl status ctp-dns
kdig -d @ctp-vpn.local +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo nano /etc/cron.d/ubuntu-server-dns_route-fix
tail -f /var/log/pm.health-check.log 
sudo git pull
sudo ./update.sh 
sudo git pull
sudo bash /home/ubuntuserver/Pihole-Slave-Install/setup/cron.sh 
sudo nano /home/ubuntuserver/Programs/route-dns/slave-listeners.toml 
sudo bash /mnt/HDD/Programs/dns-route.sh
[[ "$IS_MASTER" == 'true' ]] && echo eh
sudo nano /home/ubuntuserver/Programs/route-dns/slave-listeners.toml 
systemctl status ctp-dns
tail -f /var/log/pm.health-check.log 
sudo nano /etc/dnsmasq.d/88-custom-dns-servers.conf 
ls config/dnsmasq.d/88-custom-dns-servers.conf 
sudo ./update.sh 
sudo git pull
sudo ./update.sh 
sudo nano /etc/dnsmasq.d/88-custom-dns-servers.conf 
cd Pihole-Slave-Install/
sudo git pull
systemctl status ctp-dns.service 
cd Pihole-Slave-Install/
sudo git pull
sudo nano /home/ubuntuserver/Programs/route-dns/ctp-yt-dns-router.toml 
nano /home/ubuntuserver/Programs/route-dns/ctp-yt-dns-router.toml 
systemctl status ctp-dns
pihole -t
exit
eit
exit
cd Pihole-Slave-Install/
systemctl status nginx
sudo git pull
git stash
sudo ./update.sh 
sudo ./update.sh  --master
sudo nano /home/ubuntuserver/Programs/route-dns/ctp-yt-dns-router.toml 
nano /home/ubuntuserver/Programs/route-dns/ctp-yt-dns-router.toml 
sudo git pull
sudo ./update.sh 
sudo git pull
sudo ./update.sh 
systemctl status ctp-dns
cd Pihole-Slave-Install/
sudo git pull && sudo ./install.sh
cd Pihole-Slave-Install/
sudo git pull
sudo ./update.sh 
cd 
cd Pihole-Slave-Install/
sudo git pull
sudo bash /mnt/HDD/Programs/dns-route.sh
giy
ah
ha
h
&
sudo su
cd Pihole-Slave-Install/
sudo git pull
'
































ifconfig
dig www.ads.com
dig www.ads.com @dns.ctptech.dev
dig www.ads.com @home.ctptech.dev
dig www.ads.com @aws.ctptech.dev
cd Pihole-Slave-Install/
sudo git pull
sudo ./update.sh 
sudo  
systemctl status unbound
sudo iptables -F
sudo iptables -L
cd Pihole-Slave-Install/
sudo git pull
systemctl status lighttpd
pihole -t
systemctl status lighttpd
systemctl status ctp-dns
systemctl restart ctp-dns
sudo systemctl restart ctp-dns
systemctl status ctp-dns
sudo su
cd Pihole-Slave-Install/
sudo git stash
sudo ./setup/dns-route.sh
sudo su
nano install.sh
sudo apt install pcregrep
sudo git stash
sudo ./setup/dns-route.sh
sudo nano /home/ubuntuserver/Programs/route-dns/ctp-yt-dns-router.toml 
systemctl status ctp-dns
systemctl status lighttpd.service 
ls /etc/pihole/
exit
systemctl status lighttpd.service 
pihole -t
cd Pihole-Slave-Install/
sudo bash /mnt/HDD/Programs/copy_gravity.sh 
pihole -t
pihole restartdns
sudo bash /mnt/HDD/Programs/copy_gravity.sh 
pihole restartdns
systemctl status ctp-dns
htop
ifconfig
sudo su
ifconfig
systemctl status ctp-dns
systemctl status unbound
htop
sudo git pull
sudo git stash
sudo git pull
sudo bash setup/dns-route.sh
sudo ./up
sudo ./update.sh 
sudo git pull
systemctl status ctp-dns
sudo git pull
systemctl status ctp-dns
kdig -d @aws.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo git pull
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
tail -f /var/log/pm.health-check.log 
systemctl status ctp-dns
tail -f /var/log/pm.health-check.log 
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo su
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
sudo su
systemctl status ctp-dns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=10 +dnssec +edns
sudo git pull
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
kdig -d @home.ctptech.dev +tls-ca +tls-host=dns.ctptech.dev www.google.com +timeout=4 +dnssec +edns
systemctl status ctp-dns
