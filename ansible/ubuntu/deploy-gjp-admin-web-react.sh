#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE_DIR="$(cd "${SCRIPT_DIR}/../../.." && pwd)"
PROJECT_DIR="${WORKSPACE_DIR}/gjp-admin/gjp-admin-web-react"

cd "${PROJECT_DIR}"

rm -rf dist

npm run build

cd "${SCRIPT_DIR}"

#tail -f /var/log/nginx/error.log /var/log
ansible-playbook ./playbook/gjp-admin-web-react-deploy.yml -i ~/.ansible/inventory/hosts -l ubuntu_server
