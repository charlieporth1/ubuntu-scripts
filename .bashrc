#!/usr/bin/parallel --shebang-wrap --pipe /bin/bash
#chmod 777 /home/ubuntu/.parallel/semaphores
#rm -rf /home/ubuntu/.parallel/semaphores/*

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

if [ -f  /home/ubuntu/.rvm/scripts/rvm ]; then 
#echo this rvm 
   source /home/ubuntu/.rvm/scripts/rvm
fi 

function cdn(){ for i in `seq $1`; do cd ..; done;}
shopt -s autocd             # change to named directory
shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
shopt -s checkwinsize       # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist            # save multi-line commands in history as single line
shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases     # expand aliases
shopt -s extglob            # enable extended pattern-matching features
shopt -s hostcomplete       # attempt hostname expansion when @ is at the beginning of a word
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
#export NVM_DIR="/home/ubuntu/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#export extip=$(cuControlPersist 60mrl ipecho.net/plain ; echo)
#geoiplookup (last  -1 -i -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*' | cut -c 19-39)
#export extip=$(dig +short myip.opendns.com @resolver1.opendns.com)
export extip=$(parallel -j16 --xargs --semaphoretimeout 1 bash | curl -s ipinfo.io/ip)
#echo done with curl
#geoiplookup  last  -2 -i -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*' |  sed -n '2p' | cut -d " " -f12
#geoiplookup  $( last  -2 -i -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '2p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' | cut -b 19-38)
#lll=$(last  -2 -i -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*' |  sed -n '2p' | cut -d " " -f12)
#llll=$(last  -2 -i -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '2p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*')
#export llll=$(last  -2 -i -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '2p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' | cut -b 19-38)
export llll=$(last  -2  --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '2p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  awk '{print $3}')
export lll=$(last -2 -R -w  | sed -n '2p' | cut -c 20- )
export lastip4=$(last -4  --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '4p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' | awk '{print $3}')
export lastip3=$(last -3  --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '3p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' | awk '{print $3}')
#echo done with llll
#stty -echo
export mosh='0.0.0.0'
if [[ $llll  =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
export llll=$(last  -2  --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '2p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  awk '{print $3}')
export lll=$(last -2 -R -w  | sed -n '2p' | cut -c 20- )
elif [[ $lastip3  =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
#stty echo
export llll=$(last  -3  --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '3p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' | awk '{print $3}')
export lll=$(last -3 -R -w  | sed -n '3p' | cut -c 20- )
elif [[ $lastip4  =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
export llll=$(last  -4  --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '4p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' | awk '{print $3}')
export lll=$(last -4 -R -w  | sed -n '4p' | cut -c 20- )
#elif ( echo -ne $inv  $llll   = echo -ne  $mosh  $reset ); then
echo 
else
export llll=$(last  -2  --time-format notime | grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  sed -n '2p' |  grep -e  'ubuntu\|logged in\|pts/*\|tty*' |  awk '{print $3}')
export lll=$(last -2 -R -w  | sed -n '2p' | cut -c 20- )
fi

#echo done with  lll export

#fi
#ip=1.2.3.4

#if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
#  echo "success"
#else
#  echo "fail"
#fi

export geoo=$(parallel -j16 --xargs --semaphoretimeout 1 bash  | geoiplookup   $(echo $llll))
export geo="Edina, MN, USA"
#export geo=$(parallel -j16 --semaphoretimeout 1 bash | whereami )
#export disk=$(df -h | grep G)
#echo done with geo
export critupdate=$( /usr/lib/update-notifier/apt-check --human-readable | sed -n '2p')
export updates=$( /usr/lib/update-notifier/apt-check --human-readable | sed -n '1p')
#echo done with updae
export disk=$(df -h | grep /dev/root)
export disk1=$(df -h | grep /dev/sda)
#echo done with disk
#ll=$(last -2 -R -w  | head -1 | cut -c 20-)
#lll=$(last -1 -i  $USER | head -1 | cut -c 20-)
#lll=$( last -1 -i -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*'  | cut -d  " " -f12)
#llll=$( last -2 -i -w --time-format notime | grep -e  'ubuntu\|logged in\|pts/*'  | cut -d  " " -f12)
echo "last login time [$lll]"    # adjust to your login messages, fortunes, etc
#export PS1='\n\h:\W\$ '         # replace by your favorite prompt
#export whosinjailnumber=$(parallel -j4  --semaphoretimeout 1 bash | fail2ban-client status | sed -n '2p' | awk '{print $5 }')
export whosinjailnumber=$( parallel -j4  --semaphoretimeout 1 bash | sudo fail2ban-client status sshd | sed -n '7p' | awk '{print $4 }')
#export whosinjail=$(sudo fail2ban-client status | sed -n '2p' )
#echo done with jail

# Weather by us zip code - Can be called two ways # weather 50315 # weather "Des Moines"
weather ()
{
declare -a WEATHERARRAY
WEATHERARRAY=( `lynx -dump "http://www.google.com/search?hl=en&lr=&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&q=weather+${1}&btnG=Search" | grep -A 5 -m 1 "Weather for"`)
echo ${WEATHERARRAY[@]}
}
# Alias definitions.

echo -ne $reset
figlet Welcome ${USER} |lolcat
figlet MASTER NODE |lolcat
#figlet Ubuntu Server | pv -qL 15|lolcat
figlet Ubuntu Server | pv -qL 60|lolcat
hello| pv -qL 15|lolcat 
bash $prog/lines.sh
echo -e "# Welcome ${USER} "| pv -qL 30 | lolcat -p 0.9 -F 0.9  
echo -e "# Welcome Charlie Porth" | pv -qL 30
echo -ne "# Today is: $BIPurple"; date; echo -ne "$nc"  |  pv -qL 80 #date +"Today is %A %D, and it is now %R"
echo -ne "# Up time: $BICyan ";uptime | awk /'up/'; echo -ne "$nc" |  pv -qL 80
echo -ne "# Last reboot time: $brown"; who -b; echo -ne "$nc" |  pv -qL 80
echo -e "# This machine has $IRed $critupdate and $IBlue $updates $nc" |  pv -qL 70
echo -e "# You have $BPurple$whosinjailnumber$nc in the Jail" #; echo -ne "$BPurple$whosinjail$nc"
echo -e "# You have $white$MAILCHECK$nc in your inbox" |  pv -qL 80
echo -e "# Diskspace on the primary disk on this machine is: $lightred $disk $nc" |  pv -qL 40
echo -e "# Diskspace on the secondary disk on this machine is: $lightblue $disk1 $nc" |  pv -qL 40
echo -e "# The server external IP address is [$yellow$extip$nc]  " |  pv -qL 80
echo -e "# Last login time [$green$lll$nc]                           "  |  pv -qL 60
echo -e "# Last login IP [$red$llll$nc]" |  pv -qL 40
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
export PATH="$PATH:$HOME/.rvm/bin"
#rm -rf /tmp/* &> /dev/null
echo -e "\a \a \a \a"
