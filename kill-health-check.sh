#!/bin/bash
declare -a items
items=(
	'dns-st'
	'hea'
	'dns-stale'
	'health'
	'set_fail2ban'
	'pm.hea'
	'test_'
	'pm.stal'
	'test_dot.sh'
	'test_doq.sh'
	'test_doh.sh'
	'test_dns.sh'
	'test_dns_udp.sh'
	'test_dns_unbound.sh'
	'test_dnssec.sh'
	'test_dtls.sh'
	'server-online-check.sh'
)
grep_v="grep\|fail2ban\|nano\|tail\|routedns\|vi\|vim\|cat\|dnsmasq\|kill-health-check.sh\|pgrep\|$0\|sqlite3"
for i in "${items[@]}"
do
	proc_count=`ps -aux | grep "${i}" | grep -v "${grep_v}"  | awk '{print $2}' | grep -cE '[0-9]+'`
	if [[ $proc_count -gt 3 ]]; then
		echo "More killing $proc_count $i"
#		items_to_kill=`bash $PROG/grepify.sh "${items[@]}"`
#		echo "Search for ${items_to_kill}"
		ps -aux | grep "${i}" | grep -v "${grep_v}" | awk '{print $2}' | xargs sudo kill
		ps -aux | grep "${i}" | grep -v "${grep_v}" | awk '{print $2}' | xargs sudo kill -9
		ps -aux | grep "${i}" | grep -v "${grep_v}" | awk '{print $2}' | xargs sudo kill -8
		ps -aux | grep "${i}" | grep -v "${grep_v}" | awk '{print $2}' | xargs sudo kill -7
		echo "done killing"
	else
		echo "not enought"
	fi
done
sudo killall -9 ps dig go pgrep awk grep cpulimit kdig doh doq q

if [[ -f /tmp/health-checks.stop.lock ]]; then
	sudo rm -rf /tmp/health-checks.stop.lock
fi
