#country
curl https://whatsmyip.com/ | grep Country: | cut -d "<" -f 2 | cut -d ">" -f 2
