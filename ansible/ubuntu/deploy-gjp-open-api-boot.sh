#!/bin/bash
# Build and deploy gjp-open-api-boot-deploy to ubuntu_server
# Usage: ./deploy.sh

set -e  # Exit on error

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE_DIR="$(cd "${SCRIPT_DIR}/../../.." && pwd)"
PROJECT_DIR="${WORKSPACE_DIR}/gjp-open/gjp-open-api-boot"

echo "=========================================="
echo "Building gjp-open-api-boot-deploy..."
echo "=========================================="

# Navigate to project root
cd "${PROJECT_DIR}"

# Build the project using Maven wrapper (skip tests for faster builds)
./mvnw clean package -DskipTests

echo ""
echo "=========================================="
echo "Build complete. Deploying to ubuntu_server..."
echo "=========================================="

# Return to ansible directory
cd "${SCRIPT_DIR}"

# Run the deployment playbook
ansible-playbook ./playbook/deploy-gjp-open-api-boot.yml -i ~/.ansible/inventory/hosts -l ubuntu_server

echo ""
echo "=========================================="
echo "Deployment complete!"
echo "=========================================="
