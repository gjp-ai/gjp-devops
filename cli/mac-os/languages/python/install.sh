#!/usr/bin/env bash
# Install uv (Python package manager) via Homebrew or official installer.

source "$(dirname "$0")/../../lib/common.sh"

uv_bin_path() {
	if command -v uv >/dev/null 2>&1; then
		command -v uv
	elif [[ -x "$HOME/.local/bin/uv" ]]; then
		printf '%s\n' "$HOME/.local/bin/uv"
	elif [[ -x /opt/homebrew/bin/uv ]]; then
		printf '/opt/homebrew/bin/uv\n'
	elif [[ -x /usr/local/bin/uv ]]; then
		printf '/usr/local/bin/uv\n'
	else
		return 1
	fi
}

ensure_local_bin_path() {
	local shell_rc path_line

	shell_rc="$HOME/.zprofile"
	path_line='export PATH="$HOME/.local/bin:$PATH"'

	if [[ -f "$shell_rc" ]] && grep -Fqx "$path_line" "$shell_rc"; then
		log "uv PATH already configured in $shell_rc"
		return 0
	fi

	touch "$shell_rc"
	printf '\n%s\n' "$path_line" >> "$shell_rc"
	log "Added ~/.local/bin to PATH in $shell_rc"
}

install_with_homebrew() {
	local brew_bin

	brew_bin=$(brew_bin_path)
	log "Installing uv with Homebrew via $brew_bin"
	"$brew_bin" install uv
}

install_with_official_installer() {
	log 'Installing uv using the official Astral installer.'
	INSTALLER_NO_MODIFY_PATH=1 /bin/bash -c "$(curl -fsSL https://astral.sh/uv/install.sh)"
}

verify_uv() {
	local uv_bin

	uv_bin=$(uv_bin_path)
	log "uv available at $uv_bin"
	"$uv_bin" --version
}

main() {
	local uv_bin

	require_macos

	if uv_bin=$(uv_bin_path 2>/dev/null); then
		log "uv already installed at $uv_bin"
		verify_uv
		exit 0
	fi

	if brew_bin_path >/dev/null 2>&1; then
		install_with_homebrew
	else
		install_with_official_installer
		ensure_local_bin_path
	fi

	verify_uv
}

main "$@"
