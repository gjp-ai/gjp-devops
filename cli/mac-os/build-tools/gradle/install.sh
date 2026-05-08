#!/usr/bin/env bash
# Install Gradle via Homebrew.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	if "$brew_bin" list gradle >/dev/null 2>&1; then
		log 'Gradle is already installed.'
		gradle --version | head -1
		exit 0
	fi

	log 'Installing Gradle via Homebrew...'
	"$brew_bin" install gradle

	log 'Gradle installed successfully.'
	gradle --version | head -1
}

main "$@"
