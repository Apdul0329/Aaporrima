#!/bin/bash


# install hadoop & make symbolic link
cd /home/hadoop
wget https://downloads.apache.org/hadoop/common/hadoop-3.2.4/hadoop-3.2.4.tar.gz
tar xzf hadoop-3.2.4.tar.gz
ln -s /home/hadoop/hadoop-3.2.4 ~/hadoop;

# Setting hadoop's environment variables
cat ./Aaporrima/hadoop/bashrc.txt >> /home/hadoop/.bashrc
source ~/.bashrc

mkdir ~/hadoop/logs
