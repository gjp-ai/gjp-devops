#!/usr/bin/env bash
# Install Homebrew package manager and configure shell environment.

source "$(dirname "$0")/../lib/common.sh"

clt_installed() {
	xcode-select -p >/dev/null 2>&1
}

ensure_shellenv() {
	local brew_bin shell_rc shellenv_line

	brew_bin=$(brew_bin_path)
	shell_rc="$HOME/.zprofile"
	shellenv_line="eval \"$(${brew_bin} shellenv)\""

	if [[ -f "$shell_rc" ]] && grep -Fqx "$shellenv_line" "$shell_rc"; then
		log "Homebrew shell environment already configured in $shell_rc"
		return 0
	fi

	touch "$shell_rc"
	printf '\n%s\n' "$shellenv_line" >> "$shell_rc"
	log "Added Homebrew shell environment to $shell_rc"
}

install_homebrew() {
	log 'Installing Homebrew using the official installer.'
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

main() {
	local brew_bin

	require_macos

	if ! clt_installed; then
		fail 'Xcode Command Line Tools are required. Run mac-os/xcode-clt/install.sh first.'
	fi

	if command -v brew >/dev/null 2>&1 || brew_bin=$(brew_bin_path 2>/dev/null); then
		brew_bin=${brew_bin:-$(command -v brew)}
		log "Homebrew already installed at $brew_bin"
		ensure_shellenv
		log 'Updating Homebrew metadata.'
		"$brew_bin" update
		exit 0
	fi

	install_homebrew
	brew_bin=$(brew_bin_path)
	ensure_shellenv
	log "Homebrew installed successfully at $brew_bin"
}

main "$@"
