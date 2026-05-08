#!/usr/bin/env bash
# Update Homebrew and upgrade all installed formulae and casks.

source "$(dirname "$0")/../lib/common.sh"

main() {
	local brew_bin

	require_macos

	if ! brew_bin=$(brew_bin_path 2>/dev/null); then
		fail 'Homebrew is not installed. Nothing to update.'
	fi

	log "Updating Homebrew at $brew_bin..."
	"$brew_bin" update

	log 'Upgrading all installed formulae and casks...'
	"$brew_bin" upgrade

	log 'Cleaning up old versions...'
	"$brew_bin" cleanup

	log "Homebrew updated successfully."
	"$brew_bin" --version
}

main "$@"
