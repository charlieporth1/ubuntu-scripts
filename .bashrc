#!/usr/bin/parallel -j+32 --shebang-wrap --pipe /bin/bash
#chmod 777 /home/ubuntuserubuntuseubuntuser/.parallel/semaphores
#rm -rf /home/ubuntuser/.parallel/semaphores/*

# ~/.bashrc: executed by bash(1) for non-login shells. see 
# /usr/share/doc/bash/examples/startup-files (in the package bash-doc) 
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth
#HISTCONTROL=ignoredups

# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups  
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# If set, the pattern "**" used in a 
#pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

#\d – Current date
#\t – Current time
#\h – Host name
#\# – Command number
#\u – User name
#\W – Current working directory (ie: Desktop/)
#\w – Current working directory with full path (ie: /Users/Admin/Desktop/)

#    \a     an ASCII bell character (07)
#    \d     the date in "Weekday Month Date" format (e.g., "Tue May 26")
#    \D{format}  the format is passed to strftime(3) and the result is inserted into the prompt string; an empty format results in a locale-specific
                # time representation.  The braces are required
#    \e     an ASCII escape character (033)
#    \h     the hostname up to the first `.'
#    \H     the hostname
#    \j     the number of jobs currently managed by the shell
#    \l     the basename of the shell's terminal device name
#    \n     newline
#    \r     carriage return
#    \s     the name of the shell, the basename of $0 (the portion following the final slash)
#    \t     the current time in 24-hour HH:MM:SS format
#    \T     the current time in 12-hour HH:MM:SS format
#    \@     the current time in 12-hour am/pm format
#    \A     the current time in 24-hour HH:MM format
#    \u     the username of the current user
#    \v     the version of bash (e.g., 2.00)
#    \V     the release of bash, version + patch level (e.g., 2.00.0)
#    \w     the current working directory, with $HOME abbreviated with a tilde (uses the value of the PROMPT_DIRTRIM variable)
#    \W     the basename of the current working directory, with $HOME abbreviated with a tilde
#    \!     the history number of this command
#    \#     the command number of this command
#    \$     if the effective UID is 0, a #, otherwise a $
#    \nnn   the character corresponding to the octal number nnn
#    \\     a backslash
#    \[     begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
#    \]     end a sequence of non-printing characters


#     \a     alert (bell)
#          \b     backspace
#          \e
#          \E     an escape character
#          \f     form feed
#          \n     new line
#          \r     carriage return
#          \t     horizontal tab
#          \v     vertical tab
#          \\     backslash
#          \'     single quote
#          \"     double quote
#          \nnn   the eight-bit character whose value is the octal value nnn (one to three digits)
#          \xHH   the eight-bit character whose value is the hexadecimal value HH (one or two hex digits)
#          \cx    a control-x character


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac




# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# Add bash exports.
if [ -f ~/.bash_exports ]; then
#echo this exports
    source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
#echo this is aliases
    . ~/.bash_aliases
fi

if [ -f ~/.bash_func ]; then
#echo this func
    source ~/.bash_func
fi
if [ -f ~/.bash_sudo ]; then
#echo this sudo 
    source ~/.bash_sudo
fi


function cdn(){ for i in `seq $1`; do cd ..; done;}
shopt -s dirspell             # change to named directory
#shopt -s xpg_echo             # change to named directory
shopt -s promptvars             # change to named directory
shopt -s progcomp             # change to named directory
#shopt -s progcomp_alias             # change to named directory
shopt -s histappend             # change to named directory
shopt -s globstar             # change to named directory
shopt -s dirspell             # change to named directory
shopt -s direxpand             # change to named directory
shopt -s complete_fullquote             # change to named directory
shopt -s compat40             # change to named directory
shopt -s compat32             # change to named directory
shopt -s compat31             # change to named directory
shopt -s autocd             # change to named directory
shopt -s checkwinsize       # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist            # save multi-line commands in history as single line
shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases     # expand aliases
shopt -s extglob            # enable extended pattern-matching features
shopt -s hostcomplete       # attempt hostname expansion when @ is at the beginning of a word
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s posix
#shopt -s nocaseglob         # wpathname expansion will be treated as case-insensitive




# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
## sources /etc/bash.bashrc).
#if [ ! shopt -oq posix ]; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
#echo this bash complete    
. /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
#echo this bash etc compelte 
   . /etc/bash_completion
  fi
