#!/bin/bash
#CRIPTO
#SHA
modprobe sha1-ssse3 sha256-ssse3 sha512-ssse3
modprobe sha3_generic sha512-generic sha224-generic
#AES
modprobe aesni-intel aes aes_ti aesni_intel aegis128-aesni
modprobe camellia-aesni-avx-x86_64 camellia-aesni-avx2 camellia-x86_64
#BLOWFISH
modprobe blowfish_generic blowfish_common blowfish-x86_64
modprobe chacha-x86_64
#ARC
modprobe arc4 arcfb
#MD
modprobe md4 md5-generic
#GHASH
modprobe ghash-clmulni-intel
#ECDH
modprobe ecdh_generic
#X25
modprobe x25
#RSA
modprobe rsa-generic

#MISC
modprobe compress_null-generic cipher_null-generic digest_null-generic
modprobe crypto_engine

#INSTRUNCTIONS
modprobe msr
modprobe xor
#DM
modprobe dm-crypt dm-cache
#ASYNC
modprobe async-ppp async_xor async_memcpy async_tx
#TX
modprobe xt_tcpudp  xt_cpu
#FS
modprobe fscache cachefiles
#COMPRESSION
modprobe lz4_compress lz4hc_compress lz4 lz4hc
#NETWORK
modprobe vhost vhost_vsock  vhost_net vhost veth vmac
modprobe dummy udp_tunnel tcp_bbr
#VPNs
modprobe wireguard oprofile
#MISC
modprobe nvram ah4 gre
modprobe linear libstring


#(
#       modprobe rapiddisk-cache 2> /tmp/rapiddisk-cache.err
#       modprobe rapiddisk 2> /tmp/rapiddisk.err
        #sudo rapiddisk --attach 6096
        #sudo mkfs.ext4 /dev/rd0
        #sudo tune2fs -m 0 /dev/rd0
        #sudo mkdir /media/ramdrive
        #sudo rapiddisk --cache-map rd0 /dev/sdc1
        #sudo mount /dev/mapper/rc-wt_sdc1 /media/ramdrive
        #sudo mount /dev/rd0 /media/ramdrive
#)&
