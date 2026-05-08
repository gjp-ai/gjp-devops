#!/usr/bin/env bash
# Common helper functions sourced by all mac-os scripts.
# Usage: source "$(dirname "$0")/../lib/common.sh"

set -euo pipefail

SCRIPT_NAME=$(basename "$0")

log() {
	printf '[%s] %s\n' "$SCRIPT_NAME" "$1"
}

fail() {
	printf '[%s] ERROR: %s\n' "$SCRIPT_NAME" "$1" >&2
	exit 1
}

require_macos() {
	if [[ "$(uname -s)" != "Darwin" ]]; then
		fail 'This script only supports macOS.'
	fi
}

brew_bin_path() {
	if [[ -x /opt/homebrew/bin/brew ]]; then
		printf '/opt/homebrew/bin/brew\n'
	elif [[ -x /usr/local/bin/brew ]]; then
		printf '/usr/local/bin/brew\n'
	else
		return 1
	fi
}

require_homebrew() {
	if ! brew_bin_path >/dev/null 2>&1; then
		fail 'Homebrew is required. Run mac-os/homebrew/install.sh first.'
	fi
}
