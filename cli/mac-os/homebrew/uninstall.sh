#!/usr/bin/env bash
# Uninstall Homebrew and clean up shell profile.

source "$(dirname "$0")/../lib/common.sh"

remove_shellenv_from_profile() {
	local shell_rc="$HOME/.zprofile"

	if [[ ! -f "$shell_rc" ]]; then
		return 0
	fi

	if grep -q 'brew shellenv' "$shell_rc"; then
		local tmp
		tmp=$(mktemp)
		grep -v 'brew shellenv' "$shell_rc" > "$tmp"
		mv "$tmp" "$shell_rc"
		log "Removed Homebrew shell environment from $shell_rc"
	fi
}

main() {
	local brew_bin

	require_macos

	if ! brew_bin=$(brew_bin_path 2>/dev/null); then
		log 'Homebrew is not installed. Nothing to do.'
		exit 0
	fi

	log "Uninstalling Homebrew from $brew_bin..."
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

	remove_shellenv_from_profile

	if brew_bin_path >/dev/null 2>&1; then
		fail 'Homebrew could not be fully removed.'
	fi

	log 'Homebrew uninstalled successfully.'
}

main "$@"
