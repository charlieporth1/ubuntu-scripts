sudo cgcreate -g cpu:/cpulimited

sudo cgset -r cpu.shares=128 cpulimited

sudo cgexec -g cpu:cpulimited
