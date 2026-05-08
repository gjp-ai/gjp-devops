#!/usr/bin/env bash
# Uninstall Xcode Command Line Tools.

source "$(dirname "$0")/../lib/common.sh"

clt_installed() {
	xcode-select -p >/dev/null 2>&1
}

main() {
	require_macos

	if ! clt_installed; then
		log 'Xcode Command Line Tools are not installed. Nothing to do.'
		exit 0
	fi

	log "Removing Xcode Command Line Tools at $(xcode-select -p)..."
	sudo rm -rf /Library/Developer/CommandLineTools
	sudo xcode-select --reset

	if clt_installed; then
		fail 'Xcode Command Line Tools could not be removed.'
	fi

	log 'Xcode Command Line Tools uninstalled successfully.'
}

main "$@"
