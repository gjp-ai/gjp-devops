#!/usr/bin/env bash
# Update DBeaver Community Edition to the latest version via Homebrew.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	log 'Updating DBeaver Community via Homebrew...'
	"$brew_bin" upgrade --cask dbeaver-community || log 'DBeaver Community is already up to date.'

	log 'DBeaver Community updated successfully.'
}

main "$@"
