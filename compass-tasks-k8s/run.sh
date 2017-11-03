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

rm -rf  /opt/kargo_k8s
git clone https://github.com/kubernetes-incubator/kubespray.git /opt/kargo_k8s

cd /opt/kargo_k8s
git checkout v2.2.0

pip uninstall  ansible -y

pip install ansible==2.3.1.0




