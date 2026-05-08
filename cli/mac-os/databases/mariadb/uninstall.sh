#!/usr/bin/env bash
# Uninstall MariaDB via Homebrew.

source "$(dirname "$0")/../../lib/common.sh"

FORMULA_NAME="mariadb"

main() {
	local brew_bin

	require_macos
	require_homebrew

	local brew_bin
	brew_bin=$(brew_bin_path)

	if ! "$brew_bin" list --formula "$FORMULA_NAME" >/dev/null 2>&1; then
		log "$FORMULA_NAME is not installed. Nothing to do."
		exit 0
	fi

	# Stop service if running
	if "$brew_bin" services list 2>/dev/null | grep -q "$FORMULA_NAME.*started"; then
		log "Stopping $FORMULA_NAME service..."
		"$brew_bin" services stop "$FORMULA_NAME"
	fi

	log "Uninstalling $FORMULA_NAME via Homebrew..."
	"$brew_bin" uninstall "$FORMULA_NAME"

	log "$FORMULA_NAME uninstalled successfully."
	log 'Note: data files in /opt/homebrew/var/mysql were not removed. Delete them manually if needed.'
}

main "$@"
