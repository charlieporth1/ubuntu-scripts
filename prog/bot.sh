#!/bin/bash
TOKEN=$1
CHANNEL=$2
USERNAME=$3
MESSAGE=$4
function push {
  RESPONSE=$(curl -X POST -s https://slack.com/api/chat.postMessage -v --data "token=$TOKEN&channel=$CHANNEL&text=$1&username=$USERNAME&mrkdwn=true" -o /dev/null 2> /dev/null )
  #echo $RESPONSE
}
push "$MESSAGE"
exit 0
