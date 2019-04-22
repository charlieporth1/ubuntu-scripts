#!/usr/bin/parallel -j+32 --shebang-wrap --pipe /bin/bash

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors
#alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
bigprograms="dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n"
#fi
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
#alias df='df -h'
alias ls='ls --color=auto -b'
alias lm="ls --color=auto -mb"
alias li="ls --color=auto -ib"
alias lsn="ls --color=auto -nb"
alias lb="ls --color=auto -b"
alias lla="ls --color=auto -lab"
alias lsh="ls --color=auto -shb"
alias lsha="ls --color=auto -shab"
alias llsha="ls --color=auto -lshab"
alias lA="ls --color=auto -Ab"
alias lg="ls --color=auto -gb"
alias lo="ls --color=auto -ob"
alias lo="ls --color=auto -ob"
alias llauthor="ls --color=auto -lb --author"
alias lx="ls -b --color=auto -xb"
alias lssize="ls -b --sort=size  --color=auto"
alias lstime="ls -b --sort=time  --color=auto"
alias lsversion="ls -b --sort=version   --color=auto"
alias lss="ls -sb --color=auto"
alias lst="ls -tb  --color=auto"
alias lsv="ls -vb --color=auto"
alias lstime="ls -l --time-style=+%H:%M:%D"
alias lstimefull="ls -l --time-style=full-iso"
alias lstimelong="ls -l --time-style=long-iso"
alias lstimeiso="ls -l --time-style=iso"
#alias lstimelocale="ls -l --time-style=locale"
alias lstimeD="ls -l --time-style=+%H:%M:%S:%D"
alias lstimefull="ls --full-time"

alias spider="wget --spider -r $1"

alias reloadb='source ~/.bashrc'
alias reloada='source ~/.bash_aliases'
alias reloade='source ~/.bash_exports'
alias reloadf='source ~/.bash_func'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

alias cd...='cd ../../'
alias cd....='cd ../../../'
alias cd.....='cd ../../../../'
alias cd.4='cd ../../../../'
alias cd.5='cd ../../../../../'

alias sshdiplogs='grep "Failed password for" /var/log/auth.log | grep -Po "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" \| sort | uniq -c'
alias ls...='ls ../../'
alias ls....='ls ../../../'
alias ls.....='ls ../../../../'
alias ls.4='ls ../../../../'
alias ls.5='ls ../../../../..'

alias timer='date1=`date +%s`; while true; do    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";done'

alias ls='ls -GFh'

alias png2ico="/usr/bin/convert -resize x16 -gravity center -crop 16x16+0+0 input.png -flatten -colors 256 -background transparent output/favicon.ico"
alias lsdroot="bash /mnt/HDD/Programs/lsdroot.sh"
alias lsdusr="bash /mnt/HDD/Programs/lsdusr.sh"
alias lsd="echo Ubuntu|lolcat -a -d 500"
alias lsdrep="bash /mnt/HDD/Programs/lsdrep.sh"
alias lsdtrain='sl |lolcat'
alias lsdtrain1='sl --help|lolcat'
alias christmas="bash /mnt/HDD/programs/lsdcriss.sh"
alias christmaswindow="/mnt/HDD/Programs/lsdchristlist.sh"
alias lsdchrist="bash /mnt/HDD/Programs/lsdcriss.sh"
alias lsdchristlist="bash /mnt/HDD/Programs/lsdchristlist.sh"
alias lsdfix='echo |lolcat -a -d 2'
alias lsdfish='asciiquarium | lolcat'
alias lsdquarium='asciiquarium | lolcat'
alias lsdping='ping 192.168.1.1|lolcat '
alias lsdls='ls |lolcat'

alias fucking="sudo"
alias applesucks="while true; do echo $red apple $green is a $blue $(bitch); done"
alias applesuck="while true; do echo $red apple $green is a $blue $(bitch); done"

