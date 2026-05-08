#!/usr/bin/env bash
# Update Postman to the latest version via Homebrew.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	log 'Updating Postman via Homebrew...'
	"$brew_bin" upgrade --cask postman || log 'Postman is already up to date.'

	log 'Postman updated successfully.'
}

main "$@"
