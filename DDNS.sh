#!/bin/bash
# 
# Usage: ./dynIPupdate.sh [options] ... <Update URL>
# 
# Options:
# 	-h:
# 			This help message.
# 
# 	-v:
# 			Version information.
# 
# 	-q:
# 			Quiet operation; only report errors and updates.  This
# 			is the default when not run in an interactive shell.
# 
# 	-d <subdomain>:
# 			This option updates the specified DNS subdomain record
# 			on a remote server or localhost.  This gives the ability
# 			to resolve the external address to a local DNS name from
# 			with the LAN even where the DNS server gives local
# 			addresses for global domain names.
# 
# 	-s <DNS Server>:
# 			The DNS server to update, if not specified localhost
# 			is used.
# 
# 	-y <[hmac:]keyname:secret>:
# 			The key/secret for the DNS server, passed through to
# 			nsupdate.
# 
# 	-k <keyfile>:
# 			The file containing the key for the DNS server, passed
# 			through to nsupdate.
# 
# 	-t <iproute2 table>:
# 			The default rt_table 254 (main) is used if unspecified.
# 			If you have multiple routes to the Internet, you can
# 			specify the rt_table associated with that route either
# 			by name or number.
# 
# 
# 	The <Update URL> can instead be defined in UPDATE_URL and optionally the
# 	other enviroment variables listed below.
# 
# The following environment variables can be used:
# 	UPDATE_URL
# 	DNS_SUBDOMAIN
# 	DNS_SERVER
# 	DNS_SECRET
# 	DNS_KEYFILE
# 	RT_TABLE
# 
# Exit codes:
# 	0	Completed sucessfully
# 
# 	1	Invocation error
# 
# 	2	Interface is down
# 
# 	3	Invalid update URL or afraid.org is unreachable
# 
# 	10	Missing program binary
# 
# 	20	Local network DNS server update failed
#

VERSION="1.2.5"
COPYRIGHT="(c) 2004-2010 Steven Newbury <steve@snewbury.org.uk>"
LICENSE="Distributed under the GNU GPL http://www.gnu.org/licenses/gpl.html"
tty -s
QUIET=$?

# Functions
print_msg() {
	if [[ "$#" -gt "1" ]]; then 
		case "${1}" in
			notice)	echo -e "$2"
			;;
			error)	echo -e "$2" >&2
			;;
			info)	[[ "${QUIET}" == 0 ]] && echo -e "$2"
			;;
		esac
	else
		[[ "${QUIET}" == 0 ]] && echo -e "$1"	
	fi
}

version_info() {
	print_msg "\e[32;01mfreedns.afraid.org Dynamic DNS Updater v${VERSION}\e[0m\n"
	print_msg "\e[34;01m${COPYRIGHT}\e[0m\n"
	print_msg "\e[34;01m${LICENSE}\e[0m\n"
}

usage_info() {
	print_msg "\nUsage: $0 [options] ... <Update URL>\n"
	print_msg "Options:"
	print_msg "\t-h:\n\t\t\tThis help message.\n"
	print_msg "\t-v:\n\t\t\tVersion information.\n"
	print_msg "\t-q:\n\t\t\tQuiet operation; only report errors and updates.  This"
	print_msg "\t\t\tis the default when not run in an interactive shell.\n"
	print_msg "\t-d <subdomain>:\n\t\t\tThis option updates the specified DNS subdomain record"
	print_msg "\t\t\ton a remote server or localhost.  This gives the ability"
	print_msg "\t\t\tto resolve the external address to a local DNS name from"
	print_msg "\t\t\twith the LAN even where the DNS server gives local"
	print_msg "\t\t\taddresses for global domain names.\n"
	print_msg "\t-s <DNS Server>:\n\t\t\tThe DNS server to update, if not specified localhost"
	print_msg "\t\t\tis used.\n"
	print_msg "\t-y <[hmac:]keyname:secret>:\n\t\t\tThe key/secret for the DNS server, passed through to"
	print_msg "\t\t\tnsupdate.\n"
	print_msg "\t-k <keyfile>:\n\t\t\tThe file containing the key for the DNS server, passed"
	print_msg "\t\t\tthrough to nsupdate.\n"
	print_msg "\t-t <iproute2 table>:\n\t\t\tThe default rt_table 254 (main) is used if unspecified."
	print_msg "\t\t\tIf you have multiple routes to the Internet, you can"
	print_msg "\t\t\tspecify the rt_table associated with that route either"
	print_msg "\t\t\tby name or number.\n"
	print_msg ""
	print_msg "\tThe <Update URL> can instead be defined in UPDATE_URL and optionally the"
	print_msg "\tother enviroment variables listed below."
	print_msg ""
	print_msg "The following environment variables can be used:"
	print_msg "\tUPDATE_URL"
	print_msg "\tDNS_SUBDOMAIN"
	print_msg "\tDNS_SERVER"
	print_msg "\tDNS_SECRET"
	print_msg "\tDNS_KEYFILE"
	print_msg "\tRT_TABLE"
	print_msg ""
	print_msg "Exit codes:"
	print_msg "\t0\tCompleted sucessfully\n"
	print_msg "\t1\tInvocation error\n"
	print_msg "\t2\tInterface is down\n"
	print_msg "\t3\tInvalid update URL or afraid.org is unreachable\n"
	print_msg "\t10\tMissing program binary\n"
	print_msg "\t20\tLocal network DNS server update failed\n"
}

