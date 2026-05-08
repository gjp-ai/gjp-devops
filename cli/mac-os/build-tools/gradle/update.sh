#!/usr/bin/env bash
# Update Gradle to the latest version via Homebrew.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	log 'Updating Gradle via Homebrew...'
	"$brew_bin" upgrade gradle || log 'Gradle is already up to date.'

	log 'Gradle updated successfully.'
	gradle --version | head -1
}

main "$@"
