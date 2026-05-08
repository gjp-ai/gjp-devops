#!/usr/bin/env bash
# Uninstall nvm and Node.js.

source "$(dirname "$0")/../../lib/common.sh"

NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

nvm_installed() {
	[[ -s "$NVM_DIR/nvm.sh" ]]
}

remove_nvm_dir() {
	if [[ -d "$NVM_DIR" ]]; then
		log "Removing nvm directory at $NVM_DIR..."
		rm -rf "$NVM_DIR"
	fi
}

remove_profile_entries() {
	local shell_rc="$HOME/.zprofile"

	if [[ ! -f "$shell_rc" ]]; then
		return 0
	fi

	if grep -q 'NVM_DIR' "$shell_rc"; then
		local tmp
		tmp=$(mktemp)
		grep -v 'NVM_DIR\|nvm.sh\|nvm.*bash_completion\|# nvm' "$shell_rc" > "$tmp" || true
		mv "$tmp" "$shell_rc"
		log "Removed nvm entries from $shell_rc"
	fi
}

main() {
	require_macos

	if ! nvm_installed; then
		log 'nvm is not installed. Nothing to do.'
		exit 0
	fi

	remove_nvm_dir
	remove_profile_entries

	log 'nvm and Node.js uninstalled successfully.'
	log 'Open a new terminal for changes to take effect.'
}

main "$@"
