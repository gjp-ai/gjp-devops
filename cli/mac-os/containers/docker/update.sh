#!/usr/bin/env bash
# Update Docker Desktop to the latest version via Homebrew.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew

	local brew_bin
	brew_bin=$(brew_bin_path)

	log 'Updating Docker Desktop via Homebrew...'
	"$brew_bin" upgrade --cask docker || log 'Docker Desktop is already up to date.'

	log 'Docker Desktop updated successfully.'
	docker --version
}

main "$@"
