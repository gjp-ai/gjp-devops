#!/usr/bin/env bash
# Uninstall all developer tools in reverse dependency order.

source "$(dirname "$0")/lib/common.sh"

SCRIPTS=(
	applications/openclaw/uninstall.sh
	applications/postman/uninstall.sh
	applications/dbeaver/uninstall.sh
	build-tools/gradle/uninstall.sh
	containers/docker/uninstall.sh
	databases/mysql/uninstall.sh
	databases/mariadb/uninstall.sh
	languages/nodejs/uninstall.sh
	languages/java/uninstall.sh
	languages/python/uninstall.sh
	xcode/uninstall.sh
	homebrew/uninstall.sh
	xcode-clt/uninstall.sh
)

main() {
	require_macos

	local base_dir total i script
	base_dir="$(cd "$(dirname "$0")" && pwd)"
	total=${#SCRIPTS[@]}

	log "Uninstalling all tools ($total scripts)..."

	for i in "${!SCRIPTS[@]}"; do
		script="${SCRIPTS[$i]}"
		log "[$((i + 1))/$total] Running $script"
		bash "$base_dir/$script"
	done

	log "All tools uninstalled successfully."
}

main "$@"
