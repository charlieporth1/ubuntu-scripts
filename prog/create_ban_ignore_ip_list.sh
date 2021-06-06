#!/bin/bash
source $PROG/all-scripts-exports.sh
CONCURRENT
declare -a UNI_IGNORE_IPs
UNI_IGNORE_IP=(
	172.31.12.154
	172.31.12.154/16
        192.168.44.29/16
        102.168.44.250
        192.168.44.29
        17.130.53.174
        158.105.192.35
        9.123.168.192
	108.73.128.11
	108.73.128.11 # AUNT SUE
        8.123.168.192
        51.44.168.192
        250.44.168.192
        192.168.127.10
        192.168.44.1
        192.168.40.1
        0.0.0.0
        172.58.87.88    #
        172.58.156.197  # *
        172.195.69.25
        127.0.0.0/8
        174.53.130.17 # Home
        192.168.0.0/16
        192.168.44.0/24
        192.168.40.0/24
        169.254.169.254
        10.66.66.1
        10.66.66.0/24
        $(bash $PROG/get_ext_ip.sh dns.ctptech.dev | grep -o "${IP_REGEX}")
        $(bash $PROG/get_ext_ip.sh home.ctptech.dev | grep -o "${IP_REGEX}")
        $(bash $PROG/get_ext_ip.sh gcp.ctptech.dev | grep -o "${IP_REGEX}")
        $(bash $PROG/get_ext_ip.sh master.dns.ctptech.dev | grep -o "${IP_REGEX}")
        $(bash $PROG/get_ext_ip.sh --curent-ip | grep -o "${IP_REGEX}")
        $(bash $PROG/get_network_devices_ip_address.sh --loop --wlan | grep -o "${IP_REGEX}")
        home.ctptech.dev
        azure.ctptech.dev
        aws.ctptech.dev
        gcp.ctptech.dev
        dns.ctptech.dev
        master.dns.ctptech.dev
)
UNI_IGNORE_IPs=( $( filter_ip_address_array "${UNI_IGNORE_IPs[@]}" ) )

declare -a DEFAULT_DNS_SERVERS=(
        1.0.0.1
        1.1.1.1
        8.8.8.8
        8.8.4.4
        9.9.9.9
        192.168.44.1
        192.168.40.1
        127.0.0.1
)
filter_ip_address_array "${DEFAULT_DNS_SERVERS[@]}"

declare -a UPTIME_IGNORE_IPs=(
        122.248.234.23/24
        63.143.42.248/24
)
UNI_IGNORE_IPs=( $( filter_ip_address_array "${UNI_IGNORE_IPs[@]}" ) )

