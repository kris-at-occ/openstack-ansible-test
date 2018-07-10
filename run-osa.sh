#! /bin/bash

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

cd /opt/openstack-ansible/playbooks

echo "Running sudo openstack-ansible setup-everything.yml"
sudo openstack-ansible setup-everything.yml
