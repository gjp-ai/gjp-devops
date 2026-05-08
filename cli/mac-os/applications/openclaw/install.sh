#!/usr/bin/env bash
# Install OpenClaw.

source "$(dirname "$0")/../../lib/common.sh"

INSTALL_URL="https://openclaw.ai/install.sh"

openclaw_installed() {
	command -v openclaw >/dev/null 2>&1
}

install_openclaw() {
	log "Installing OpenClaw from $INSTALL_URL"
	curl -fsSL "$INSTALL_URL" | bash
}

verify_openclaw() {
	log "openclaw : $(openclaw --version)"
}

main() {
	require_macos

	if openclaw_installed; then
		log "OpenClaw already installed at $(command -v openclaw)"
		verify_openclaw
		exit 0
	fi

	install_openclaw

	if openclaw_installed; then
		verify_openclaw
	else
		log 'OpenClaw binary not found on PATH after installation.'
		log 'You may need to open a new terminal or run: source ~/.zprofile'
	fi
}

main "$@"