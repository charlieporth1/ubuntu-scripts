#!/bin/bash

# This script uses traps to create try/catch/finally functionality in shell scripts.
#
# OUTPUT:
#
# Hello! We're reporting live from script
# ./try_catch2.sh: line 23: badcommand: command not found
# ./try_catch2.sh: line 23: exiting with status 127
# It's the end of the line
#

finally() {
  local exit_code="${1:-0}"

  echo "It's the end of the line"
  exit "${exit_code}"
}

catch() {
  local this_script="$0"
  local exit_code="$1"
  local err_lineno="$2"
  echo "$0: line $2: exiting with status ${exit_code}"

  finally $@ #important to call here and as the last line of the script
}

trap 'catch $? ${LINENO}' ERR

# this is the stuff you want to try
echo "Hello! We're reporting live from script"
badcommand
echo "You can't see this echo!"

finally #important to call here and as the last line of the catch