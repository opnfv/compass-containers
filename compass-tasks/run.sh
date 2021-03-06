#!/bin/bash

yum install https://rdoproject.org/repos/openstack-pike/rdo-release-pike.rpm -y
yum install git ntp wget ntpdate openssh-server python-devel sudo '@Development Tools' -y

systemctl stop firewalld
systemctl mask firewalld

#pip install ansible==2.3.2.0
rm -rf  /opt/kargo_k8s
git clone https://github.com/kubernetes-incubator/kubespray.git /opt/kargo_k8s
cd /opt/kargo_k8s
git checkout v2.2.1

mkdir -p /opt/git/
cd /opt/git/
wget artifacts.opnfv.org/compass4nfv/package/openstack_pike.tar.gz
tar -zxvf openstack_pike.tar.gz
rm -rf openstack_pike.tar.gz


git clone https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible

cd /opt/openstack-ansible

git checkout 16c69046bfd90d1b984de43bc6267fece6b75f1c
#git checkout 4cde8f86aaea1fde7c43016f661119879068a133

git checkout -b stable/pike

/bin/cp -rf /opt/tacker_conf/ansible-role-requirements.yml /opt/openstack-ansible/
/bin/cp -rf /opt/tacker_conf/openstack_services.yml /opt/openstack-ansible/playbooks/defaults/repo_packages/
/bin/cp -rf /opt/tacker_conf/os-tacker-install.yml /opt/openstack-ansible/playbooks/
/bin/cp -rf /opt/tacker_conf/tacker.yml /opt/openstack-ansible/playbooks/inventory/env.d/
/bin/cp -rf /opt/tacker_conf/tacker_all.yml /opt/openstack-ansible/group_vars/
/bin/cp -rf /opt/tacker_conf/user_secrets.yml /opt/openstack-ansible/etc/openstack_deploy/

/bin/cp -rf /opt/openstack-ansible/etc/openstack_deploy /etc/openstack_deploy

cd /opt/openstack-ansible

scripts/bootstrap-ansible.sh

rm -f /usr/local/bin/ansible-playbook

cd /opt/openstack-ansible/scripts/
python pw-token-gen.py --file /etc/openstack_deploy/user_secrets.yml

cd /opt/openstack-ansible/group_vars
sed -i 's/#repo_build_git_cache/repo_build_git_cache/g' repo_all.yml

cp /opt/setup-complete.yml /opt/openstack-ansible/playbooks/
echo "- include: setup-complete.yml" >> /opt/openstack-ansible/playbooks/setup-infrastructure.yml

# rm ansible json module
# mv /root/.virtualenvs/compass-core/lib/python2.7/site-packages/ansible/plugins/callback/json.py*  /tmp/

# add ansible-playbook for normal use
ln -s /root/.virtualenvs/compass-core/bin/ansible-playbook /usr/bin/ansible-playbook
