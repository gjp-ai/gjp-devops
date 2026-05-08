#!/usr/bin/env bash
# Uninstall Google Chrome and remove configuration files.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	# Quit Google Chrome if running
	if pgrep -xq 'Google Chrome'; then
		log 'Quitting Google Chrome...'
		osascript -e 'quit app "Google Chrome"' 2>/dev/null || true
		sleep 2
	fi

	log 'Uninstalling Google Chrome via Homebrew...'
	"$brew_bin" uninstall --cask google-chrome || true

	# Clean up Google Chrome configuration and data
	log 'Removing Google Chrome configuration data...'
	rm -rf "$HOME/Library/Application Support/Google/Chrome"
	rm -rf "$HOME/Library/Caches/Google/Chrome"
	rm -rf "$HOME/Library/Preferences/com.google.Chrome.plist"

	log 'Google Chrome uninstalled successfully.'
}

main "$@"
