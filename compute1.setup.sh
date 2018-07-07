#! /bin/sh

export LC_ALL=C
export LC_CTYPE="UTF-8",
export LANG="en_US.UTF-8"

# Set-up SSH keys, as required in https://docs.openstack.org/project-deploy-guide/openstack-ansible/queens/targethosts.html#configure-ssh-keys

mkdir /root/.ssh
cp /home/openstack/.ssh/authorized_keys /root/.ssh/authorized_keys

DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y 

DEBIAN_FRONTEND=noninteractive apt-get install bridge-utils debootstrap ifenslave ifenslave-2.6 lsof lvm2 ntp ntpdate openssh-server sudo tcpdump vlan python

cp /home/openstack/compute1.interfaces /etc/network/interfaces

reboot
