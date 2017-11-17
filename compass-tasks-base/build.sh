#!/bin/bash
##############################################################################
# Copyright (c) 2016-2017 HUAWEI TECHNOLOGIES CO.,LTD and others.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Apache License, Version 2.0
# which accompanies this distribution, and is available at
# http://www.apache.org/licenses/LICENSE-2.0
##############################################################################
set -x
COMPASS_DIR=${BASH_SOURCE[0]%/*}

COMPASS_MODULE=(actions apiclient tasks utils deployment db hdsdiscovery log_analyzor)

rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sed -i 's/^mirrorlist=https/mirrorlist=http/g' /etc/yum.repos.d/epel.repo
yum update -y

yum --nogpgcheck install -y python python-devel git amqp python-pip libffi-devel openssl-devel gcc python-setuptools MySQL-python supervisor redis sshpass python-keyczar vim ansible-2.2.1.0 libyaml-devel make

mkdir -p $COMPASS_DIR/compass
for((i=0; i<${#COMPASS_MODULE[@]}; i++))
do
    mv $COMPASS_DIR/${COMPASS_MODULE[i]} $COMPASS_DIR/compass/
done
touch $COMPASS_DIR/compass/__init__.py

mkdir -p /etc/compass/
mkdir -p /etc/compass/machine_list
mkdir -p /etc/compass/switch_list
mkdir -p /var/log/compass
mkdir -p /opt/ansible_callbacks
mkdir -p /opt/compass
mkdir -p /root/.ssh;
echo "UserKnownHostsFile /dev/null" >> /root/.ssh/config;
echo "StrictHostKeyChecking no" >> /root/.ssh/config

easy_install --upgrade pip
pip install --upgrade pip
pip install --upgrade setuptools
pip install --upgrade Flask
pip install --upgrade virtualenvwrapper

source `which virtualenvwrapper.sh`
mkvirtualenv --system-site-packages compass-core
workon compass-core
cd $COMPASS_DIR
pip install -U -r requirements.txt
python setup.py install
cp -rf ./bin /opt/compass/bin
cp supervisord.conf /etc/supervisord.conf
cp start.sh /usr/local/bin/start.sh
ln -s `which celery` /usr/bin/celery
cd -

yum clean all

set +x
