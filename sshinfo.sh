ssh-keygen -t rsa
ssh-copy-id demo@198.51.100.0
cat ~/.ssh/id_rsa.pub | ssh demo@198.51.100.0 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys"
ssh-keyscan -t rsa,dsa HOST 2>&1 | sort -u - ~/.ssh/known_hosts > ~/.ssh/tmp_hosts
mv ~/.ssh/tmp_hosts ~/.ssh/known_hosts
ssh-keyscan -t rsa HOST 
