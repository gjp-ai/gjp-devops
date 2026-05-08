#!/usr/bin/env bash
# Update all installed developer tools.

source "$(dirname "$0")/lib/common.sh"

SCRIPTS=(
	xcode-clt/update.sh
	homebrew/update.sh
	xcode/update.sh
	languages/python/update.sh
	languages/java/update.sh
	languages/nodejs/update.sh
	databases/mysql/update.sh
	containers/docker/update.sh
	build-tools/gradle/update.sh
	applications/dbeaver/update.sh
	applications/postman/update.sh
	applications/openclaw/update.sh
)

main() {
	require_macos

	local base_dir total i script
	base_dir="$(cd "$(dirname "$0")" && pwd)"
	total=${#SCRIPTS[@]}

	log "Updating all tools ($total scripts)..."

	for i in "${!SCRIPTS[@]}"; do
		script="${SCRIPTS[$i]}"
		log "[$((i + 1))/$total] Running $script"
		bash "$base_dir/$script"
	done

	log "All tools updated successfully."
}

main "$@"
