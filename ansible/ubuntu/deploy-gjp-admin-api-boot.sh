#!/bin/bash
# Build and deploy gjp-admin-api-boot-deploy to ubuntu_server
# Usage: ./deploy.sh

set -e  # Exit on error

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="${SCRIPT_DIR}/../../../gjp-admin/gjp-admin-api-boot"
APP_YML="${PROJECT_DIR}/src/main/resources/application.yml"

# ---------------------------------------------------------------------------
# Profile helpers
# ---------------------------------------------------------------------------
set_profile_prod() {
  echo "🔧  Setting spring.profiles.active = prod ..."
  sed -i '' \
      -e 's/^    active: dev$/    active: prod/' \
      -e 's/^    # active: prod$/    # active: dev/' \
      "${APP_YML}"
}

set_profile_dev() {
  echo "🔧  Restoring spring.profiles.active = dev ..."
  sed -i '' \
      -e 's/^    active: prod$/    active: dev/' \
      -e 's/^    # active: dev$/    # active: prod/' \
      "${APP_YML}"
}

# Always restore dev profile on exit (success or error)
trap set_profile_dev EXIT

# ---------------------------------------------------------------------------
# Step 1 – Switch to prod profile
# ---------------------------------------------------------------------------
set_profile_prod

echo "=========================================="
echo "Building gjp-admin-api-boot-deploy..."
echo "=========================================="

# Navigate to project root
cd "${PROJECT_DIR}"

./tooling/scripts/util/integrate-open-api.sh

# Build the project using Maven wrapper (skip tests for faster builds)
./mvnw clean package -DskipTests

echo "y" | ./tooling/scripts/util/clean-open-api.sh

echo ""
echo "=========================================="
echo "Build complete. Deploying to ubuntu_server..."
echo "=========================================="

# Return to ansible directory
cd "${SCRIPT_DIR}"

# ---------------------------------------------------------------------------
# Step 2 – Run deployment playbook
# ---------------------------------------------------------------------------
ansible-playbook ./playbook/deploy-gjp-admin-api-boot.yml -i ~/.ansible/inventory/hosts -l ubuntu_server

# (trap will restore dev profile automatically on EXIT)
set_profile_dev

echo ""
echo "=========================================="
echo "Deployment complete!"
echo "=========================================="