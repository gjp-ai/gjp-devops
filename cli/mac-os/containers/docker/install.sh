#!/usr/bin/env bash
# Install Docker Desktop via Homebrew cask.

source "$(dirname "$0")/../../lib/common.sh"

main() {
	local brew_bin

	require_macos
	require_homebrew
	brew_bin=$(brew_bin_path)

	if "$brew_bin" list --cask docker >/dev/null 2>&1; then
		log 'Docker Desktop is already installed.'
		exit 0
	fi

	log 'Installing Docker Desktop via Homebrew...'
	"$brew_bin" install --cask docker

	log 'Opening Docker to complete initial setup...'
	open -a Docker

	log 'Waiting for Docker daemon to start...'
	until docker info >/dev/null 2>&1; do
		printf '.'
		sleep 2
	done

	printf '\n'
	log 'Docker Desktop installed and running.'
	docker --version
}

main "$@"