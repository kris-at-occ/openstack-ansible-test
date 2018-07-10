#! /bin/bash

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

sudo apt install -y rpl

# Configure SSH connectivity from 'deployment' to Target Hosts

echo 'run-kolla.sh: Cleaning directory /home/openstack/.ssh/'
rm -f /home/openstack/.ssh/known_hosts
rm -f /home/openstack/.ssh/id_rsa
rm -f /home/openstack/.ssh/id_rsa.pub

echo 'Running ssh-keygen -t rsa'
ssh-keygen -t rsa

sudo mkdir -p /root/.ssh

cp /home/openstack/.ssh/id_rsa.pub /home/openstack/.ssh/special
rpl openstack root /home/openstack/.ssh/special
sudo cp /home/openstack/.ssh/id_rsa /root/.ssh/id_rsa
sudo cp /home/openstack/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
sudo rpl openstack root /root/.ssh/id_rsa.pub

# Declare the list of target hosts

target_nodes=( "infra1" "compute1" "storage1" )

for i in "${target_nodes[@]}"
do

  echo "Running ssh-copy-id openstack@$i"
  ssh-copy-id openstack@$i

  echo "Running scp /home/openstack/.ssh/special openstack@$i:/home/openstack/.ssh/special"
  scp /home/openstack/.ssh/special openstack@$i:/home/openstack/.ssh/special

  # Copy setup scripts

  echo "Running scp target.setup.sh openstack@$i:/home/openstack/target.setup.sh"
  scp target.setup.sh openstack@$i:/home/openstack/target.setup.sh

  # Copy interfaces files

  echo "Running scp $i.interfaces openstack@$i:/home/openstack/interfaces"
  scp $i.interfaces openstack@$i:/home/openstack/interfaces

  # Run setup scripts

  echo "Running ssh openstack@$i \"sudo bash /home/openstack/target.setup.sh\""
  ssh openstack@$i "sudo bash /home/openstack/target.setup.sh"
done

# Clone OpenStack-Ansible (OSA) repository into /etc/openstack-ansible

sudo git clone -b 17.0.5 https://git.openstack.org/openstack/openstack-ansible /opt/openstack-ansible
cd /etc/openstack-ansible
sudo scripts/bootstrap-ansible.sh

# Populate /etc/openstack_deploy directory and copy Test Example config files

sudo mkdir -p /etc/openstack_deploy
sudo cp -r /opt/openstack-ansible/etc/openstack_deploy/* /etc/openstack_deploy
sudo cp openstack_user_config.yml.test.example openstack_user_config.yml
sudo cp user_variables.yml user_variables.yml.original
sudo cp user_variables.yml.test.example user_variables.yml
sudo cp openstack_user_config.yml openstack_user_config.yml.original

# Configure service credentials

cd /opt/openstack-ansible
sudo ./scripts/pw-token-gen.py --file /etc/openstack_deploy/user_secrets.yml
