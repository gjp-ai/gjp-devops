#!/usr/bin/env bash
# Uninstall OpenJDK 21, remove symlink and shell profile entries.

source "$(dirname "$0")/../../lib/common.sh"

FORMULA_NAME="openjdk@21"

jdk_home_path() {
	local brew_bin brew_prefix

	brew_bin=$(brew_bin_path)
	brew_prefix=$("$brew_bin" --prefix)
	printf '%s/opt/%s/libexec/openjdk.jdk/Contents/Home\n' "$brew_prefix" "$FORMULA_NAME"
}

remove_jdk_symlink() {
	local target_path="/Library/Java/JavaVirtualMachines/openjdk-21.jdk"

	if [[ -L "$target_path" || -d "$target_path" ]]; then
		log "Removing JDK symlink at $target_path..."
		sudo rm -rf "$target_path"
	fi
}

remove_profile_entries() {
	local shell_rc="$HOME/.zprofile"
	local home_path

	if [[ ! -f "$shell_rc" ]]; then
		return 0
	fi

	home_path=$(jdk_home_path 2>/dev/null || true)

	local tmp
	tmp=$(mktemp)
	grep -v -F "JAVA_HOME" "$shell_rc" | grep -v -F "${FORMULA_NAME}" > "$tmp" || true
	mv "$tmp" "$shell_rc"
	log "Removed JDK 21 entries from $shell_rc"
}

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

	remove_jdk_symlink

	log "Uninstalling $FORMULA_NAME via Homebrew..."
	"$brew_bin" uninstall "$FORMULA_NAME"

	remove_profile_entries

	log "$FORMULA_NAME uninstalled successfully."
}

main "$@"
