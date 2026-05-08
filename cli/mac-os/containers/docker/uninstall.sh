#!/usr/bin/env bash
# Uninstall Docker Desktop and remove configuration files.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew

	local brew_bin
	brew_bin=$(brew_bin_path)

	# Quit Docker Desktop if running
	if pgrep -xq 'Docker Desktop' || pgrep -xq 'Docker'; then
		log 'Quitting Docker Desktop...'
		osascript -e 'quit app "Docker"' 2>/dev/null || true
		sleep 3
	fi

	log 'Uninstalling Docker Desktop via Homebrew...'
	"$brew_bin" uninstall --cask docker || true

	# Clean up Docker residual files
	log 'Removing Docker configuration and data...'
	rm -rf "$HOME/.docker"
	rm -rf "$HOME/Library/Group Containers/group.com.docker"
	rm -rf "$HOME/Library/Containers/com.docker.docker"

	log 'Docker Desktop uninstalled successfully.'
}

main "$@"
