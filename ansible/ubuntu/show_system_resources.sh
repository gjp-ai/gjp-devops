#!/bin/bash
# Show system resources on ubuntu_server
# Usage: ./show_system_resources.sh

set -e  # Exit on error

cd "$(dirname "$0")"

export ANSIBLE_STDOUT_CALLBACK=debug
ansible-playbook ./playbook/show_system_resources.yml -i ~/.ansible/inventory/hosts -l ubuntu_server