error_out() {
	local level
	[[ -n "$2" ]] && level="$2" || level="error"
	case $1 in
		1)  print_msg ${level} "\nError: An <Update URL> is required!"
		    usage_info
		    ;;
		2)  print_msg ${level} "\nError: Internet interface is down!"
		    ;;
		3)  print_msg ${level} "\nError: Check the UPDATE_URL is correct!"
		    ;;
		10) print_msg ${level} "\nError: This program needs ${binary}; if installed define the location in ${binvar}."
		    ;;
		20) print_msg ${level} "\nError: Failed to update internal DNS server @${DNS_SERVER}!"
		    ;;
		50) usage_info
		    ;;
		100) version_info
		    ;;
	esac
	if [[ "$1" -lt 20 && "${level}" != "notice" ]]; then
		 print_msg ${level} "\n$0: Failed to update afraid.org Dynamic DNS record!"
		exit $1
	else
		exit 0
	fi
}

update_dns() {
	print_msg info "\tusing local IP address \e[36;01m${local_ip}\e[0m on interface \e[36;01m${inet_if}\e[0m"
	reply=$("$CURL" -m 30 -s --noproxy afraid.org \
			 --interface "${local_ip}" "${UPDATE_URL}")
	exit_state="$?"
	if (( "${exit_state}" == 0 )); then
		case "${reply}" in
			Updated) dyn_ip=$(echo "${reply}" \
				 	| "${SED}" '/.*to /!d;s///;s/ .*//')
				 UPDATED_HOSTS=$(echo "${reply}" | "${SED}" '/.*host(s) /!d;s///;s/ to.*//;s/, /\n\t/g;s/^/\t/')
				 print_msg notice "\nDynamic DNS for:\n${UPDATED_HOSTS}\n\nUpdated successfully!"
				 print_msg notice "\nNew External IP Address: ${dyn_ip}\n"

				 ;;
			fail)    print_msg error "\nDynamic DNS update failed!\n"
			         error_out 3
			         ;;

			*)       dyn_ip=$(echo "${reply}" | "${SED}" '/.*ess /!d;s///;s/ .*//')
			         print_msg info "\n\e[32;01mDynamic DNS not changed.\e[0m\n"
			         ;;
		esac
		print_msg info "Current IP addresses:\n"
		print_msg info "\tExternal: \n\t\e[36;01m${dyn_ip}\e[0m\n"
		print_msg info "\tLocal: \n\t\e[36;01m${local_ip}\e[0m\n"
		print_msg info "\tGateway: \n\t\e[36;01m${gateway_ip}\e[0m\n"
		if [[ -n "${DNS_SUBDOMAIN}" ]]; then
			print_msg info "\tCurrent IPv4 DNS record(s) for ${DNS_SUBDOMAIN}:\n\t\e[36;01m$(host -t A ${DNS_SUBDOMAIN} | ${SED} 's/.*address \(.*\)/\1/g'|xargs)\e[0m\n"
			if [[ $("${HOST}" -t A "${DNS_SUBDOMAIN}" \
					| ${SED} 's/.*address \(.*\)/\1/g') \
					!= "${dyn_ip}" ]]; then
				print_msg notice "\tUpdating local DNS record: \t${DNS_SUBDOMAIN}\n"
				#echo "${NSUPDATE}" $([[ -n "${DNS_SECRET}" ]] && echo "-y ${DNS_SECRET}") $([[ -n "${DNS_KEYFILE}" ]] && echo "-k ${DNS_KEYFILE}")
				cat <<EOF | "${NSUPDATE}" \
					$([[ -n "${DNS_SECRET}" ]] \
					&& echo "-y ${DNS_SECRET}") \
					$([[ -n "${DNS_KEYFILE}" ]] \
					&& echo "-k ${DNS_KEYFILE}") \
					&>/dev/null
