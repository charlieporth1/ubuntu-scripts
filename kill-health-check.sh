#!/bin/bash

ps -aux | grep 'pm.stal\|test_\|pm.hea\|set_fail2ban\|health\|dns-stale\|hea\|dns-st\|ban' | grep -v 'grep\|fail2ban' | awk '{print $2}' | xargs sudo kill -9

sudo killall ps dig go pgrep awk grep cpulimit kdig
