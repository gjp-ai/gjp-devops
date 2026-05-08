#!/usr/bin/env bash
# Update OpenClaw to the latest version.

source "$(dirname "$0")/../../lib/common.sh"

INSTALL_URL="https://openclaw.ai/install.sh"

openclaw_installed() {
	command -v openclaw >/dev/null 2>&1
}

main() {
	require_macos

	if ! openclaw_installed; then
		fail 'OpenClaw is not installed. Run install.sh first.'
	fi

	log "Updating OpenClaw from $INSTALL_URL..."
	curl -fsSL "$INSTALL_URL" | bash

	if openclaw_installed; then
		log "openclaw : $(openclaw --version)"
	else
		log 'OpenClaw binary not found on PATH after update.'
		log 'You may need to open a new terminal or run: source ~/.zprofile'
	fi
}

main "$@"
