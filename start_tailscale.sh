#!/bin/bash
source /etc/environment
source $PROG/all-scripts-exports.sh
declare -xg ADDITONAL_ROUTES=""
declare -xg ADDITONAL_TAGS=""
GCP_AWS_ROUTE="10.128.0.0/20,$AWS_ROUTE"
AWS_ROUTE="172.31.0.0/20"

GCP_FREE_ROUTE="10.138.0.0/20"
GCP_ROUTE_1="10.128.0.0/20"
GCP_PAID_ROUTE="$GCP_ROUTE_1,192.168.99.0/24"
GCP_ALL_ROUTE="$GCP_PAID_ROUTE,$GCP_FREE_ROUTE"

CCAST_ROUTE="192.168.44.0/24"
TMOAIL_ROUTE="192.168.12.0/24"
HOME_ROUTE="$CCAST_ROUTE,$TMOAIL_ROUTE"

ALT_HOME_ROUTE_0="192.168.43.0/24"
ALT_HOME_ROUTE_1="192.168.42.0/24"
ALT_HOME_ROUTE_2="192.168.41.0/24"
ALT_HOME_ROUTE_3="192.168.100.0/24"
ALT_HOME_ROUTE_4="192.168.1.0/24"
ALL_HOME_ROUTE="$HOME_ROUTE,$ALT_HOME_ROUTE_0,$ALT_HOME_ROUTE_1,$ALT_HOME_ROUTE_2,$ALT_HOME_ROUTE_3,$ALT_HOME_ROUTE_4"

ALL_ROUTES="$AWS_ROUTE,$GCP_ALL_ROUTE,$ALL_HOME_ROUTE"

declare -a routes_arrary=$(decsvify "$ALL_ROUTES")

(
	sudo apt -y update
	sudo apt install -y tailscale ifmetric wireguard wireguard-tools wireguard-dkms
	curl -sSL "https://raw.githubusercontent.com/ipinfo/cli/master/range2cidr/deb.sh" | bash
	curl -sSL "https://raw.githubusercontent.com/ipinfo/cli/master/cidr2range/deb.sh" | bash

	if ! command -v grepip &> /dev/null
	then
	    echo "COMMAND grepip could not be found installing"
	    curl -Ls 'https://raw.githubusercontent.com/ipinfo/cli/master/grepip/deb.sh' | bash
	fi

	if ! command -v dig &> /dev/null
	then
	    echo "COMMAND digcould not be found installing"
	    sudo apt install -y dnsutils bind9-dnsutils
	fi

	if ! command -v kdig &> /dev/null
	then
	    echo "COMMAND digcould not be found installing"
	    sudo apt install -y knot-resolver
	fi

	if ! command -v parallel &> /dev/null
	then
	    echo "COMMAND digcould not be found installing"
	    sudo apt install -y parallel
	fi

)&>/dev/null

function add_routes() {
	local route="$1"
	if [[ -z $ADDITONAL_ROUTES ]]; then
		ADDITONAL_ROUTES="$route"
	else
		ADDITONAL_ROUTES="$ADDITONAL_ROUTES,$route"
	fi
}

function route_router_substation(){
	local route="$1"
	local subnet=$(echo "$route" | awk -F'\.[0-9]/[0-9]' '{print $1}')
	local router=$(echo "$subnet.1")
	echo "$router"
}

function auto_routes() {
	for route in ${routes_arrary[@]}
	do
		local router=$(route_router_substation $route)
		for iface in $(bash $PROG/get_network_devices_names.sh)
		do
			if [[ `ip_exist $router 6 $iface` == true ]]; then
				add_routes $route
			fi
		done
	done
}

function add_tag() {
	local tag="$1"
	if [[ -z $ADDITONAL_TAGS ]]; then
		ADDITONAL_TAGS="tag:$tag"
	else
		ADDITONAL_TAGS="$ADDITONAL_TAGS,tag:$tag"
	fi
}

function tag_test() {
	local tag="$2"
	local port_and_or_ip="$1"
	local port=$(echo $port_and_or_ip | cut -f 2- -d ':')
        local port_status=`ss -alunt "sport = :$port" | grep -o "$port_and_or_ip" | sort -u`
	if [[ -n "$port_status" ]]; then
		add_tag "$tag"
	fi
}

function auto_tags() {
	tag_test 53 dns_tag
	tag_test 53 ctp-dns_tag
	tag_test 853 s-dns_tag
	tag_test 853 dot_tag
	tag_test 853 ctp-dot_tag
	tag_test 8853 doq_tag
	tag_test 784 doq_draft_1_tag
	tag_test 1784 doq_draft_2_tag
	tag_test 1443 doh_quic_tag
	tag_test 80 http_tag
	tag_test 443 https_tag
	tag_test 8443 alt_https_tag_1
	tag_test 2443 alt_https_tag_2
	tag_test 22 ssh_tag
}

