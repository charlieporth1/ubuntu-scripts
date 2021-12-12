#!/usr/bin/env bash
count=3
timeout=12
router=your.router.ip.here

test_ip=1.1.1.1
test_dns=one.one.one.one

sysctl -w net.ipv6.conf.all.forwarding=1
sysctl -w net.ipv4.ip_forward=1


function iface_restart() {
        local iface="$1"
        sudo ip link set $iface up
        sudo ip link set $iface down
        sudo ip addr flush $iface
        sudo ip link set $iface up
        sudo dhclient -r
        (
                sudo dhclient -s $router
        )&
        sudo netplan generate
        sudo netplan apply
}
function run_test_iface() {
        local iface="${1:-eth0}"
        
        if ! ifconfig | grep -o $iface > /dev/null
        then
                echo "$iface not found"
                iface_restart $iface
        elif ! ping -c $count -w $timeout $router -I $iface > /dev/null
        then
                echo "Router not ping $router"
                iface_restart $iface
        elif ! ping -c $count -w $timeout $test_ip  -I $iface > /dev/null
        then
                echo "Test not ping $test_ip"
                iface_restart $iface
        elif ! ping -c $count -w $timeout $test_dns -I $iface > /dev/null
        then
                echo "Test not ping $test_dns"
                iface_restart $iface
        fi
}
iface=eth0
run_test_iface eth0
run_test_iface eth1
run_test_iface eth2
run_test_iface wlan0
#iface=eth1 // etc
#run_test_iface eth1
