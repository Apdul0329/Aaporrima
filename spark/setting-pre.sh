#!/bin/bash

sudo apt-get update
sudo apt install openssh-server openssh-client -y
sudo apt install net-tools -y
sudo apt install sshpass -y

sudo sed -i "/PasswordAuthentication/ c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo sed -i "/PermitRootLogin/ c\PermitRootLogin yes" /etc/ssh/sshd_config
sudo systemctl restart sshd

./Aaporrima/spark/add-spark-user.sh
echo -n "spark" | su - spark -c "git clone https://github.com/psy337337/Aaporrima.git"
sleep 1

echo "Start install JAVA"
echo -n "spark" | su - spark -c "./Aaporrima/spark/install-java.sh"
sleep 1

echo "Start install Python3"
echo -n "spark" | su - spark -c "./Aaporrima/spark/install-python.sh"
