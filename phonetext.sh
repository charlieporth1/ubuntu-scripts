#!/bin/bash

curl -O -s 'https://api.twilio.com/2010-04-01/Accounts/AC473961505e8705270a1cfe08f453a090/Messages.json' -X POST \
--data-urlencode 'To=+19523341587' \
--data-urlencode 'From=+17634028391' \
--data-urlencode 'Body=Someone Has Logged into one of your servers' \
-u AC473961505e8705270a1cfe08f453a090:b150148870c3781b0de90f61f46f9db4  > /dev/null
exit 0
