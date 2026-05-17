#!/bin/bash

# Run the change_mysql_timezone playbook against the inventory group 'ubuntu_server'.
# Usage: ./change_mysql_timezone.sh
# This script relies on your user Ansible inventory at ~/.ansible/inventory/hosts

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "${SCRIPT_DIR}"

# Run the playbook
ansible-playbook ./playbook/change_mysql_timezone.yml -i ~/.ansible/inventory/hosts -l ubuntu_server
