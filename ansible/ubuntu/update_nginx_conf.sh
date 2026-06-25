#!/bin/bash
# Update nginx.conf & restart Nginx on ubuntu_server
# Usage: ./update_nginx_conf.sh

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "${SCRIPT_DIR}"

export ANSIBLE_STDOUT_CALLBACK=debug
ansible-playbook ./playbook/update_nginx_conf.yml -i ~/.ansible/inventory/hosts -l ubuntu_server
