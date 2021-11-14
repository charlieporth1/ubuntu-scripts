#!/bin/bash
MODULES_LIST=$(find /lib/modules/$(uname -r) -type f -name '*.ko' | rev | awk -F/ '{print $1}' | rev | cut -d. -f 1)
MODULES_NET_LIST=$(find /lib/modules/$(uname -r) -type f -name '*.ko' | grep net | rev | awk -F/ '{print $1}' | rev | cut -d. -f 1)
#CRIPTO
# AES
modprobe $(printf '%s\n' "$MODULES_LIST" | grep -i aes)
# SHA
modprobe $(printf '%s\n' "$MODULES_LIST" | grep -i sha)
# 25519
modprobe $(printf '%s\n' "$MODULES_LIST" | grep -i 25519)
# rsa
modprobe $(printf '%s\n' "$MODULES_LIST" | grep -i rsa)
# ecdh
modprobe $(printf '%s\n' "$MODULES_LIST" | grep -i ecdh)
# poly
modprobe $(printf '%s\n' "$MODULES_LIST" | grep -i poly)
# crc32
modprobe $(printf '%s\n' "$MODULES_LIST" | grep -i crc32)
# ccamellia
modprobe $(printf '%s\n' "$MODULES_LIST" | grep -i camellia)
# ghash
modprobe $(printf '%s\n' "$MODULES_LIST" | grep -i ghash)
d="""
# ARC
#arc4
#arcfb

# MD
modprobe  md4 md5-generic
# misc crypt
modprobe  ecdh_generic rsa-generic x25 compress_null-generic cipher_null-generic digest_null-generic crypto_engine
# HASH
modprobe libchacha20poly1305 libpoly1305 libblake2s libpoly1305 libblake2s-generic libchacha poly1305_generic nhpoly1305
# x25
modprobe curve25519-generic libcurve25519 libcurve25519-generic

modprobe camellia-aesni-avx-x86_64 camellia-aesni-avx2 camellia-x86_64
#BLOWFISH
modprobe blowfish_generic blowfish_common blowfish-x86_64
modprobe chacha-x86_64

#GHASH
modprobe ghash-clmulni-intel

#NET
modprobe vhost vhost_vsock vhost_net veth vmac dummy
# NET
modprobe tcp_bbr udp_tunnel tcp_highspeed tcp_scalable ip_tunnel tunnel4 tcp_yeah ipcomp tcp_htcp tls tcp_hybla ipip
# VPN
modprobe wireguard oprofile
# FS
modprobe cachefiles  fscache
#dm-crypt
#dm-cache

# instructions
modprobe msr xor async-ppp async_xor async_memcpy async_tx xt_tcpudp xt_cpu


# SCHE
# NET
modprobe act_ipt cls_route em_ipt sch_fq_pie em_ipset act_gate sch_gred sch_multiq sch_qfq sch_fq sch_skbprio sch_tbf sch_ingress 

# MISC
modprobe nvram  ah4 gre linear libstring

# compression
modprobe lz4hc lz4_compress lz4 lz4hc_compress
"""
# IPTABLES NFT
modprobe $(printf '%s\n' "$MODULES_LIST" | grep -i nft)
modprobe $(printf '%s\n' "$MODULES_NET_LIST" | grep -i nf)
# ipset
modprobe $(printf '%s\n' "$MODULES_LIST" | grep -i ip_set)
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
