#!/bin/bash
# Build and deploy gjp-admin-api-boot-deploy to ubuntu_server
# Usage: ./deploy.sh

set -e  # Exit on error

echo "=========================================="
echo "Building gjp-admin-api-boot-deploy..."
echo "=========================================="

# Navigate to project root (two levels up from devops/ansible)
cd "$(dirname "$0")/../../../gjp-admin-api-boot"

./tooling/scripts/util/integrate-open-api.sh

# Build the project using Maven wrapper (skip tests for faster builds)
./mvnw clean package -DskipTests

echo "y" | ./tooling/scripts/util/clean-open-api.sh

echo ""
echo "=========================================="
echo "Build complete. Deploying to ubuntu_server..."
echo "=========================================="

# Return to ansible directory
cd ../gjp-devops/ansible/ubuntu

# Run the deployment playbook
ansible-playbook ./playbook/gjp-admin-api-boot-deploy.yml -i ~/.ansible/inventory/hosts -l ubuntu_server

echo ""
echo "=========================================="
echo "Deployment complete!"
echo "=========================================="