declare -a TMobileIPs
T_MobileIPs=(
$(curl https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/mobile.tmobile.list)
$(curl https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/mobile.tmobileus.list)
$(curl https://raw.githubusercontent.com/cbuijs/accomplist/master/chris/white.tmobileus.ip.list)
74.125.42.39
172.56.0.0/8
172.100.0.0/16
172.195.0.0/16
172.56.0.0/16
100.128.0.0/9
162.160.0.0/11
172.32.0.0/11
172.58.0.0/16   # T-Mobile
172.58.87.88    #
172.58.156.197  # *
172.195.69.25
100.128.0.0/9
162.160.0.0/11
162.186.0.0/15
162.190.0.0/16
162.191.0.0/16
172.32.0.0/11
172.56.0.0/16
172.56.10.0/23
172.56.12.0/23
172.56.132.0/24
172.56.134.0/24
172.56.136.0/24
172.56.138.0/24
172.56.140.0/24
172.56.14.0/23
172.56.143.0/24
172.56.146.0/24
172.56.16.0/23
172.56.20.0/23
172.56.2.0/23
172.56.22.0/23
172.56.26.0/23
172.56.28.0/23
172.56.30.0/23
172.56.34.0/23
172.56.36.0/23
172.56.38.0/23
172.56.40.0/23
172.56.4.0/23
172.56.42.0/23
172.56.44.0/23
172.56.6.0/23
172.58.0.0/15
172.58.0.0/21
172.58.104.0/21
172.58.120.0/21
172.58.136.0/21
172.58.144.0/21
172.58.152.0/21
172.58.16.0/21
172.58.168.0/21
172.58.184.0/21
172.58.200.0/21
172.58.216.0/21
172.58.224.0/21
172.58.232.0/21
172.58.24.0/21
172.58.32.0/21
172.58.40.0/21
172.58.56.0/21
172.58.64.0/21
172.58.72.0/21
172.58.80.0/21
172.58.8.0/21
172.58.88.0/21
172.58.96.0/21
174.141.208.0/20
206.29.188.0/23
206.29.190.0/23
208.54.0.0/17
208.54.100.0/22
208.54.104.0/24
208.54.108.0/22
208.54.112.0/24
208.54.117.0/24
208.54.127.0/24
208.54.128.0/19
208.54.134.0/23
208.54.136.0/23
208.54.138.0/23
208.54.140.0/23
208.54.142.0/24
208.54.143.0/24
208.54.144.0/20
208.54.145.0/24
208.54.147.0/24
208.54.153.0/24
208.54.16.0/24
208.54.17.0/24
208.54.18.0/24
208.54.19.0/24
208.54.20.0/24
208.54.2.0/24
208.54.33.0/24
208.54.34.0/24
208.54.35.0/24
208.54.36.0/24
208.54.37.0/24
208.54.39.0/24
208.54.40.0/24
208.54.4.0/24
208.54.44.0/24
208.54.5.0/24
208.54.66.0/24
208.54.67.0/24
208.54.70.0/24
208.54.7.0/24
208.54.74.0/24
208.54.75.0/24
208.54.76.0/22
)


TMobileIPs=( $( filter_ip_address_array "${TMobileIPs[@]}" ) )


declare -a DNS_IGNORE_IPs
DNS_IGNORE_IPs=(
        ${UPTIME_IGNORE_IPs[@]}
        ${DEFAULT_DNS_SERVERS[@]}
        0.0.0.0
        172.53.0.0/16
        172.58.0.0/16
        172.100.122.109
        192.168.40.0/24 # Internal servers
        192.168.99.9    #
        10.128.0.9      # *
        ${UNI_IGNORE_IP[@]}
        ${T_MobileIPs[@]}
        35.192.105.158
        35.232.120.211
        174.53.130.17
)

for i in {0..255}
do
        IP_PRIVATE=192.168.1.$i
        IP_PRIVATE_1=192.168.44.$i
        IP_PRIVATE_2=192.168.43.$i
        IP_PRIVATE_3=192.168.40.$i
        IP_NON=0.0.0.$i
        DNS_IGNORE_IPs=(
                ${DNS_IGNORE_IPs[@]}
                $IP_NON $IP_PRIVATE
                $IP_PRIVATE_1
                $IP_PRIVATE_2
                $IP_PRIVATE_3
        )
done


DNS_IGNORE_IPs=( $( filter_ip_address_array "${DNS_IGNORE_IPs[@]}" ) )

IP_REGEX="((([0-9]{1,3})\.){4})"
FILE_NAME='ban_ignore_ip_list'

INGORE_IP_ADRESSES_GREP=$( bash $PROG/grepify.sh $( echo "${DNS_IGNORE_IPs[@]}" ) )
INGORE_IP_ADRESSES_CSV=$( bash $PROG/csvify.sh $( echo "${DNS_IGNORE_IPs[@]}" ) )

printf '%s\n' "${DNS_IGNORE_IPs[@]}" > /tmp/$FILE_NAME.txt
echo "$INGORE_IP_ADRESSES_GREP" > /tmp/$FILE_NAME.grep
echo "$INGORE_IP_ADRESSES_CSV" > /tmp/$FILE_NAME.csv





















































































































































































































































































































































































































































































































































root@ctp-vpn:/etc/letsencrypt/live/vpn.ctptech.dev# sudo nano $r_list/black/regex.txt 
root@ctp-vpn:/etc/letsencrypt/live/vpn.ctptech.dev# sudo nano $hole/custom_regex_blacklist.txt
root@ctp-vpn:/etc/letsencrypt/live/vpn.ctptech.dev# exit
exit
12:01:05:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git add 
Nothing specified, nothing added.
Maybe you wanted to say 'git add .'?
12:01:08:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git add .
git warning: adding embedded git repository: routedns
hint: You've added another git repository inside your current repository.
hint: Clones of the outer repository will not contain the contents of
hint: the embedded repository and will not know how to obtain it.
hint: If you meant to add a submodule, use:
hint: 
hint: 	git submodule add <url> routedns
hint: 
hint: If you added this path by mistake, you can remove it from the
hint: index with:
hint: 
hint: 	git rm --cached routedns
hint: 
hint: See "git help submodule" for more information.
c12:01:10:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git commit -m "Added ecs"
g
----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :/home/charlieporth1_gmail_com/Pihole-Slave-Install:
________________________________________________________________________________________________________________

ti Copied extenal config files
[master 5b4a96b] Added ecs
 13 files changed, 64 insertions(+), 16 deletions(-)
 delete mode 100644 fullchain.crt
 create mode 160000 routedns
12:01:30:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git commit -m "Added ecs"

----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :/home/charlieporth1_gmail_com/Pihole-Slave-Install:
________________________________________________________________________________________________________________

git pushCopied extenal config files
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
12:03:00:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ ls
LICENSE    apply_config.sh  config          install.sh       links.sh  master  reload_ctp-dns.sh    routedns  update.sh
README.md  bash_rc_sample   copy_config.sh  install.sh.save  lists     prog    restart_services.sh  setup     vpn.ctptech.dev.der
12:03:04:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ nano .pre-commit-hook.sh 
12:03:48:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ ls
LICENSE    apply_config.sh  config          install.sh       links.sh  master  reload_ctp-dns.sh    routedns  update.sh
README.md  bash_rc_sample   copy_config.sh  install.sh.save  lists     prog    restart_services.sh  setup     vpn.ctptech.dev.der
12:03:49:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ nano .pre-commit-hook.sh 
12:04:58:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git add .
12:05:00:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git commit -m "Changed hook"

----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :/home/charlieporth1_gmail_com/Pihole-Slave-Install:
________________________________________________________________________________________________________________

git pushrm: cannot remove 'routedns/dnslistener.go': Permission denied
rm: cannot remove 'routedns/replace.go': Permission denied
rm: cannot remove 'routedns/.github/workflows/build.yaml': Permission denied
rm: cannot remove 'routedns/doc/use-case-6.svg': Permission denied
rm: cannot remove 'routedns/doc/use-case-4.svg': Permission denied
rm: cannot remove 'routedns/doc/pipeline-overview.svg': Permission denied
rm: cannot remove 'routedns/doc/use-case-1.svg': Permission denied
rm: cannot remove 'routedns/doc/pipeline-overview.drawio': Permission denied
rm: cannot remove 'routedns/doc/use-case-3.svg': Permission denied
rm: cannot remove 'routedns/doc/use-cases.drawio': Permission denied
rm: cannot remove 'routedns/doc/configuration.md': Permission denied
rm: cannot remove 'routedns/doc/use-case-2.svg': Permission denied
rm: cannot remove 'routedns/doc/configuration.png': Permission denied
rm: cannot remove 'routedns/doc/use-case-5.svg': Permission denied
rm: cannot remove 'routedns/doc/configuration.odg': Permission denied
rm: cannot remove 'routedns/static.go': Permission denied
rm: cannot remove 'routedns/dotlistener_test.go': Permission denied
rm: cannot remove 'routedns/doqclient_test.go': Permission denied
rm: cannot remove 'routedns/cache_test.go': Permission denied
rm: cannot remove 'routedns/roundrobin.go': Permission denied
rm: cannot remove 'routedns/blocklistdb-domain_test.go': Permission denied
rm: cannot remove 'routedns/dotlistener.go': Permission denied
rm: cannot remove 'routedns/net-resolver_test.go': Permission denied
rm: cannot remove 'routedns/dohlistener_test.go': Permission denied
rm: cannot remove 'routedns/LICENSE': Permission denied
rm: cannot remove 'routedns/blocklist_test.go': Permission denied
rm: cannot remove 'routedns/failrotate.go': Permission denied
rm: cannot remove 'routedns/blocklist.go': Permission denied
rm: cannot remove 'routedns/blocklistloader-static.go': Permission denied
rm: cannot remove 'routedns/padding.go': Permission denied
rm: cannot remove 'routedns/ip-blocklist-trie.go': Permission denied
rm: cannot remove 'routedns/cidr-db_test.go': Permission denied
rm: cannot remove 'routedns/.dockerignore': Permission denied
rm: cannot remove 'routedns/dtlsclient.go': Permission denied
rm: cannot remove 'routedns/client-blocklist.go': Permission denied
rm: cannot remove 'routedns/drop.go': Permission denied
rm: cannot remove 'routedns/cache.go': Permission denied
rm: cannot remove 'routedns/router.go': Permission denied
rm: cannot remove 'routedns/dohclient.go': Permission denied
rm: cannot remove 'routedns/README.md': Permission denied
rm: cannot remove 'routedns/doqlistener.go': Permission denied
rm: cannot remove 'routedns/ecs-modifier.go': Permission denied
rm: cannot remove 'routedns/failback_test.go': Permission denied
rm: cannot remove 'routedns/dnsclient_test.go': Permission denied
rm: cannot remove 'routedns/lru-cache_test.go': Permission denied
rm: cannot remove 'routedns/static_test.go': Permission denied
rm: cannot remove 'routedns/example_test.go': Permission denied
rm: cannot remove 'routedns/response-blocklist-ip.go': Permission denied
rm: cannot remove 'routedns/dotclient.go': Permission denied
rm: cannot remove 'routedns/go.sum': Permission denied
rm: cannot remove 'routedns/blocklistdb-hosts.go': Permission denied
rm: cannot remove 'routedns/logger.go': Permission denied
rm: cannot remove 'routedns/cidr-db.go': Permission denied
rm: cannot remove 'routedns/blocklistdb-domain.go': Permission denied
rm: cannot remove 'routedns/fastest.go': Permission denied
rm: cannot remove 'routedns/resolver_test.go': Permission denied
rm: cannot remove 'routedns/testdata/client.crt': Permission denied
rm: cannot remove 'routedns/testdata/server.key': Permission denied
rm: cannot remove 'routedns/testdata/client.key': Permission denied
rm: cannot remove 'routedns/testdata/server.crt': Permission denied
rm: cannot remove 'routedns/testdata/ca.key': Permission denied
rm: cannot remove 'routedns/testdata/DigiCertECCSecureServerCA.pem': Permission denied
rm: cannot remove 'routedns/testdata/ca.crt': Permission denied
rm: cannot remove 'routedns/pipeline_test.go': Permission denied
rm: cannot remove 'routedns/resolver.go': Permission denied
rm: cannot remove 'routedns/blocklistdb-hosts_test.go': Permission denied
rm: cannot remove 'routedns/rate-limiter.go': Permission denied
rm: cannot remove 'routedns/router_test.go': Permission denied
rm: cannot remove 'routedns/adminlistener.go': Permission denied
rm: cannot remove 'routedns/doqclient.go': Permission denied
rm: cannot remove 'routedns/dtlslistener.go': Permission denied
rm: cannot remove 'routedns/doc.go': Permission denied
rm: cannot remove 'routedns/response-blocklist-name.go': Permission denied
rm: cannot remove 'routedns/dnsclient.go': Permission denied
rm: cannot remove 'routedns/errors.go': Permission denied
rm: cannot remove 'routedns/.git/objects/pack/pack-6395ad13b0ee007001fa960f17c0b13ccb504358.idx': Permission denied
rm: cannot remove 'routedns/.git/objects/pack/pack-6395ad13b0ee007001fa960f17c0b13ccb504358.pack': Permission denied
rm: cannot remove 'routedns/.git/objects/info': Permission denied
rm: cannot remove 'routedns/.git/logs/HEAD': Permission denied
rm: cannot remove 'routedns/.git/logs/refs/remotes/origin/HEAD': Permission denied
rm: cannot remove 'routedns/.git/logs/refs/heads/master': Permission denied
rm: cannot remove 'routedns/.git/index': Permission denied
rm: cannot remove 'routedns/.git/FETCH_HEAD': Permission denied
rm: cannot remove 'routedns/.git/info/exclude': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-rebase.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/post-update.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/prepare-commit-msg.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/commit-msg.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/update.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-commit.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-push.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-receive.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-merge-commit.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/fsmonitor-watchman.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-applypatch.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/applypatch-msg.sample': Permission denied
rm: cannot remove 'routedns/.git/config': Permission denied
rm: cannot remove 'routedns/.git/HEAD': Permission denied
rm: cannot remove 'routedns/.git/description': Permission denied
rm: cannot remove 'routedns/.git/refs/remotes/origin/HEAD': Permission denied
rm: cannot remove 'routedns/.git/refs/tags': Permission denied
rm: cannot remove 'routedns/.git/refs/heads/master': Permission denied
rm: cannot remove 'routedns/.git/packed-refs': Permission denied
rm: cannot remove 'routedns/.git/ORIG_HEAD': Permission denied
rm: cannot remove 'routedns/.git/branches': Permission denied
rm: cannot remove 'routedns/blocklistdb-regexp.go': Permission denied
rm: cannot remove 'routedns/net-resolver.go': Permission denied
rm: cannot remove 'routedns/route.go': Permission denied
rm: cannot remove 'routedns/go.mod': Permission denied
rm: cannot remove 'routedns/Dockerfile': Permission denied
rm: cannot remove 'routedns/blocklistloader-http.go': Permission denied
rm: cannot remove 'routedns/vars.go': Permission denied
rm: cannot remove 'routedns/roundrobin_test.go': Permission denied
rm: cannot remove 'routedns/failrotate_test.go': Permission denied
rm: cannot remove 'routedns/validate.go': Permission denied
rm: cannot remove 'routedns/dohclient_test.go': Permission denied
rm: cannot remove 'routedns/blocklistloader.go': Permission denied
rm: cannot remove 'routedns/ip-db-multi.go': Permission denied
rm: cannot remove 'routedns/padding_test.go': Permission denied
rm: cannot remove 'routedns/blocklistloader-local.go': Permission denied
rm: cannot remove 'routedns/fastest_test.go': Permission denied
rm: cannot remove 'routedns/cmd/routedns/routedns.service': Permission denied
rm: cannot remove 'routedns/cmd/routedns/main.go': Permission denied
rm: cannot remove 'routedns/cmd/routedns/config.go': Permission denied
rm: cannot remove 'routedns/cmd/routedns/resolver.go': Permission denied
rm: cannot remove 'routedns/cmd/routedns/.gitignore': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/mutual-tls-doh-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doh-quic-server.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/restricted-listener.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-dns.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-4.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-minimize.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/dtls-server.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/client-blocklist.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/mutual-tls-doh-server.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/rfc8482.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-collapse.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-name-resolver.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/bootstrap-resolver.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/mutual-tls-dot-server.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-allow.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-ip.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-ip-resolver.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-5-server.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/cidr.txt': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/location.txt': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/server.key': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-geo.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doq-client-simple.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/client-blocklist-drop.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/client-blocklist-refused.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/block-split-cache.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-regexp.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/client-blocklist-geo.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/domains.txt': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/server-ec.key': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doh-quic-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doh-behind-proxy.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/edns0-modifier.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doh-quic-client-local.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/mutual-tls-dot-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/ttl-modifier.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/server-ec.crt': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doq-listener.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/family-browsing.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-hosts.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-config/resolvers.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-config/README.md': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-config/listeners.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-config/blocklist.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-config/cache.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-1.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-2.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-6.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-name.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/server.crt': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/walled-garden.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/simple-dot-proxy.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/ecs-modifier-add.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/simple-dot.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/random-resolver.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-domain.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/ecs-modifier-delete.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/fastest.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-local.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/admin.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-remote.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/simple-dot-cache.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doq-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/dtls-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-ip-remote.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/ecs-modifier-privacy.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-5-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-name-remote.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-remote-cache.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/simple-doh.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/router.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/well-known.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/rate-limiter.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/cache.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-resolver.toml': Permission denied
rm: cannot remove 'routedns/dtls.go': Permission denied
rm: cannot remove 'routedns/dohlistener.go': Permission denied
rm: cannot remove 'routedns/message.go': Permission denied
rm: cannot remove 'routedns/response-collapse.go': Permission denied
rm: cannot remove 'routedns/failback.go': Permission denied
rm: cannot remove 'routedns/blocklistdb.go': Permission denied
rm: cannot remove 'routedns/route_test.go': Permission denied
rm: cannot remove 'routedns/blocklistdb-multi.go': Permission denied
rm: cannot remove 'routedns/replace_test.go': Permission denied
rm: cannot remove 'routedns/lru-cache.go': Permission denied
rm: cannot remove 'routedns/response-minimize.go': Permission denied
rm: cannot remove 'routedns/tls.go': Permission denied
rm: cannot remove 'routedns/pipeline.go': Permission denied
rm: cannot remove 'routedns/random.go': Permission denied
rm: cannot remove 'routedns/geoip-db.go': Permission denied
rm: cannot remove 'routedns/listener.go': Permission denied
rm: cannot remove 'routedns/dotclient_test.go': Permission denied
rm: cannot remove 'routedns/ttl-modifier.go': Permission denied
rm: cannot remove 'routedns/edns0-modifier.go': Permission denied

----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :/home/charlieporth1_gmail_com/Pihole-Slave-Install:
________________________________________________________________________________________________________________

rm: cannot remove 'routedns/dnslistener.go': Permission denied
rm: cannot remove 'routedns/replace.go': Permission denied
rm: cannot remove 'routedns/.github/workflows/build.yaml': Permission denied
rm: cannot remove 'routedns/doc/use-case-6.svg': Permission denied
rm: cannot remove 'routedns/doc/use-case-4.svg': Permission denied
rm: cannot remove 'routedns/doc/pipeline-overview.svg': Permission denied
rm: cannot remove 'routedns/doc/use-case-1.svg': Permission denied
rm: cannot remove 'routedns/doc/pipeline-overview.drawio': Permission denied
rm: cannot remove 'routedns/doc/use-case-3.svg': Permission denied
rm: cannot remove 'routedns/doc/use-cases.drawio': Permission denied
rm: cannot remove 'routedns/doc/configuration.md': Permission denied
rm: cannot remove 'routedns/doc/use-case-2.svg': Permission denied
rm: cannot remove 'routedns/doc/configuration.png': Permission denied
rm: cannot remove 'routedns/doc/use-case-5.svg': Permission denied
rm: cannot remove 'routedns/doc/configuration.odg': Permission denied
rm: cannot remove 'routedns/static.go': Permission denied
rm: cannot remove 'routedns/dotlistener_test.go': Permission denied
rm: cannot remove 'routedns/doqclient_test.go': Permission denied
rm: cannot remove 'routedns/cache_test.go': Permission denied
rm: cannot remove 'routedns/roundrobin.go': Permission denied
rm: cannot remove 'routedns/blocklistdb-domain_test.go': Permission denied
rm: cannot remove 'routedns/dotlistener.go': Permission denied
rm: cannot remove 'routedns/net-resolver_test.go': Permission denied
rm: cannot remove 'routedns/dohlistener_test.go': Permission denied
rm: cannot remove 'routedns/LICENSE': Permission denied
rm: cannot remove 'routedns/blocklist_test.go': Permission denied
rm: cannot remove 'routedns/failrotate.go': Permission denied
rm: cannot remove 'routedns/blocklist.go': Permission denied
rm: cannot remove 'routedns/blocklistloader-static.go': Permission denied
rm: cannot remove 'routedns/padding.go': Permission denied
rm: cannot remove 'routedns/ip-blocklist-trie.go': Permission denied
rm: cannot remove 'routedns/cidr-db_test.go': Permission denied
rm: cannot remove 'routedns/.dockerignore': Permission denied
rm: cannot remove 'routedns/dtlsclient.go': Permission denied
rm: cannot remove 'routedns/client-blocklist.go': Permission denied
rm: cannot remove 'routedns/drop.go': Permission denied
rm: cannot remove 'routedns/cache.go': Permission denied
rm: cannot remove 'routedns/router.go': Permission denied
rm: cannot remove 'routedns/dohclient.go': Permission denied
rm: cannot remove 'routedns/README.md': Permission denied
rm: cannot remove 'routedns/doqlistener.go': Permission denied
rm: cannot remove 'routedns/ecs-modifier.go': Permission denied
rm: cannot remove 'routedns/failback_test.go': Permission denied
rm: cannot remove 'routedns/dnsclient_test.go': Permission denied
rm: cannot remove 'routedns/lru-cache_test.go': Permission denied
rm: cannot remove 'routedns/static_test.go': Permission denied
rm: cannot remove 'routedns/example_test.go': Permission denied
rm: cannot remove 'routedns/response-blocklist-ip.go': Permission denied
rm: cannot remove 'routedns/dotclient.go': Permission denied
rm: cannot remove 'routedns/go.sum': Permission denied
rm: cannot remove 'routedns/blocklistdb-hosts.go': Permission denied
rm: cannot remove 'routedns/logger.go': Permission denied
rm: cannot remove 'routedns/cidr-db.go': Permission denied
rm: cannot remove 'routedns/blocklistdb-domain.go': Permission denied
rm: cannot remove 'routedns/fastest.go': Permission denied
rm: cannot remove 'routedns/resolver_test.go': Permission denied
rm: cannot remove 'routedns/testdata/client.crt': Permission denied
rm: cannot remove 'routedns/testdata/server.key': Permission denied
rm: cannot remove 'routedns/testdata/client.key': Permission denied
rm: cannot remove 'routedns/testdata/server.crt': Permission denied
rm: cannot remove 'routedns/testdata/ca.key': Permission denied
rm: cannot remove 'routedns/testdata/DigiCertECCSecureServerCA.pem': Permission denied
rm: cannot remove 'routedns/testdata/ca.crt': Permission denied
rm: cannot remove 'routedns/pipeline_test.go': Permission denied
rm: cannot remove 'routedns/resolver.go': Permission denied
rm: cannot remove 'routedns/blocklistdb-hosts_test.go': Permission denied
rm: cannot remove 'routedns/rate-limiter.go': Permission denied
rm: cannot remove 'routedns/router_test.go': Permission denied
rm: cannot remove 'routedns/adminlistener.go': Permission denied
rm: cannot remove 'routedns/doqclient.go': Permission denied
rm: cannot remove 'routedns/dtlslistener.go': Permission denied
rm: cannot remove 'routedns/doc.go': Permission denied
rm: cannot remove 'routedns/response-blocklist-name.go': Permission denied
rm: cannot remove 'routedns/dnsclient.go': Permission denied
rm: cannot remove 'routedns/errors.go': Permission denied
rm: cannot remove 'routedns/.git/objects/pack/pack-6395ad13b0ee007001fa960f17c0b13ccb504358.idx': Permission denied
rm: cannot remove 'routedns/.git/objects/pack/pack-6395ad13b0ee007001fa960f17c0b13ccb504358.pack': Permission denied
rm: cannot remove 'routedns/.git/objects/info': Permission denied
rm: cannot remove 'routedns/.git/logs/HEAD': Permission denied
rm: cannot remove 'routedns/.git/logs/refs/remotes/origin/HEAD': Permission denied
rm: cannot remove 'routedns/.git/logs/refs/heads/master': Permission denied
rm: cannot remove 'routedns/.git/index': Permission denied
rm: cannot remove 'routedns/.git/FETCH_HEAD': Permission denied
rm: cannot remove 'routedns/.git/info/exclude': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-rebase.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/post-update.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/prepare-commit-msg.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/commit-msg.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/update.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-commit.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-push.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-receive.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-merge-commit.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/fsmonitor-watchman.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/pre-applypatch.sample': Permission denied
rm: cannot remove 'routedns/.git/hooks/applypatch-msg.sample': Permission denied
rm: cannot remove 'routedns/.git/config': Permission denied
rm: cannot remove 'routedns/.git/HEAD': Permission denied
rm: cannot remove 'routedns/.git/description': Permission denied
rm: cannot remove 'routedns/.git/refs/remotes/origin/HEAD': Permission denied
rm: cannot remove 'routedns/.git/refs/tags': Permission denied
rm: cannot remove 'routedns/.git/refs/heads/master': Permission denied
rm: cannot remove 'routedns/.git/packed-refs': Permission denied
rm: cannot remove 'routedns/.git/ORIG_HEAD': Permission denied
rm: cannot remove 'routedns/.git/branches': Permission denied
rm: cannot remove 'routedns/blocklistdb-regexp.go': Permission denied
rm: cannot remove 'routedns/net-resolver.go': Permission denied
rm: cannot remove 'routedns/route.go': Permission denied
rm: cannot remove 'routedns/go.mod': Permission denied
rm: cannot remove 'routedns/Dockerfile': Permission denied
rm: cannot remove 'routedns/blocklistloader-http.go': Permission denied
rm: cannot remove 'routedns/vars.go': Permission denied
rm: cannot remove 'routedns/roundrobin_test.go': Permission denied
rm: cannot remove 'routedns/failrotate_test.go': Permission denied
rm: cannot remove 'routedns/validate.go': Permission denied
rm: cannot remove 'routedns/dohclient_test.go': Permission denied
rm: cannot remove 'routedns/blocklistloader.go': Permission denied
rm: cannot remove 'routedns/ip-db-multi.go': Permission denied
rm: cannot remove 'routedns/padding_test.go': Permission denied
rm: cannot remove 'routedns/blocklistloader-local.go': Permission denied
rm: cannot remove 'routedns/fastest_test.go': Permission denied
rm: cannot remove 'routedns/cmd/routedns/routedns.service': Permission denied
rm: cannot remove 'routedns/cmd/routedns/main.go': Permission denied
rm: cannot remove 'routedns/cmd/routedns/config.go': Permission denied
rm: cannot remove 'routedns/cmd/routedns/resolver.go': Permission denied
rm: cannot remove 'routedns/cmd/routedns/.gitignore': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/mutual-tls-doh-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doh-quic-server.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/restricted-listener.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-dns.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-4.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-minimize.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/dtls-server.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/client-blocklist.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/mutual-tls-doh-server.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/rfc8482.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-collapse.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-name-resolver.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/bootstrap-resolver.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/mutual-tls-dot-server.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-allow.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-ip.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-ip-resolver.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-5-server.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/cidr.txt': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/location.txt': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/server.key': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-geo.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doq-client-simple.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/client-blocklist-drop.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/client-blocklist-refused.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/block-split-cache.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-regexp.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/client-blocklist-geo.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/domains.txt': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/server-ec.key': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doh-quic-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doh-behind-proxy.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/edns0-modifier.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doh-quic-client-local.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/mutual-tls-dot-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/ttl-modifier.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/server-ec.crt': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doq-listener.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/family-browsing.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-hosts.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-config/resolvers.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-config/README.md': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-config/listeners.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-config/blocklist.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/split-config/cache.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-1.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-2.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-6.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-name.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/server.crt': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/walled-garden.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/simple-dot-proxy.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/ecs-modifier-add.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/simple-dot.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/random-resolver.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-domain.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/ecs-modifier-delete.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/fastest.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-local.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/admin.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-remote.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/simple-dot-cache.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/doq-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/dtls-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-ip-remote.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/ecs-modifier-privacy.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/use-case-5-client.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/response-blocklist-name-remote.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-remote-cache.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/simple-doh.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/router.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/well-known.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/rate-limiter.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/cache.toml': Permission denied
rm: cannot remove 'routedns/cmd/routedns/example-config/blocklist-resolver.toml': Permission denied
rm: cannot remove 'routedns/dtls.go': Permission denied
rm: cannot remove 'routedns/dohlistener.go': Permission denied
rm: cannot remove 'routedns/message.go': Permission denied
rm: cannot remove 'routedns/response-collapse.go': Permission denied
rm: cannot remove 'routedns/failback.go': Permission denied
rm: cannot remove 'routedns/blocklistdb.go': Permission denied
rm: cannot remove 'routedns/route_test.go': Permission denied
rm: cannot remove 'routedns/blocklistdb-multi.go': Permission denied
rm: cannot remove 'routedns/replace_test.go': Permission denied
rm: cannot remove 'routedns/lru-cache.go': Permission denied
rm: cannot remove 'routedns/response-minimize.go': Permission denied
rm: cannot remove 'routedns/tls.go': Permission denied
rm: cannot remove 'routedns/pipeline.go': Permission denied
rm: cannot remove 'routedns/random.go': Permission denied
rm: cannot remove 'routedns/geoip-db.go': Permission denied
rm: cannot remove 'routedns/listener.go': Permission denied
rm: cannot remove 'routedns/dotclient_test.go': Permission denied
rm: cannot remove 'routedns/ttl-modifier.go': Permission denied
rm: cannot remove 'routedns/edns0-modifier.go': Permission denied

----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :/home/charlieporth1_gmail_com/Pihole-Slave-Install:
________________________________________________________________________________________________________________

^C
12:05:11:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ nano .pre-commit-hook.sh 
12:05:19:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git commit -m "Changed hook"

----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :/home/charlieporth1_gmail_com/Pihole-Slave-Install:
________________________________________________________________________________________________________________

git pus
----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :/home/charlieporth1_gmail_com/Pihole-Slave-Install:
________________________________________________________________________________________________________________

h
----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :/home/charlieporth1_gmail_com/Pihole-Slave-Install:
________________________________________________________________________________________________________________


----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :/home/charlieporth1_gmail_com/Pihole-Slave-Install:
________________________________________________________________________________________________________________


----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :/home/charlieporth1_gmail_com/Pihole-Slave-Install:
________________________________________________________________________________________________________________

^C
12:05:29:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ nano .pre-commit-hook.sh 
12:06:21:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git update-index --refresh 
.pre-commit-hook.sh: needs update
12:06:22:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git diff-index --quiet HEAD --
12:06:22:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ 
12:06:22:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git diff-index --quiet HEAD --
12:06:24:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ nano .pre-commit-hook.sh 
12:06:54:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git diff-index --quiet HEAD -- || echo "untracked"; /
untracked
cd -- /
12:06:54:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:/$ cd ~/Pihole-Slave-Install/
12:07:01:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ nano .pre-commit-hook.sh 
12:08:14:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ ls
LICENSE    apply_config.sh  config          install.sh       links.sh  master  reload_ctp-dns.sh    setup      vpn.ctptech.dev.der
README.md  bash_rc_sample   copy_config.sh  install.sh.save  lists     prog    restart_services.sh  update.sh
12:08:16:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ ls -a
.   .git                   .pre-commit-hook.sh  LICENSE    apply_config.sh  config          install.sh       links.sh  master  reload_ctp-dns.sh    setup      vpn.ctptech.dev.der
..  .install-args-proc.sh  .project_env.sh      README.md  bash_rc_sample   copy_config.sh  install.sh.save  lists     prog    restart_services.sh  update.sh
12:08:24:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git add .
12:08:29:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ git commit -m "Auto commit tracking test"

----------------------------------------------------------------------------------------------------------------
Make sure the root install dir is a full path and not a short path. This is very important to a correct install!
----------------------------------------------------------------------------------------------------------------
ROOT INSTALL DIR SCRIPT_DIR :/home/charlieporth1_gmail_com/Pihole-Slave-Install:
________________________________________________________________________________________________________________

Copied extenal config files
[master 79a8109] Auto commit tracking test
 2 files changed, 8 insertions(+), 7 deletions(-)
 delete mode 160000 routedns
12:12:39:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ sudo nano /home/charlieporth1_gmail_com/Programs/set_fail2ban-defaults.sh 
12:14:42:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ sudo nano /home/charlieporth1_gmail_com/Programs/all
all-scripts-exports.sh                     allow-dns.sh                               allow-youtube-but-not-youtube-ads.test.sh  
allow-dns-out.sh                           allow-youtube-but-not-youtube-ads.sh       
12:14:42:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ sudo nano /home/charlieporth1_gmail_com/Programs/all-scripts-exports.sh 
^[[A^[[A12:15:08:2500772:174.53.130.17:charlieporth1_gmail_com@ctp-vpn:~/Pihole-Slave-Install$ sudo nano /home/charlieporth1_gmail_com/Programs/set_fail2ban-defaults.sh 

  GNU nano 4.8                                                          /home/charlieporth1_gmail_com/Programs/set_fail2ban-defaults.sh                                                           Modified  
172.58.16.0/21
172.58.168.0/21
172.58.184.0/21
172.58.200.0/21
172.58.216.0/21
172.58.224.0/21
172.58.232.0/21
172.58.24.0/21
172.58.32.0/21
172.58.40.0/21
172.58.56.0/21
172.58.64.0/21
172.58.72.0/21
172.58.80.0/21
172.58.8.0/21
172.58.88.0/21
172.58.96.0/21
174.141.208.0/20
206.29.188.0/23
206.29.190.0/23
208.54.0.0/17
208.54.100.0/22
208.54.104.0/24
208.54.108.0/22
208.54.112.0/24
208.54.117.0/24
208.54.127.0/24
208.54.128.0/19
208.54.134.0/23
208.54.136.0/23
208.54.138.0/23
208.54.140.0/23
208.54.142.0/24
208.54.143.0/24
208.54.144.0/20
208.54.145.0/24
208.54.147.0/24
208.54.153.0/24
208.54.16.0/24
208.54.17.0/24
208.54.18.0/24
208.54.19.0/24
208.54.20.0/24
208.54.2.0/24
208.54.33.0/24
208.54.34.0/24
208.54.35.0/24
208.54.36.0/24
208.54.37.0/24
208.54.39.0/24
208.54.40.0/24
208.54.4.0/24
208.54.44.0/24
208.54.5.0/24
208.54.66.0/24
208.54.67.0/24
208.54.70.0/24
208.54.7.0/24
208.54.74.0/24

