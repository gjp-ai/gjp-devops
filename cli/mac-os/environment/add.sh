#!/usr/bin/env bash
# Add an environment variable to ~/.zprofile.
# Usage: ./add.sh VAR_NAME VAR_VALUE

source "$(dirname "$0")/../lib/common.sh"

SHELL_RC="$HOME/.zprofile"

main() {
	require_macos

	if [[ $# -lt 2 ]]; then
		fail "Usage: $SCRIPT_NAME VAR_NAME VAR_VALUE"
	fi

	local var_name="$1"
	local var_value="$2"
	local export_line="export ${var_name}=\"${var_value}\""

	touch "$SHELL_RC"

	if grep -Fqx "$export_line" "$SHELL_RC"; then
		log "$var_name is already set to \"$var_value\" in $SHELL_RC"
		exit 0
	fi

	# If the variable exists with a different value, update it
	if grep -q "^export ${var_name}=" "$SHELL_RC"; then
		local tmp
		tmp=$(mktemp)
		sed "s|^export ${var_name}=.*|${export_line}|" "$SHELL_RC" > "$tmp"
		mv "$tmp" "$SHELL_RC"
		log "Updated $var_name to \"$var_value\" in $SHELL_RC"
	else
		printf '\n%s\n' "$export_line" >> "$SHELL_RC"
		log "Added $var_name=\"$var_value\" to $SHELL_RC"
	fi

	log 'Open a new terminal or run: source ~/.zprofile'
}

main "$@"
