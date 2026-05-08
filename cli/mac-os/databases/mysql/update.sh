#!/usr/bin/env bash
# Update MySQL to the latest version via Homebrew.

source "$(dirname "$0")/../../lib/common.sh"

FORMULA_NAME="mysql"

main() {
	local brew_bin

	require_macos
	require_homebrew

	local brew_bin
	brew_bin=$(brew_bin_path)

	if ! "$brew_bin" list --formula "$FORMULA_NAME" >/dev/null 2>&1; then
		fail "$FORMULA_NAME is not installed. Run install.sh first."
	fi

	log "Updating $FORMULA_NAME via Homebrew..."
	"$brew_bin" upgrade "$FORMULA_NAME" || log "$FORMULA_NAME is already up to date."

	log "$FORMULA_NAME updated successfully."
}

main "$@"
