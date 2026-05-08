#!/usr/bin/env bash
# Uninstall Gradle and remove cache/configuration files.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	log 'Uninstalling Gradle via Homebrew...'
	"$brew_bin" uninstall gradle || true

	# Clean up Gradle caches and wrapper files
	log 'Removing Gradle cache and configuration...'
	rm -rf "$HOME/.gradle"

	log 'Gradle uninstalled successfully.'
}

main "$@"
