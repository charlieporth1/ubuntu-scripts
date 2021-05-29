groupadd -g 88 unbound &&
useradd -c "Unbound DNS Resolver" -d /var/lib/unbound -u 88 \
        -g unbound -s /bin/false unbound

sudo apt -y install libnghttp2-dev libnghttp2-14 libmnl0 libmnl-dev libnftnl11 libnftnl-dev \
build-essential git libsystemd-dev libsystemd0 openssl libssl1.1 libssl-dev libevent-openssl-2.1-7 \
libevent-pthreads-2.1-7 libevhtp-dev libuv1-dev libevent-dev libevent-core-2.1-7 libevent-2.1-7 \
libexpat1-dev libexpat1 libexpat-gst libsodium-dev libsodium23

ROOT_DIR=/tmp
WORK_DIR=/tmp/unbound

cd $ROOT_DIR
git clone https://github.com/NLnetLabs/unbound

cd $WORK_DIR
./configure --with-libnghttp2 --enable-ipset --enable-ipsecmod \
	 --with-pthreads --enable-dnscrypt --enable-cachedb --enable-systemd \
	 --sbindir=/usr/sbin --sysconfdir=/etc/ --bindir=/usr/bin \
	 --libexecdir=/usr/libexec --with-libevent=yes \
         --enable-tfo-server --disable-dsa --disable-sha1 --disable-ecdsa \
         --enable-tfo-client --with-username=unbound \
         --with-pidfile=/run/unbound.pid --disable-ed448
#--with-ssl=
#--with-run-dir=/run
#/usr/lib/x86_64-linux-gnu/libevent.so /usr/lib/x86_64-linux-gnu/libevent.a
#whereis libevent

make
make install
ldconfig
