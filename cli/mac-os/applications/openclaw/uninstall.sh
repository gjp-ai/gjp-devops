#!/usr/bin/env bash
# Uninstall OpenClaw.

source "$(dirname "$0")/../../lib/common.sh"

openclaw_installed() {
	command -v openclaw >/dev/null 2>&1
}

main() {
	require_macos

	if ! openclaw_installed; then
		log 'OpenClaw is not installed. Nothing to do.'
		exit 0
	fi

	local openclaw_bin
	openclaw_bin=$(command -v openclaw)

	log "Removing OpenClaw binary at $openclaw_bin..."
	rm -f "$openclaw_bin"

	if openclaw_installed; then
		fail 'OpenClaw could not be removed.'
	fi

	log 'OpenClaw uninstalled successfully.'
}

main "$@"
