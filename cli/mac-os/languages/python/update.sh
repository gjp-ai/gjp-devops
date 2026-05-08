#!/usr/bin/env bash
# Update uv to the latest version.

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

is_brew_managed() {
	local brew_bin
	brew_bin=$(brew_bin_path 2>/dev/null) || return 1
	"$brew_bin" list --formula uv >/dev/null 2>&1
}

main() {
	local uv_bin

	require_macos

	if ! uv_bin=$(uv_bin_path 2>/dev/null); then
		fail 'uv is not installed. Run install.sh first.'
	fi

	log "Updating uv at $uv_bin..."

	if is_brew_managed; then
		local brew_bin
		brew_bin=$(brew_bin_path)
		"$brew_bin" upgrade uv || log 'uv is already up to date.'
	else
		"$uv_bin" self update
	fi

	uv_bin=$(uv_bin_path)
	log "uv updated successfully."
	"$uv_bin" --version
}

main "$@"
