#!/usr/bin/env bash
# Install Sourcetree via Homebrew cask.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	if "$brew_bin" list --cask sourcetree >/dev/null 2>&1; then
		log 'Sourcetree is already installed.'
		exit 0
	fi

	log 'Installing Sourcetree via Homebrew...'
	"$brew_bin" install --cask sourcetree

	log 'Sourcetree installed successfully.'
}

main "$@"