#fi
#rm -rf /tmp/* &> /dev/null

#echo done with scritps
#export NVM_DIR="/home/ubuntuser/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#export extip=$(cuControlPersist 60mrl ipecho.net/plain ; echo)
#geoiplookup (last  -1 -i -w --time-format notime | grep -e  'ubuntuser\|logged in\|pts/*' | cut -c 19-39)
#export extip=$(dig +short myip.opendns.com @resolver1.opendns.com)
export extip=$(parallel -j16 --xargs --semaphoretimeout 2 bash | curl -s ipinfo.io/ip)
#echo done with curl
#geoiplookup  last  -2 -i -w --time-format notime | grep -e  'ubuntuser\|logged in\|pts/*' |  sed -n '2p' | cut -d " " -f12
#geoiplookup  $( last  -2 -i -w --time-format notime | grep -e  'ubuntuser\|logged in\|pts/*\|tty*' |  sed -n '2p' |  grep -e  'ubuntuser\|logged in\|pts/*\|tty*' | cut -b 19-38)
#lll=$(last  -2 -i -w --time-format notime | grep -e  'ubuntuser\|logged in\|pts/*' |  sed -n '2p' | cut -d " " -f12)
#llll=$(last  -2 -i -w --time-format notime | grep -e  'ubuntuser\|logged in\|pts/*\|tty*' |  sed -n '2p' |  grep -e  'ubuntuser\|logged in\|pts/*\|tty*')
#export llll=$(last  -2 -i -w --time-format notime | grep -e  'ubuntuser\|logged in\|pts/*\|tty*' |  sed -n '2p' |  grep -e  'ubuntuser\|logged in\|pts/*\|tty*' | cut -b 19-38)
export llll=$(last  -2  --time-format notime | grep -e  'ubuntuser\|logged in\|pts/*\|tty*' |  sed -n '2p' |  grep -e  'ubuntuser\|logged in\|pts/*\|tty*' |  awk '{print $3}')
export lll=$(last -2 -R -w  | sed -n '2p' | cut -c 20- | xargs)
export lastip4=$(last -4  --time-format notime | grep -e  'ubuntuser\|logged in\|pts/*\|tty*' |  sed -n '4p' |  grep -e  'ubuntuser\|logged in\|pts/*\|tty*' | awk '{print $3}')
export lastip3=$(last -3  --time-format notime | grep -e  'ubuntuser\|logged in\|pts/*\|tty*' |  sed -n '3p' |  grep -e  'ubuntuser\|logged in\|pts/*\|tty*' | awk '{print $3}')
#echo done with llll
#stty -echo
export mosh='0.0.0.0'
if [[ $llll  =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
	export llll=$(last -2 --time-format notime | grep -e 'ubuntuser\|logged in\|pts/*\|tty*' | sed -n '2p' | grep -e 'ubuntuser\|logged in\|pts/*\|tty*' |  awk '{print $3}')
	export lll=$(last -2 -R -w | sed -n '2p' | awk '{print $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9 " " $10}')
elif [[ $lastip3  =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
	#stty echo
	export llll=$(last -3 --time-format notime | grep -e 'ubuntuser\|logged in\|pts/*\|tty*' | sed -n '3p' | grep -e 'ubuntuser\|logged in\|pts/*\|tty*' | awk '{print $3}')
	export lll=$(last -3 -R -w | sed -n '2p' | awk '{print $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9 " " $10}')
elif [[ $lastip4  =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
	export llll=$(last -4 --time-format notime | grep -e 'ubuntuser\|logged in\|pts/*\|tty*' | sed -n '4p' | grep -e 'ubuntuser\|logged in\|pts/*\|tty*' | awk '{print $3}')
	export lll=$(last -4 -R -w | sed -n '2p' | awk '{print $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9 " " $10}')
#elif ( echo -ne $inv  $llll   = echo -ne  $mosh  $reset ); then
	echo 
else
	export llll=$(last -2 --time-format notime | grep -e 'ubuntuser\|logged in\|pts/*\|tty*' | sed -n '2p' | grep -e 'ubuntuser\|logged in\|pts/*\|tty*' | awk '{print $3}')
	export lll=$(last -2 -R -w | sed -n '2p' | awk '{print $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9 " " $10}')
	#export lll=$(last -2 -R -w  | sed -n '2p' | cut -c 20- )
fi


export StrDay=${1:-${Today:0:10}}
export N_Crash=`last -F  |grep crash  |  grep "$StrDay"  | sort -k 7 -u | wc -l`
export N_Reboot=`last -F | grep reboot | grep "$StrDay"  | wc -l `
export N_LoginU=`last | grep $USER| grep -v "reboot\|crash" | wc -l`
export N_LoginT=`last | grep ^ | grep -v "reboot\|crash" | wc -l`
export N_LoginLU=`last | grep $USER| grep 'logged in' | wc -l`
export N_LoginLT=`last | grep ^ | grep 'logged in' | wc -l`
export stillLogin=`last | grep ^igor | grep 'still logged'`
#echo done with  lll export

#fi
#ip=1.2.3.4

#if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
#  echo "success"
#else
#  echo "fail"
#fi

export geoo=$(parallel -j16 --xargs --semaphoretimeout 2 bash  | geoiplookup   $(echo $llll))
export geo="Edina, MN, USA"
#export geo=$(parallel -j16 --semaphoretimeout 1 bash | whereami )
#export disk=$(df -h | grep G)
#echo done with geo
export critupdate=$(parallel -j16 --xargs --semaphore bash | /usr/lib/update-notifier/apt-check --human-readable | sed -n '2p')
export updates=$(parallel -j16 --xarg --semaphore bash | /usr/lib/update-notifier/apt-check --human-readable | sed -n '1p')
#echo done with updae
#export disk=$(df -h | grep /dev/root)
#export disk1=$(df -h | grep /dev/sda)
export disk=$(df -h | grep /dev/sda)
export disk1=$(df -h | grep /dev/sdb)
#echo done with disk
#ll=$(last -2 -R -w  | head -1 | cut -c 20-)
#lll=$(last -1 -i  $USER | head -1 | cut -c 20-)
#lll=$( last -1 -i -w --time-format notime | grep -e  'ubuntuser\|logged in\|pts/*'  | cut -d  " " -f12)
#llll=$( last -2 -i -w --time-format notime | grep -e  'ubuntuser\|logged in\|pts/*'  | cut -d  " " -f12)
echo "last login time [$lll]"    # adjust to your login messages, fortunes, etc
#export PS1='\n\h:\W\$ '         # replace by your favorite prompt
#export whosinjailnumber=$(parallel -j4  --semaphoretimeout 1 bash | fail2ban-client status | sed -n '2p' | awk '{print $5 }')
export whosinjailnumber=$(parallel -j8  --semaphoretimeout 2 bash | sudo fail2ban-client status sshd | sed -n '7p' | awk '{print $4 }')
export lReboot=$(last -x reboot | sed -n '2p')
#export whosinjail=$(sudo fail2ban-client status | sed -n '2p' )
#echo done with jail

# Weather by us zip code - Can be called two ways # weather 50315 # weather "Des Moines"
weather () {
declare -a WEATHERARRAY
WEATHERARRAY=( `lynx -dump "http://www.google.com/search?hl=en&lr=&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&q=weather+${1}&btnG=Search" | grep -A 5 -m 1 "Weather for"`)
echo ${WEATHERARRAY[@]}
}
# Alias definitions.
#echo -e "# Today $Today  Report for crash and reboot on $StrDay  "
#echo -ne "# Last reboot time: $brown"; who -b; echo -ne "$nc" |  pv -qL 80

echo -ne $reset
figlet Welcome ${USER} |lolcat
figlet MASTER NODE |lolcat
#figlet ubuntuser Server | pv -qL 15|lolcat
figlet $HOSTNAME | pv -qL 80|lolcat
hello| pv -qL 20|lolcat 
bash $prog/lines.sh
.echo -e "# Welcome ${USER} "| pv -qL 30 | lolcat -p 0.9 -F 0.9  
echo -e "# Welcome Charlie Porth" | pv -qL 30
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"  |  pv -qL 80 #date +"Today is %A %D, and it is now %R"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc" |  pv -qL 80
echo -e "# Last reboot time: $brown$lReboot$nc" |  pv -qL 80
echo -e "# Crashes && Reboots$lightgray today$nc: Crashes: $URed$N_Crash$nc && Reboots: $UBlue$N_Reboot$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times" 
echo -e "# This machine has $IRed $critupdate and $IBlue $updates $nc" |  pv -qL 70
echo -e "# You have $BPurple$whosinjailnumber$nc in the Jail" #; echo -ne "$BPurple$whosinjail$nc"
echo -e "# You have $white$MAILCHECK$nc in your inbox" |  pv -qL 80
echo -e "# Diskspace on the primary disk on this machine is: $lightred $disk $nc" |  pv -qL 80
echo -e "# Diskspace on the secondary disk on this machine is: $lightblue $disk1 $nc" |  pv -qL 80
echo -e "# The server external IP address is [$yellow$extip$nc]  " |  pv -qL 80
echo -e "# Last login time [$green$lll$nc]                           "  |  pv -qL 70
echo -e "# Last login IP [$red$llll$nc]" |  pv -qL 60
echo -ne "# Last server location: "; echo -e "$BIYellow$geo$nc"
echo -e "# Last login location:  $geoo"
echo -e "# Weather where the server is:"
echo -ne $cyan
bash $prog/weather.sh
echo -ne $nc
echo "# Weather where you are:"
echo -ne $blue
bash $prog/weather-current.sh
echo -ne $nc
bash $prog/lines.sh

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

#rm -rf /tmp/* &> /dev/null
echo -e "\a \a \a \a"
# CTP INSTALL -- DO NOT REMOVE THIS UNLESS YOU PLAN ON REMOVING INSTALL AND REINSTALLING
[[ $- == *i* ]] && echo 'Interactive' || echo 'Not interactive'
if [[ $USER != "charlieporth1_gmail_com" ]]
   then


        if [[ -f $PROG/systemctl_status.sh ]]; then
                timeout 20 bash $PROG/systemctl_status.sh
        fi

        if [[ -f $PROG/systemctl_status.sh ]]; then
#                timeout 20 sudo bash $PROG/sys_jail_status.sh
        fi
fi
. "$HOME/.cargo/env"
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=50000
SAVEHIST=10000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases & >/dev/null
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func & >/dev/null
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
[[ ${BLE_VERSION-} ]] && ble-attach
eval "$(zoxide init bash)"
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=50000
SAVEHIST=10000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases & >/dev/null
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func & >/dev/null
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
[[ ${BLE_VERSION-} ]] && ble-attach
eval "$(zoxide init bash)"
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=50000
SAVEHIST=10000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases & >/dev/null
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func & >/dev/null
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
[[ ${BLE_VERSION-} ]] && ble-attach
eval "$(zoxide init bash)"
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=50000
SAVEHIST=10000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases & >/dev/null
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func & >/dev/null
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
[[ ${BLE_VERSION-} ]] && ble-attach
eval "$(zoxide init bash)"
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=50000
SAVEHIST=10000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases & >/dev/null
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func & >/dev/null
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
[[ ${BLE_VERSION-} ]] && ble-attach
eval "$(zoxide init bash)"
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=50000
SAVEHIST=10000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases & >/dev/null
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func & >/dev/null
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
[[ ${BLE_VERSION-} ]] && ble-attach
eval "$(zoxide init bash)"
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#[[ $- == *i* ]] && source ~/ble.sh/out/ble.sh --noattach
#[[ $- == *i* ]] && $HOME/.local/share/blesh/ble.sh --noattach
# If not running interactively, don't do anything
case $- in
    *i*) source $HOME/.local/share/blesh/ble.sh --noattach;;
#    *i*) source /usr/local/share/blesh/ble.sh --noattach;;
      *) return ;;
esac
#echo -en "\e]P7E5E5E5" #lightgrey
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000
SAVEHIST=5000

export HISTCONTROL=ignoredups:erasedups

shopt -s histappend
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
#shopt -s checkwinsize        #  update the value of LINES and COLUMNS after each command if altered

shopt -s cmdhist            # save multi-line commands in history as single line
#shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases       # expand aliases
shopt -s extglob             # enable extended pattern-matching features
shopt -s hostcomplete         # attempt hostname expansion when @ is at the beginning of a word

shopt -u progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s direxpand
shopt -s compat44
shopt -s globstar

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt="yes"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt="yes"
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [[ -f  ~/.bash_exports ]]; then
	source ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases &
fi

if [ -f ~/.bash_func ]; then
    . ~/.bash_func &
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# PIHOLE PROFILE START

function getIPAddress() {
    local ip_route
    ip_route=$(ip -4 route get 8.8.8.8 2>/dev/null)
    if [[ -z "$ip_route" ]]; then
        ip_route=$(ip -6 route get 2001:4860:4860::8888 2>/dev/null)
    fi
    [[ -n "$ip_route" ]] && grep -oP "src \K[^\s]+" <<< "$ip_route"
}

function pihole_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "${fgwht}@${bfggrn}(${fgwht}@@@@@@@@@@@@@@@@@@"
        "${fgwht}@${bfggrn}(((((((${fgwht}@@@@@@@@@@@@"
        "${fgwht}@@${bfggrn}((((${fgred}%${bfggrn}(${fggrn}/${fgwht}@@@${fggrn}////${fgwht}@@@@"
        "${fgwht}@@@@@${bfggrn}(((${fgwht}@${fggrn}//////${fgwht}@@@@@"
        "${fgwht}@@@@@@@@@${fgred}%%%${fgwht}@@@@@@@@"
        "${fgwht}@@@@@@${fgred}%%%%%%%%${bfgred}&${fgwht}@@@@@"
        "${fgwht}@@@${fgred}%%%%%%%%%%%${bfgred}&&&&${fgwht}@@"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@@${fgred}%${fgwht}@@${bfgred}&&&&&&&"
        "${bfgred}&&&&&&&&${fgwht}@@@@@${bfgred}&&&&&&&"
        "${fgwht}@${bfgred}&&&&&&&${fgwht}@${fgred}%%%${fgwht}@@${bfgred}&&&&&${fgred}%"
        "${fgwht}@@@@${bfgred}&&&${fgred}%%%%%%%%%%${fgwht}@@@"
        "${fgwht}@@@@@@${bfgred}&${fgred}%%%%%%%%${fgwht}@@@@@"
        )
    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %X")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(getIPAddress)"
                ;;
            9)
                out+="Temperature........: CPU: ${cpuTempC}°C/${cpuTempF}°F GPU: ${gpuTempC}°C/${gpuTempF}°F"
                ;;
            10)
                out+="${fgwht}The PiHole Project, https://pi-hole.net"
                ;;
        esac
        out+="${rst}\n"
    done
    echo -e "\n$out"
}
timeout 20 sudo bash $PROG/systemctl_status.sh
timeout 10 sudo bash $PROG/sys_jail_status.sh
pihole_welcome
# PIHOLE PROFILE END

