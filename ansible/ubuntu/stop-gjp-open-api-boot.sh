#!/bin/bash
# Stop gjp-open-api-boot on ubuntu_server
# Usage: ./gjp-open-api-boot-stop.sh

set -e  # Exit on error

echo "=========================================="
echo "Stopping gjp-open-api-boot..."
echo "=========================================="

cd "$(dirname "$0")"

# Run the stop playbook
ansible-playbook ./playbook/gjp-open-api-boot-stop.yml -i ~/.ansible/inventory/hosts -l ubuntu_server

echo ""
echo "=========================================="
echo "Stop complete!"
echo "=========================================="