alias gitr='for x in $(find . -type d) ; do if [ -d "${x}/.git" ] ; then cd "${x}" ; origin="$(git config --get remote.origin.url)" ; cd - 1>/dev/null; echo git submodule add "${origin}" "${x}" ; fi ; done'
alias gitrs='for x in $(find . -type d) ; do if [ -d "${x}/.git" ] ; then cd "${x}" ; origin="$(git config --get remote.origin.url)" ; cd - 1>/dev/null; git submodule add "${origin}" "${x}" ; fi ; done'

alias googlecloud='gcloud compute --project "studioso-node-server" ssh --zone "us-central1-f" studiosodevelopment@bot'
alias cgooglecloud='gcloud compute --project "studioso-node-server" ssh --zone "us-central1-f" charlieporth@bot'
alias gcrallwer='gcloud compute --project "studioso-node-server" ssh --zone "us-central1-f" studiosodevepoment@crawller'
alias cbgooglecloud='gcloud compute --project "studioso-node-server" ssh --zone "us-central1-f" charlieporth@bot-1'
alias gnodejs='gcloud compute --project "studioso-node-server" ssh --zone "us-central1-f" studiosodevelopment@nodejs-1-vm'

alias grandma='ssh grandma' 
alias tegra-ubuntu='ssh tegra-ubuntu' 
alias ubuntuserver='ssh ubuntuserver' 
alias hex="cat /dev/random | hexdump" 

alias defcon="wget -q  http://www.defconwarningsystem.com/current/defcon.jpg &&  /usr/bin/ascii ./defcon.jpg && rm -rf ./defcon.jpg"

#Aliases that do things
alias ip='ipconfig getifaddr en0'
alias ipext='curl -s http://checkip.dyndns.org/ | grep -o '[0-9][0-9]*.[0-9][0-9]*.[0-9][0-9]*.[0-9]*''
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
#alias ll='ls -AlhGrti'
HOST='hostname'
alias cd..="cd .."
alias flushdns="dscacheutil -flushcache"
#alias ls='ls --color=auto'alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
#alias la='ls -a'
# install  colordiff package :)
#alias diff='colordiff'
alias ports='netstat -tulanp'
#alias apt-get="sudo apt-get"
alias updatey="sudo apt-get --yes"
alias bigfiles='du -hsx * | sort -rh | head -11'
alias top-commands='history | awk "{print $2}" | awk "{print $1}" |sort|uniq -c | sort -rn | head -10'

alias tu='top -o cpu' #cpu
alias tm='top -o vsize' #memory

alias startg="gcloud compute instances start bot"
alias stopg="gcloud compute instances stop bot "

## pass options to free ##
alias meminfo='free -m -l -t'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

## Get server cpu info ##
alias cpuinfo='lscpu'

## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##

## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
export G='G'
export o='o'
export g='g'
export l='l'
export e='e'
alias google='echo -e $blue$G$red$o$yellow$o$blue$g$green$l$red$e$nc is better than $white apple$nc'

alias star='echo ★ |lo︎cat -a -d 500'
alias tm='echo ™ |lolcat -a -d 500'
alias copyright='echo ©® |lolcat -a -d 500'
alias lucky1='echo ♧ ♣ |lolcat -a -d 500'
alias irish1='echo ♧ ♣  |lolcat -a -d 500'
alias male='echo ♂ |lolcat -a -d 500'
alias female='echo ♀ |lolcat -a -d 500'
alias commu='echo ☭ |lolcat -a -d 500'
alias emt='echo   |lolcat -a -d 500'
alias emt='echo ☤ |lolcat -a -d 500'
alias cross='echo ✝ |lolcat -a -d 500' 
alias warning='echo  |lolcat -a -d 500'
alias radioacive='echo ☢' |lolcat -a -d 500

alias ~="cd ~"                              # ~:            Go Home

alias cputemp='sensors | grep Core'
alias makepass='openssl rand -base64 32'


# Show Mounted info
alias mountedinfo='df -h'
#chmod train
alias mx='chmod a+x'
alias 000='chmod 000'
alias 400='chmod 400'
alias 644='chmod 644'
alias 755='chmod 755'


