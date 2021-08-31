#! /usr/bin/env bash

# ssh password authentication no to yes
# Allow root access from outside
sed -i -e 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i -e 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart sshd

# install usefull packages
#yum update -y
yum install net-tools -y
yum install yum-utils -y
yum install vim git epel-release wget -y

# host setting
# echo "192.168.1.10 $1" >> /etc/hosts
# for (( i=1; i<=$3; i++ )); do echo "192.168.1.2$i $2$i" >> /etc/hosts; done

# config DNS
cat <<EOF > /etc/resolv.conf
nameserver 1.1.1.1 #cloudflare NDS
nameserver 8.8.8.8 #Google DNS
EOF

# Set SeLinux in permissive mode
setenforce 0
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# firewalld stop & disable
systemctl stop firewalld
systemctl disable firewalld