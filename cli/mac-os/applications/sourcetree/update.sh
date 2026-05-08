#!/usr/bin/env bash
# Update Sourcetree to the latest version via Homebrew.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	log 'Updating Sourcetree via Homebrew...'
	"$brew_bin" upgrade --cask sourcetree || log 'Sourcetree is already up to date.'

	log 'Sourcetree updated successfully.'
}

main "$@"
