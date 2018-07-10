#! /bin/sh

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

DEBIAN_FRONTEND=noninteractive apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
DEBIAN_FRONTEND=noninteractive apt-get -y install aptitude build-essential ntp ntpdate openssh-server python-dev
reboot
