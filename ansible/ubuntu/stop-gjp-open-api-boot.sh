#!/bin/bash
# Stop gjp-open-api-boot on ubuntu_server
# Usage: ./stop-gjp-open-api-boot.sh

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=========================================="
echo "Stopping gjp-open-api-boot..."
echo "=========================================="

cd "${SCRIPT_DIR}"

# Run the stop playbook
ansible-playbook ./playbook/gjp-open-api-boot-stop.yml -i ~/.ansible/inventory/hosts -l ubuntu_server

echo ""
echo "=========================================="
echo "Stop complete!"
echo "=========================================="
