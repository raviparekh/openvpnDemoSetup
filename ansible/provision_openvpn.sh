#!/usr/bin/env bash
ansible-playbook -i inventory/ec2.py -u ubuntu playbooks/openvpn_playbook.yml