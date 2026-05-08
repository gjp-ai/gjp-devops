#!/usr/bin/env bash
# View all environment variables, or filter by name.
# Usage: ./view.sh [PATTERN]

source "$(dirname "$0")/../lib/common.sh"

SHELL_RC="$HOME/.zprofile"

main() {
	require_macos

	if [[ $# -ge 1 ]]; then
		local pattern="$1"
		log "Environment variables matching \"$pattern\":"
		env | grep -i "$pattern" | sort || log "No matches found."

		if [[ -f "$SHELL_RC" ]]; then
			log "Entries in $SHELL_RC matching \"$pattern\":"
			grep -i "$pattern" "$SHELL_RC" | grep '^export ' || log "No matches in $SHELL_RC."
		fi
	else
		log "All current environment variables:"
		env | sort

		if [[ -f "$SHELL_RC" ]]; then
			log "Custom exports in $SHELL_RC:"
			grep '^export ' "$SHELL_RC" || log "No custom exports in $SHELL_RC."
		fi
	fi
}

main "$@"
