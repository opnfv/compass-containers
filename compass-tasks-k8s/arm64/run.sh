#!/bin/bash

yum install git ntp wget ntpdate openssh-server python-devel sudo '@Development Tools' -y
#yum install -y python-yaml
systemctl stop firewalld
systemctl mask firewalld

# get kubespray code and install requirement
rm -rf  /opt/kargo_k8s
git clone https://github.com/kubernetes-incubator/kubespray.git /opt/kargo_k8s
cd /opt/kargo_k8s

git checkout v2.2.1

# bugfix: https://github.com/kubernetes-incubator/kubespray/pull/1727
git format-patch -1 dae9f6d3 --stdout | git apply
# support etcd on arm64
git apply /root/etcd-arm64.patch
# increase container startup timeout
git apply /root/thunderx1.patch
# fix docker package
git apply /root/docker-pkg.patch

pip install ansible==2.3.1.0
