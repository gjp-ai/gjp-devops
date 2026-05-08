#!/usr/bin/env bash
# Uninstall Sourcetree and remove configuration files.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	# Quit Sourcetree if running
	if pgrep -xq 'Sourcetree'; then
		log 'Quitting Sourcetree...'
		osascript -e 'quit app "Sourcetree"' 2>/dev/null || true
		sleep 2
	fi

	log 'Uninstalling Sourcetree via Homebrew...'
	"$brew_bin" uninstall --cask sourcetree || true

	# Clean up Sourcetree configuration and data
	log 'Removing Sourcetree configuration data...'
	rm -rf "$HOME/Library/Application Support/SourceTree"
	rm -rf "$HOME/Library/Preferences/com.torusknot.SourceTreeNotMAS.plist"
	rm -rf "$HOME/Library/Caches/com.torusknot.SourceTreeNotMAS"

	log 'Sourcetree uninstalled successfully.'
}

main "$@"
