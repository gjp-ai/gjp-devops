#!/usr/bin/env bash
# Remove an environment variable from ~/.zprofile.
# Usage: ./remove.sh VAR_NAME

source "$(dirname "$0")/../lib/common.sh"

SHELL_RC="$HOME/.zprofile"

main() {
	require_macos

	if [[ $# -lt 1 ]]; then
		fail "Usage: $SCRIPT_NAME VAR_NAME"
	fi

	local var_name="$1"

	if [[ ! -f "$SHELL_RC" ]]; then
		log "$SHELL_RC does not exist. Nothing to remove."
		exit 0
	fi

	if ! grep -q "^export ${var_name}=" "$SHELL_RC"; then
		log "$var_name is not set in $SHELL_RC. Nothing to remove."
		exit 0
	fi

	local tmp
	tmp=$(mktemp)
	grep -v "^export ${var_name}=" "$SHELL_RC" > "$tmp" || true
	mv "$tmp" "$SHELL_RC"

	log "Removed $var_name from $SHELL_RC"
	log 'Open a new terminal or run: source ~/.zprofile'
}

main "$@"
