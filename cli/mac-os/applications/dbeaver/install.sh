#!/usr/bin/env bash
# Install DBeaver Community Edition via Homebrew cask.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	if "$brew_bin" list --cask dbeaver-community >/dev/null 2>&1; then
		log 'DBeaver Community is already installed.'
		exit 0
	fi

	log 'Installing DBeaver Community via Homebrew...'
	"$brew_bin" install --cask dbeaver-community

	log 'DBeaver Community installed successfully.'
}

main "$@"
