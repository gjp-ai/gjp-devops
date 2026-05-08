#!/usr/bin/env bash
# Update Google Chrome to the latest version via Homebrew.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	log 'Updating Google Chrome via Homebrew...'
	"$brew_bin" upgrade --cask google-chrome || log 'Google Chrome is already up to date.'

	log 'Google Chrome updated successfully.'
}

main "$@"
