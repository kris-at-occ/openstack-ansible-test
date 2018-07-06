#! /bin/sh

export LC_ALL=C
export LC_CTYPE="UTF-8",
export LANG="en_US.UTF-8"

# Configure SSH connectivity from 'deployment' to Target Hosts

echo 'run-kolla.sh: Cleaning directory /home/openstack/.ssh/'
rm -f /home/openstack/.ssh/known_hosts
rm -f /home/openstack/.ssh/id_rsa
rm -f /home/openstack/.ssh/id_rsa.pub

echo 'run-kolla.sh: Running ssh-keygen -t rsa'
ssh-keygen -t rsa

echo 'run-kolla.sh: Running ssh-copy-id openstack@infra1'
ssh-copy-id openstack@infra1
echo 'run-kolla.sh: Running ssh-copy-id openstack@compute1'
ssh-copy-id openstack@compute1
echo 'run-kolla.sh: Running ssh-copy-id openstack@storage1'
ssh-copy-id openstack@storage1

# Copy setup scripts

echo 'run-kolla.sh: Running scp infra1.setup.sh openstack@infra1:/home/openstack/infra1.setup.sh'
scp infra1.setup.sh openstack@controller1:/home/openstack/infra1.setup.sh
echo 'run-kolla.sh: Running scp compute1.setup.sh openstack@compute1:/home/openstack/compute1.setup.sh'
scp compute1.setup.sh openstack@controller2:/home/openstack/compute1.setup.sh
echo 'run-kolla.sh: Running scp storage1.setup.sh openstack@storage1:/home/openstack/storage1.setup.sh'
scp storage1.setup.sh openstack@storage1:/home/openstack/storage1.setup.sh

# Copy interfaces files

echo 'run-kolla.sh: Running scp infra1.interfaces openstack@infra1:/home/openstack/infra1.interfaces'
scp infra1.interfaces openstack@infra1:/home/openstack/infra1.interfaces
echo 'run-kolla.sh: Running scp compute1.interfaces openstack@compute1:/home/openstack/compute1.interfaces'
scp compute1.interfaces openstack@controller2:/home/openstack/compute1.interfaces
echo 'run-kolla.sh: Running scp storage1.interfaces openstack@storage1:/home/openstack/storage1.interfaces'
scp storage1.interfaces openstack@storage1:/home/openstack/storage1.interfaces

# Run setup scripts

echo 'run-kolla.sh: Running ssh openstack@infra1 "sudo bash /home/openstack/infra1.setup.sh"'
ssh openstack@infra1 "sudo bash /home/openstack/infra1.setup.sh"
echo 'run-kolla.sh: Running ssh openstack@compute1 "sudo bash /home/openstack/compute1.setup.sh"'
ssh openstack@compute1 "sudo bash /home/openstack/compute1.setup.sh"
echo 'run-kolla.sh: Running ssh openstack@storage1 “sudo bash /home/openstack/storage1.setup.sh”'
ssh openstack@storage1 “sudo bash /home/openstack/storage1.setup.sh”

sudo cp -r /opt/openstack-ansible/etc/openstack_deploy/* /etc/openstack_deploy