echo -ne $reset
figlet Welcome ${USER} | lolcat
figlet $HOSTNAME | lolcat
echo -e "# Welcome ${USER} " | lolcat -p 0.9 -F 0.9
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc"
echo -e "# You have logged in $UGreen$N_Login$nc and everyone else has logined in $UYellow$N_LoginT$nc times"
echo -e "# You have $BPurple$whosinjailnumber_sshd$nc in the sshd jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole$nc in the pihole jail"
echo -e "# You have $BPurple$whosinjailnumber_ctp1block$nc in the ctp 1 block jail"
echo -e "# You have $BPurple$whosinjailnumber_pihole1block$nc in the pihole 1 block jail"
echo -e "# You have $white$MAILCHECK$nc in your inbox"
#echo -e "# The server external IP address is [$yellow$extip$nc]  "
echo -e "# The server external IP address is $extips_rc$nc  "

#[[ -s "/home/charlieporth1_gmail_com/.gvm/scripts/gvm" ]] && source "/home/charlieporth1_gmail_com/.gvm/scripts/gvm"
#whoami="$(whoami)@$(echo $SSH_CONNECTION | awk '{print $1}')"
#
function RGBcolor {
    echo "16 + $1 * 36 + $2 * 6 + $3" | bc
}
fg=$(RGBcolor 1 0 2)
bg=$(RGBcolor 5 3 0)
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
bakgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local3.debug "$whoami [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
PS1="\[$txtblu\]\t\[$txtrst\]:\[$txtylw\]$$\[$txtrst\]:\[$txtred\]$(echo $SSH_CONNECTION | awk '{print $1}')\[\033[00m\]:$PS1"
eval "$(zoxide init bash)"
[[ ${BLE_VERSION-} ]] && ble-attach
