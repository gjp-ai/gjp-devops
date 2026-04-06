#!/bin/bash

# Run the mysql_db_init playbook against the inventory group 'ubuntu_server'.
# Usage: ./mysql_db_init.sh
# This script relies on your user Ansible inventory at ~/.ansible/inventory/hosts
# You can override inventory with -i or set ANSIBLE_CONFIG if needed.

# Preferred: specify the playbook first, then options. Use -l to limit to group
ansible-playbook ./playbook/mysql_db_init.yml -i ~/.ansible/inventory/hosts -l ubuntu_server