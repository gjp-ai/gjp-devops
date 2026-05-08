#!/usr/bin/env bash
# Uninstall uv and clean up PATH entries.

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

remove_profile_entries() {
	local shell_rc="$HOME/.zprofile"
	local path_line='export PATH="$HOME/.local/bin:$PATH"'

	if [[ ! -f "$shell_rc" ]]; then
		return 0
	fi

	if grep -Fqx "$path_line" "$shell_rc"; then
		local tmp
		tmp=$(mktemp)
		grep -Fxv "$path_line" "$shell_rc" > "$tmp" || true
		mv "$tmp" "$shell_rc"
		log "Removed uv PATH entry from $shell_rc"
	fi
}

main() {
	require_macos

	if ! uv_bin_path >/dev/null 2>&1; then
		log 'uv is not installed. Nothing to do.'
		exit 0
	fi

	if is_brew_managed; then
		local brew_bin
		brew_bin=$(brew_bin_path)
		log 'Uninstalling uv via Homebrew...'
		"$brew_bin" uninstall uv
	else
		log 'Removing uv binary and cache...'
		rm -f "$HOME/.local/bin/uv" "$HOME/.local/bin/uvx"
		rm -rf "$HOME/.cache/uv"
	fi

	remove_profile_entries

	log 'uv uninstalled successfully.'
}

main "$@"
