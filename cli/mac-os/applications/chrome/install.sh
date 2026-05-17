#!/usr/bin/env bash
# Install Google Chrome via Homebrew cask.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	if "$brew_bin" list --cask google-chrome >/dev/null 2>&1; then
		log 'Google Chrome is already installed.'
		exit 0
	fi

	log 'Installing Google Chrome via Homebrew...'
	"$brew_bin" install --cask google-chrome

	log 'Google Chrome installed successfully.'
}

main "$@"
