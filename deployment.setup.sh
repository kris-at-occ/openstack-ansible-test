#! /bin/sh

export LC_ALL=C
export LC_CTYPE="UTF-8",
export LANG="en_US.UTF-8"

DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
DEBIAN_FRONTEND=noninteractive apt-get -y install aptitude build-essential ntp ntpdate openssh-server python-dev
reboot

sudo git clone -b 17.0.5 https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible

cd /opt/openstack-ansible
sudo scripts/bootstrap-ansible.sh
