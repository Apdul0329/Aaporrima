#!/bin/bash

# checking hadoop is existed
a=$(cat /etc/passwd | grep hadoop)
if [ "$a" != "" ]; then
	echo "exists user hadoop, delete and remake"
	echo "ubuntu" | sudo userdel -rf hadoop
fi

#make hadoop user
echo "ubuntu" | sudo useradd -m hadoop
echo 'hadoop:hadoop' | sudo chpasswd
echo "ubuntu" | sudo chown hadoop:hadoop /home/hadoop
echo "ubuntu" | sudo usermod -s /bin/bash hadoop
