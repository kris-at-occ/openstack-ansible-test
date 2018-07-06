#! /bin/sh

export LC_ALL=C
export LC_CTYPE="UTF-8",
export LANG="en_US.UTF-8"

DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y 

DEBIAN_FRONTEND=noninteractive apt-get install -y bridge-utils debootstrap ifenslave ifenslave-2.6 lsof lvm2 ntp ntpdate openssh-server sudo tcpdump vlan python

cp /home/openstack/storage1.interfaces /etc/network/interfaces
