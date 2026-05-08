#!/usr/bin/env bash
# Update Xcode Command Line Tools to the latest available version.

source "$(dirname "$0")/../lib/common.sh"

PLACEHOLDER_FILE="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"

cleanup() {
	rm -f "$PLACEHOLDER_FILE"
}

clt_installed() {
	xcode-select -p >/dev/null 2>&1
}

find_clt_label() {
	softwareupdate --list 2>/dev/null \
		| awk -F 'Label: ' '/Label: Command Line Tools/ { print $2 }' \
		| tail -n 1
}

main() {
	require_macos

	if ! clt_installed; then
		fail 'Xcode Command Line Tools are not installed. Run install.sh first.'
	fi

	log 'Checking for Xcode Command Line Tools updates...'
	trap cleanup EXIT
	touch "$PLACEHOLDER_FILE"

	local label
	label=$(find_clt_label)

	if [[ -z "$label" ]]; then
		log 'Xcode Command Line Tools are already up to date.'
		exit 0
	fi

	log "Updating Xcode Command Line Tools: $label"
	sudo softwareupdate --install "$label" --verbose
	log 'Xcode Command Line Tools updated successfully.'
}

main "$@"
