#! /usr/bin/env bash

# add repo
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

#yum install docker-ce-18.09.9-3.el7 docker-ce-cli-18.09.9-3.el7 \
#    containerd.io-1.2.6-3.3.el7 -y
yum install docker-ce-19.03.8 docker-ce-cli-19.03.8 containerd.io -y
systemctl enable --now docker