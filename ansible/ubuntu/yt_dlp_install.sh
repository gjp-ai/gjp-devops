#!/bin/bash

# Run the yt_dlp_install playbook against the inventory group 'ubuntu_server'.
# Usage: ./yt_dlp_install.sh

ansible-playbook ./playbook/yt_dlp_install.yml -i ~/.ansible/inventory/hosts -l ubuntu_server