function system_score() {
	system_stats

	local vm_timeout=4
	local IS_VM=$( timeout $vm_timeout facter is_virtual )

	local standard_nic_mx=16
	local standard_wl_mx=4

	if [[ $IS_VM == true ]]; then
		local default_ddr=4
		local default_nic=10000
		local default=1000
	else
		local default_ddr=2
		local default_nic=100
		local default=100
	fi

	local NIC_SPEEDS=$(bash $PROG/get_network_devices_names.sh | parallel sudo ethtool {} | grep -i speed | grep -oE '[0-9]+' || echo $(( $default_nic * $NIC_COUNT * $standard_nic_mx  )) )

	local DDR_VERSION=$(sudo dmidecode | grep -Eo 'DDR[0-9]' | grep -o '[0-9]' || echo $default_ddr )
	local DEFAULT_IFACE_SPEED=$(sudo ethtool $default_iface | grep -i speed | grep -oE '[0-9]+' || echo $default_nic )

	if [[ $DEFAULT_IFACE_SPEED -ge 2999 ]]; then
		local nic_mx=1000
	elif [[ $DEFAULT_IFACE_SPEED -ge 999 ]]; then
		local nic_mx=100
	else
		local nic_mx=1
	fi

	# System's smaller than 256 mb ram shouldn't really be used
	local OTHER_NIC_SCORE=$(( ( $(printf '%s\n' "$NIC_SPEEDS" | awk '{s+=$1} END {print s}') * $NIC_COUNT * $standard_nic_mx ) / 64 ))
	local WLAN_SCORE=$(( $WLAN_COUNT * $standard_wl_mx ))
	local DEFAULT_NIC_SCORE=$(( ( $DEFAULT_IFACE_SPEED * $nic_mx * $standard_nic_mx ) / 24 ))

	local NIC_SCORE=$(( $DEFAULT_NIC_SCORE + $OTHER_NIC_SCORE + $WLAN_SCORE ))
	local MEMORY_SCORE=$(( ( ( $MEM_COUNT / 256 ) * $DDR_VERSION ) / 32 ))

	local SYSTEM_SCORE=$(( ( $CPU_CORE_COUNT + $MEMORY_SCORE + $NIC_SCORE ) / 1024 ))
	echo $SYSTEM_SCORE
}

function system_metric() {
	local SYSTEM_SCORE=$(system_score)
	local METRIC_SCORE_SCALE=100000
	echo $SYSTEM_SCORE
#	echo $(( $METRIC_SCORE_SCALE - $SYSTEM_SCORE ))
}

if [[ "$HOSTNAME" =~ (ctp-vpn|ip-172-31-12-154|instance-1-ctp-vpn) ]]; then
	if [[ "$HOSTNAME" = 'ctp-vpn' ]]; then
		add_routes "$GCP_PAID_ROUTE"
	fi
	if [[ "$HOSTNAME" = 'instance-1-ctp-vpn' ]]; then
		add_routes "$GCP_FREE_ROUTE"
	else
		add_routes "$GCP_AWS_ROUTE"
	fi
elif [[ "$HOSTNAME" =~ (ubuntu-server|neat-xylophone|led-raspberrypi3|raspberrypi4) ]]; then
	add_routes "$HOME_ROUTE"
	auto_routes
else
	auto_routes
fi
#auto_tags

sudo modprobe tcp_htcp tcp_yeah tcp_highspeed tcp_scalable
sudo modprobe tcp_bbr
sudo modprobe wireguard
sudo modprobe curve25519-generic libcurve25519-generic libcurve25519
sudo modprobe sha3_generic
sudo modprobe ecdh_generic
sudo modprobe rsa-generic
sudo modprobe dummy veth vhost
sudo modprobe tunnel4 ipip udp_tunnel ip_tunnel ipcomp
sudo modprobe tls xt_tcpudp xt_cpu async_xor async_memcpy async_tx xor

sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=0

sudo sysctl -w net.ipv6.conf.all.forwarding=1
sudo sysctl -w net.ipv4.ip_forward=1

# HC HEALTH CHECK
fn=tailscaled
sudo systemctl is-failed $fn && sudo systemctl restart $fn

if [[ -n "$ADDITONAL_TAGS" ]]; then
	ADD_OPT1="--advertise-tags=$ADDITONAL_TAGS"
fi

DEFAULT_OPTS=""" \
	--accept-dns=false \
	--accept-routes=true \
	--advertise-exit-node=true \
	--netfilter-mode=on \
	--host-routes=true \
	--snat-subnet-routes=true \
	$ADD_OPT1


"""

if [[ -n "$ADDITONAL_ROUTES" ]]; then
	echo "Starting TailScale adding ROUTES $ADDITONAL_ROUTES"
	sudo tailscale up --advertise-routes=$ADDITONAL_ROUTES $DEFAULT_OPTS
else
	sudo tailscale up $DEFAULT_OPTS
fi

iface=tailscale0
sudo ifconfig $iface mtu 1500
sudo ifconfig $iface txqueuelen 90000
sudo ifconfig $iface multicast

T_METRIC=$(system_metric)
echo "Setting $iface metric to $T_METRIC"
sudo ifmetric $iface $T_METRIC

sudo systemd-resolve --set-mdns=yes --interface=tailscale0
# sudo ip route show table 52

