#!/usr/bin/env bash
# Uninstall Postman and remove configuration files.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	# Quit Postman if running
	if pgrep -xq 'Postman'; then
		log 'Quitting Postman...'
		osascript -e 'quit app "Postman"' 2>/dev/null || true
		sleep 2
	fi

	log 'Uninstalling Postman via Homebrew...'
	"$brew_bin" uninstall --cask postman || true

	# Clean up Postman configuration and data
	log 'Removing Postman configuration data...'
	rm -rf "$HOME/.postman"
	rm -rf "$HOME/Library/Application Support/Postman"

	log 'Postman uninstalled successfully.'
}

main "$@"
