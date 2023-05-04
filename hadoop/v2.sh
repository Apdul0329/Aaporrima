#!/bin/bash

if [ $# -eq 0 ];then
    echo "Please Input ip address"
    exit 0
fi

all=""
num=0
for i in $@
do
    num=$(($num+1))
    if [ "$num" == "1" ]; then
        all+="${i} "
        continue
    fi
    all+="${i} ubuntu "
done
# remove space
all=${all::-1}

./Aaporrima/hadoop/step1to3.sh $all


num=0
passwd="ubuntu"
for i in $@
do
    if [ "$num" == "0" ]; then
        num=$(($num+1))
        continue
    fi
    echo $passwd | sshpass -p $passwd ssh ubuntu@$i -o StrictHostKeyChecking=no "sudo -S apt-get install -y git"
    echo $passwd | sshpass -p $passwd ssh ubuntu@$i -o StrictHostKeyChecking=no "git clone https://github.com/Apdul0329/Aaporrima.git; ./Aaporrima/hadoop/step1to3.sh $all"
done


# connect NameNode
echo "hadoop" | sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd; git clone https://github.com/Apdul0329/Aaporrima.git; ./Aaporrima/hadoop/connect.sh"


# connect DataNode
num=0
for i in $@
do
    if [ "$num" == "0" ]; then
        num=$(($num+1))
        continue
    fi
    echo "hadoop" | sshpass -p hadoop ssh hadoop@$i -o StrictHostKeyChecking=no -t "cd; git clone https://github.com/Apdul0329/Aaporrima.git; ./Aaporrima/hadoop/connect.sh"
done



echo "hadoop" | su - hadoop -c "cd; ./Aaporrima/hadoop/installHadoop.sh; source ~/.bashrc;"

./Aaporrima/hadoop/inputProfile.sh

echo "hadoop" | sshpass -p hadoop ssh hadoop@hdn -o StrictHostKeyChecking=no -t "cd ~; pwd; source ~/.bashrc; ./Aaporrima/hadoop/setHadoop.sh"
