#!/usr/bin/env bash
# Install Xcode Command Line Tools via softwareupdate or GUI prompt.

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

install_with_softwareupdate() {
	local label

	trap cleanup EXIT
	touch "$PLACEHOLDER_FILE"
	label=$(find_clt_label)

	if [[ -z "$label" ]]; then
		return 1
	fi

	log "Installing Xcode Command Line Tools package: $label"
	sudo softwareupdate --install "$label" --verbose
}

install_with_gui_prompt() {
	log 'Falling back to the Apple installer prompt.'
	xcode-select --install || true
	log 'Complete the GUI installation if prompted, then rerun this script to verify installation.'
}

main() {
	require_macos

	local major_version
	major_version=$(sw_vers -productVersion | awk -F '.' '{print $1}')
	log "Detected macOS major version: $major_version"

	if clt_installed; then
		log "Xcode Command Line Tools already installed at $(xcode-select -p)"
		exit 0
	fi

	if install_with_softwareupdate; then
		:
	else
		cleanup
		install_with_gui_prompt
	fi

	if [[ -d /Library/Developer/CommandLineTools ]]; then
		sudo xcode-select --switch /Library/Developer/CommandLineTools
	fi

	if clt_installed; then
		log "Xcode Command Line Tools installed successfully at $(xcode-select -p)"
		exit 0
	fi

	fail 'Xcode Command Line Tools installation could not be verified.'
}

main "$@"
