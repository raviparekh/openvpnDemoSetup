#!/usr/bin/env bash

set -e

read -p "Enter the path to PEM file for SSHing to instance: " ssh_key

ssh-add $ssh_key

ansible-playbook -i inventory/ec2.py -u ubuntu playbooks/openvpn_playbook.yml
