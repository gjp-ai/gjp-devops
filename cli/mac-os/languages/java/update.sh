#!/usr/bin/env bash
# Update OpenJDK 21 to the latest version via Homebrew.

source "$(dirname "$0")/../../lib/common.sh"

FORMULA_NAME="openjdk@21"

jdk_home_path() {
	local brew_bin brew_prefix

	brew_bin=$(brew_bin_path)
	brew_prefix=$("$brew_bin" --prefix)
	printf '%s/opt/%s/libexec/openjdk.jdk/Contents/Home\n' "$brew_prefix" "$FORMULA_NAME"
}

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

	local home_path
	home_path=$(jdk_home_path)
	log "JDK 21 available at $home_path"
	"$home_path/bin/java" -version
}

main "$@"
