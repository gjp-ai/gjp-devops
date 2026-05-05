#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE_DIR="$(cd "${SCRIPT_DIR}/../../.." && pwd)"
PROJECT_DIR="${WORKSPACE_DIR}/gjp-open/gjp-open-web-react"

if [ ! -d "${PROJECT_DIR}" ]; then
  echo "Project directory not found: ${PROJECT_DIR}" >&2
  exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "npm is required to build gjp-open-web-react, but it was not found on PATH." >&2
  exit 1
fi

if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo "ansible-playbook is required to deploy gjp-open-web-react, but it was not found on PATH." >&2
  exit 1
fi

cd "${PROJECT_DIR}"

rm -rf dist

npm run build

cd "${SCRIPT_DIR}"

#tail -f /var/log/nginx/error.log /var/log
ansible-playbook ./playbook/gjp-open-web-react-deploy.yml -i ~/.ansible/inventory/hosts -l ubuntu_server
