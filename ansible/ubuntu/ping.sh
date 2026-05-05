#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "${SCRIPT_DIR}"

ansible ubuntu_server -m ping -i ~/.ansible/inventory/hosts
