#!/bin/bash
# Build and deploy gjp-open-api-boot-deploy to ubuntu_server
# Usage: ./deploy.sh

set -e  # Exit on error

echo "=========================================="
echo "Building gjp-open-api-boot-deploy..."
echo "=========================================="

# Navigate to project root (two levels up from devops/ansible)
cd "$(dirname "$0")/../../../gjp-open-api-boot"

# Build the project using Maven wrapper (skip tests for faster builds)
./mvnw clean package -DskipTests

echo ""
echo "=========================================="
echo "Build complete. Deploying to ubuntu_server..."
echo "=========================================="

# Return to ansible directory
cd ../gjp-devops/ansible/ubuntu

# Run the deployment playbook
ansible-playbook ./playbook/gjp-open-api-boot-deploy.yml -i ~/.ansible/inventory/hosts -l ubuntu_server

echo ""
echo "=========================================="
echo "Deployment complete!"
echo "=========================================="