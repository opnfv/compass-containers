#!/bin/bash

yum install git ntp wget ntpdate openssh-server python-devel sudo '@Development Tools' -y
#yum install -y python-yaml
systemctl stop firewalld
systemctl mask firewalld

# get kubespray code and install requirement
rm -rf  /opt/kargo_k8s
git clone https://github.com/kubernetes-incubator/kubespray.git /opt/kargo_k8s
cd /opt/kargo_k8s
git checkout 05dabb7e7b5eb7cd9a075064868bafe4dc1cf51f -b k8s1.11.3
source /root/.virtualenvs/compass-core/bin/activate
pip install ansible==2.4.2.0
ln -s /root/.virtualenvs/compass-core/bin/ansible /usr/bin/ansible
ln -s /root/.virtualenvs/compass-core/bin/ansible-playbook /usr/bin/ansible-playbook
