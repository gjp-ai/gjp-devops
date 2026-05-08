#!/usr/bin/env bash
# Install MySQL via Homebrew and start the service.

source "$(dirname "$0")/../../lib/common.sh"

FORMULA_NAME="mysql"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	if "$brew_bin" list --formula "$FORMULA_NAME" >/dev/null 2>&1; then
		log "$FORMULA_NAME is already installed."
		"$brew_bin" services start "$FORMULA_NAME" 2>/dev/null || true
		exit 0
	fi

	log "Installing $FORMULA_NAME via Homebrew..."
	"$brew_bin" install "$FORMULA_NAME"

	log "Starting $FORMULA_NAME service..."
	"$brew_bin" services start "$FORMULA_NAME"

	log "$FORMULA_NAME installed and started successfully."
	log 'Run "mysql_secure_installation" to set a root password and secure the installation.'
}

main "$@"
