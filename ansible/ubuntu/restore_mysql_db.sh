#!/bin/bash

# Run the restore_mysql_db playbook against the inventory group 'ubuntu_server'.
# Usage: ./restore_mysql_db.sh
# This script relies on your user Ansible inventory at ~/.ansible/inventory/hosts
# You can override inventory with -i or set ANSIBLE_CONFIG if needed.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "${SCRIPT_DIR}"

# Preferred: specify the playbook first, then options. Use -l to limit to group
ansible-playbook ./playbook/restore_mysql_db.yml -i ~/.ansible/inventory/hosts -l ubuntu_server
