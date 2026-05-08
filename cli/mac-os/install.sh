#!/usr/bin/env bash
# Install all developer tools in dependency order.

source "$(dirname "$0")/lib/common.sh"

SCRIPTS=(
	xcode-clt/install.sh
	homebrew/install.sh
	xcode/install.sh
	languages/python/install.sh
	languages/java/install.sh
	languages/nodejs/install.sh
	databases/mariadb/install.sh
	databases/mysql/install.sh
	containers/docker/install.sh
	build-tools/gradle/install.sh
	applications/dbeaver/install.sh
	applications/postman/install.sh
	applications/openclaw/install.sh
)

main() {
	require_macos

	local base_dir total i script
	base_dir="$(cd "$(dirname "$0")" && pwd)"
	total=${#SCRIPTS[@]}

	log "Installing all tools ($total scripts)..."

	for i in "${!SCRIPTS[@]}"; do
		script="${SCRIPTS[$i]}"
		log "[$((i + 1))/$total] Running $script"
		bash "$base_dir/$script"
	done

	log "All tools installed successfully."
}

main "$@"
