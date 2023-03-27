#! /bin/bash

os_check() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$NAME" == "Ubuntu"* ]]; then
            echo "Ubuntu"
        elif [[ "$NAME" == "CentOS"* ]]; then
            echo "CentOS"
        else
            echo "$NAME"
        fi
    else
        echo "not exited /etc/os-release"
        exit 1
    fi
}

ubuntu_init() {
    apt-get update
    apt-get install -y vim curl wget tmux git sysstat
}

centos_init() {
    # ssh password authentication no to yes
    # Allow root access from outside
    sed -i -e 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    # sed -i -e 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
    systemctl restart sshd

    # install usefull packages
    yum update
    yum install yum-utils epel-release -y
    yum install vim curl wget tmux git sysstat -y

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
}

OS_RELEASE=`os_check`

case "$OS_RELEASE" in 
    "Ubuntu")
        ubuntu_init
    ;;
    "CentOS")
        centos_init
    ;;
esac
