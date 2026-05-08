#!/usr/bin/env bash
# Install Postman via Homebrew cask.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	if "$brew_bin" list --cask postman >/dev/null 2>&1; then
		log 'Postman is already installed.'
		exit 0
	fi

	log 'Installing Postman via Homebrew...'
	"$brew_bin" install --cask postman

	log 'Postman installed successfully.'
}

main "$@"