server ${DNS_SERVER}
zone ${DNS_SUBDOMAIN#*.}
update delete ${DNS_SUBDOMAIN} A
send
update add ${DNS_SUBDOMAIN} 60 A ${dyn_ip}
send
EOF

				[[ "$?" == 0 ]] || error_out 20
				print_msg info "\tNew IPv4 DNS record(s) for ${DNS_SUBDOMAIN}:\n\t\e[36;01m$(host -t A ${DNS_SUBDOMAIN} | ${SED} 's/.*address \(.*\)/\1/g'|xargs)\e[0m\n"

			else
				print_msg info "\n\e[32;01mDNS server record is up to date; no update needed.\e[0m\n"
			fi
		fi
		
		if [[ -n "${dyn_ip}" ]]; then
			if [[ "${local_ip}" != "${dyn_ip}" ]]; then
				print_msg info "\n\e[33;01mNote: Your external IP address as seen from the Internet"
				print_msg info "differs from your local IP address.  This is most likely"
				print_msg info "due to having a router/firewall acting as a gateway"
				print_msg info "between this machine and the Internet.  In order to provide"
				print_msg info "access to services on this machine, forwarding rules will"
				print_msg info "need to be established on the firewall.\e[0m"
			fi
		fi

		exit 0
	else
		print_msg info "\n\e[33;01mATTENTION: Dynamic IP address update FAILED for ${local_ip}\e[0m"
		print_msg info "\e[33;01m\t\t...trying next address for interface ${inet_if} (if any)...\e[0m"
	fi
}

check_bin() {
	local binvar="$1" binary="$2"
	[[ -z "${!binvar}" ]] && eval "${binvar}"="${binary}"
	[[ -x "${!binvar}" ]] || error_out 10
}

# Parse arguments and setup environment
[[ -z "${1}" ]] && error_out 1 error

while getopts  ":hvqu:d:t:y:k:s:" flag; do
	case "${flag}" in
		u)	UPDATE_URL="${OPTARG}"
		;;
		d)	DNS_SUBDOMAIN="${OPTARG}"
		;;
		t)	RT_TABLE="${OPTARG}"
		;;
		y)	DNS_SECRET="${OPTARG}"
		;;
		k)	if [[ -f "${OPTARG}" ]]; then
				DNS_KEYFILE="${OPTARG}"
			else
				print_msg info "Keyfile: ${OPTARG}: not found!"
				error_out 50
			fi
		;;
		s)	DNS_SERVER="${OPTARG}"
		;;
		q)	QUIET=1
		;;
		h)	error_out 50 notice
		;;
		v)	error_out 100 notice
		;;
		*)	print_msg error "Unknown option: -${OPTARG}"
			error_out 50 error
		;;
	esac
done

[[ -n "${!OPTIND}" ]] && UPDATE_URL="${!OPTIND}"
[[ -z "${RT_TABLE}" ]] && RT_TABLE="main" # iproute2 table number or name
[[ -z "${DNS_SERVER}" ]] && DNS_SERVER="localhost"
[[ -z "${UPDATE_URL}" ]] && error_out 50

# Program locations
check_bin CURL "/usr/bin/curl"
check_bin IP "/sbin/ip"
check_bin SED "/bin/sed"
if [[ -n "${DNS_SUBDOMAIN}" ]]; then
	check_bin NSUPDATE "/usr/bin/nsupdate"
	check_bin HOST "/usr/bin/host"
fi

# All OK? Then let's go...
version_info

DEFAULT_GATEWAY=$("${IP}" route show table "$RT_TABLE" \
		| "${SED}" '/.*default via /!d;s/\/.*//')
inet_if=$(echo "${DEFAULT_GATEWAY}" | "${SED}" '/.*dev /!d;s///;s/ .*//')
gateway_ip=$(echo "${DEFAULT_GATEWAY}" | "${SED}" '/.*via /!d;s///;s/ .*//')

if ! ("${IP}" link show "${inet_if}" 2>&1 | grep "UP" &>/dev/null); then
	error_out 2
fi

print_msg info "Detected route to external network:"

for local_ip in $("${IP}" addr show "${inet_if}" \
		| "${SED}" '/.*inet /!d;s///;s/ .*//;s/\/.*//'); do
	update_dns; done

error_out 3
