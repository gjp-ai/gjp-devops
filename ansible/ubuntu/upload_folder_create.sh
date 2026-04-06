#!/bin/bash

# Run the upload_folder_create playbook against the inventory group 'ubuntu_server'.
# Usage: ./upload_folder_create.sh
# This script relies on your user Ansible inventory at ~/.ansible/inventory/hosts
# You can override inventory with -i or set ANSIBLE_CONFIG if needed.

# Preferred: specify the playbook first, then options. Use -l to limit to group
ansible-playbook ./playbook/upload_folder_create.yml -i ~/.ansible/inventory/hosts -l ubuntu_server