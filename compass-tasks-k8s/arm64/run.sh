#!/bin/bash

yum install git ntp wget ntpdate openssh-server python-devel sudo '@Development Tools' -y
#yum install -y python-yaml
systemctl stop firewalld
systemctl mask firewalld

# get kubespray code and install requirement
rm -rf  /opt/kargo_k8s
git clone https://github.com/kubernetes-incubator/kubespray.git /opt/kargo_k8s
cd /opt/kargo_k8s

git checkout f4180503c891bea4b4b77a2f7cc93923411a7449 -b k8s1.9.1

# support etcd on arm64
git apply /root/etcd-arm64.patch
# fix docker package
git apply /root/docker-pkg.patch

pip install ansible==2.4.2.0
