#!/bin/bash

sudo yum install git -y
git clone https://github.com/pi88a/ansible-sandbox.git

# Configure AWS CLI
aws_cli_profile_name=ansible
aws_access_key_id=$1
aws_secret_access_key=$2

mkdir -p ~/.aws
echo -e "[$aws_cli_profile_name]\naws_access_key_id=$aws_access_key_id\naws_secret_access_key=$aws_secret_access_key" > ~/.aws/credentials
echo -e "[$aws_cli_profile_name]\nregion=eu-central-1" > ~/.aws/config
export AWS_PROFILE=$aws_cli_profile_name

# Install pip
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
echo -e 'export PATH=/home/ec2-user/.local/bin:$PATH'  >> ~/.bash_profile
source ~/.bash_profile

# Install Ansible
python3 -m pip install --user ansible

# Install required Python modules for dynamic inventory
pip install boto3

# Install Ansible module to connect to Windows
pip install "pypsrp<=1.0.0"
pip install "pywinrm>=0.4.0"