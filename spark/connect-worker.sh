#!/bin/bash

HOSTNAME=$(hostname)
ssh-keygen -t rsa -C "$HOSTNAME" -f "$HOME/.ssh/id_rsa" -P "" && cat ~/.ssh/id_rsa.pub

#ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -N ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
cat /etc/hosts >> host.txt

cnt=0
for i in $(sed -n '/spark/p' /etc/hosts)
do
	cnt=$(($cnt+1))
	if [[ "${i} " == *"$(hostname -I)"* ]] || [ $(($cnt%2)) == 0 ];then
		continue
	fi
	ssh-copy-id -i /home/spark/.ssh/id_rsa.pub spark@$i
	scp host.txt spark@$i:/home/spark/
	ssh spark@$i "sudo cp host.txt /etc/hosts"
done