alias please="sudo !!"
# File size
alias fs="stat -f \"%z bytes\""
alias trimcopy="tr -d '\n' | pbcopy"

alias ls="ls --color=auto -b"
alias lm="ls --color=auto -m"

alias coolclock='watch -t -n1 "date +%T| figlet"'
alias cornerclock="while sleep 1;do tput sc;tput cup 0 $(($(tput cols)-29));date;tput rc;done &"

alias extip=" curl -s ipinfo.io/ip"
alias ipext=" curl -s ipinfo.io/ip"
alias loca="parallel -j32 --semaphore bash  | timeout 3 whereami"
alias llll="last  -2  --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '2p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  awk '{print $3}'"
alias lll="last -2 -R -w  | sed -n '2p' | cut -c 20- "
alias geo="whereami --f human "
alias disk="df -h | grep /dev/root"
alias disk1="df -h | grep /dev/sda"
alias matrix1='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'
#alias matrix2="perl -e '$|++; while (1) { print " " x (rand(35) + 1), int(rand(2)) }'"
#alias matrix3="perl -e '$|++; while (1) { print " " x (rand(35) + 1), int(rand(10)) }'"
alias cracking='while [ true ]; do head -n 100 /dev/urandom; sleep .1; done | hexdump -C | grep "ca fe"'
alias cracking2='cat /dev/urandom | hexdump -C | grep "ca fe"'
alias cracking3='cat /dev/urandom | hexdump -C'
alias cracking4="cat /dev/random | hexdump"
alias cracking5="cat /dev/random | hexdump -b"
alias cracking6="cat /dev/random | hexdump -c"
alias cracking7="cat /dev/random | hexdump -d"
alias cracking4='cat /dev/random | hexdump -C | grep --color=auto $(uuidgen | tr -d '-' | cut -b 1-2)'
alias crackingRandom="cat /dev/random | hexdump -C | grep --color=auto $(uuidgen | tr -d '-' | cut -b 1-2)"
alias crackingR="cat /dev/random | hexdump -C | grep --color=auto $(uuidgen | tr -d '-' | cut -b 1-2)"
alias crackingr="cat /dev/random | hexdump -C | grep --color=auto $(uuidgen | tr -d '-' | cut -b 1-2)"
alias crackingrandom="cat /dev/random | hexdump -C | grep --color=auto $(uuidgen | tr -d '-' | cut -b 1-2)"

alias loading='for i in {0..600}; do echo $i; sleep 1; done | dialog --gauge "Install..." 6 40'
alias hide2="base32"
alias hide4="base64"
alias hide1="rev"
alias hide2d="base32 --decode"
alias hide4d="base64 --decode"
alias hide1="rev"
alias loading1='for i in `seq 0 100`;do timeout 6 dialog --gauge "Install..." 6 40 "$i";done'
alias loading2='j=0;while true; do let j=$j+1; for i in $(seq 0 20 100); do echo $i;sleep 1; done | dialog --gauge "Install part $j : `sed $(perl -e "print int rand(99999)")"q;d" /usr/share/dict/words`" 6 40;done'
alias macaddressgen="date; cat /proc/interrupts) | md5sum | sed -r 's/^(.{10}).*$/\1/; s/([0-9a-f]{2})/\1:/g; s/:$//;"
alias whyismynetowrkslow="sudo nethogs -p eth0"
alias cpusaver="taskset -c 0 "
alias finddups="find -type f -exec md5sum '{}' ';' | sort | uniq --all-repeated=separate -w 33 | cut -c 35-"
alias findandrmdups="find -type f -exec md5sum '{}' ';' -delete| sort | uniq --all-repeated=separate -w 33 | cut -c 35- "
alias wifiqrcode='qrencode -s 7 -o qr-wifi.png "WIFI:S:$(zenity --entry --text="Network name (SSID)" --title="Create WiFi QR");T:WPA;P:$(zenity --password --title="Wifi Password");;"'
alias lastreboot='who -b'

alias ln="ln -r"
