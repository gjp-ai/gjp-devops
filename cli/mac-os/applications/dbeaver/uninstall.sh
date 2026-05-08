#!/usr/bin/env bash
# Uninstall DBeaver Community Edition and remove configuration files.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	# Quit DBeaver if running
	if pgrep -xq 'DBeaver'; then
		log 'Quitting DBeaver...'
		osascript -e 'quit app "DBeaver"' 2>/dev/null || true
		sleep 2
	fi

	log 'Uninstalling DBeaver Community via Homebrew...'
	"$brew_bin" uninstall --cask dbeaver-community || true

	# Clean up DBeaver configuration
	log 'Removing DBeaver configuration data...'
	rm -rf "$HOME/.dbeaver4"
	rm -rf "$HOME/.dbeaver-drivers"
	rm -rf "$HOME/Library/DBeaverData"

	log 'DBeaver Community uninstalled successfully.'
}

main "$@"
