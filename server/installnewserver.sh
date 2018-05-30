sudo apt-get install -y lolcat brotli cmake  dateutils  dns2tcp gzip gputils  gcc  flac hydra httrack lzip make mac-robber nodejs nutcracker 
sudo apt-get install -y openssl sendmail binutils crunch coreutils codec2  m4 moreutils mosh  ntp p7zip pwgen 
sudo apt-get install -y proxychains  python-pip python-dnspython python-mechanize python-slowaes python-xlsxwriter python-jsonrpclib python-lxml psutils recutils sipcalc  wordnet wordplay antiword 

sudo apt-get install -y build-essential parallel htop rsync ruby python nano mysql sqlite zip unzip rar unrar wget git curl nano net-tools screen  fail2ban sqlite3 libssl-dev git-core  tor
sudo apt-get install -y hello lolcat geoip-bin sshfs python3 ruby-rails  docker fail2ban htop
sudo apt-get install -y gpuutils inetutils findutils psutils figlet python-pip python-pip3 nodejs cvs fuse gradle clamav espeak fcrackzip rsync ffmpeg genometools  geoip-bin geoipupdate 
sudo apt-get install -y gnupg gnupg etckeeper gradle antiword fail2ban brotli chkrootkit  
sudo apt-get install -y  libcryptsetup-dev libjansson-dev libpng-dev zlib1g-dev pi lolcat figlet 


#git clone https://github.com/pkoutoupis/rapiddisk

#https://github.com/mozilla/geckodriver/releases/download/v0.20.1/geckodriver-v0.20.1-arm7hf.tar.gz
#wget https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-linux64.tar.gz
#wget https://github.com/mozilla/geckodriver/releases/download/v0.20.1/geckodriver-v0.20.1-linux64.tar.gz
#tar -xvzf geckodriver*
#chmod +x geckodriver
#cp ./geckodriver /usr/local/bin
#git clone https://github.com/mozilla/geckodriver/
git clone https://github.com/mozilla/geckodriver/tree/release
cd geckodriver
./build.sh
./ci.sh
cp ./geckodriver /usr/local/bin


#wget http://apache.mirrors.tds.net/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
#tar -xzvf hadoop*.tar.gz
#sudo mv hadoop* /usr/local/hadoop
#git clone https://github.com/apache/hadoop
#cd hadoop/
#./start-build-env.sh 

#cd ..

sudo apt install checkinstall git
sudo apt build-dep hashcat
git clone https://github.com/hashcat/hashcat.git
cd hashcat
git submodule update --init
sudo make
sudo checkinstall
cd .. 




# get core tools, languages, and libraries
sudo apt-get install -y build-essential software-properties-common wget curl git \
  cmake lsof m4 apt-transport-https ca-certificates autoconf
sudo apt-get install -y python-setuptools python-software-properties ruby ruby-dev \
  ruby2.0 ruby2.0-dev texinfo xclip
sudo apt-get install -y libzmq3 libzmq3-dev libzmq5-dev libczmq-dev libncurses-dev \
  libncurses5-dev libcurl4-openssl-dev libcurl4-gnutls-dev
sudo apt-get install -y libbz2-dev libssl-dev libpng-dev liblzma-dev libpcre2-dev \
  libfreetype6-dev libsqlite3-dev libblas-dev liblapack-dev libreadline-dev \
  libboost-all-dev libfontconfig1-dev
sudo apt-get install -y libexpat-dev libsdl-dev libxml2-dev libgeos-dev zlib1g-dev \
  libgdbm-dev libxslt1-dev libcairo-dev libgdal-dev libglib2.0-dev libtool

# add bash completions
sudo apt-get install -y bash-completion



sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-install -yer
sudo apt-get install -y oracle-java8-set-default

#install -y latest node version
apt-get install -y python-software-properties
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
apt-get update
apt-get install -y nodejs


#install -y docker
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-get update
sudo apt-get install -y docker-engine
update-rc.d docker enable

