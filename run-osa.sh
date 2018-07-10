#! /bin/bash

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"


sudo git clone -b 17.0.5 https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible

cd /opt/openstack-ansible
sudo scripts/bootstrap-ansible.sh

cd /opt/openstack-ansible/playbooks

echo "Running sudo openstack-ansible setup-everything.yml"
sudo openstack-ansible setup-everything.yml
