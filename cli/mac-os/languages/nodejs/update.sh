#!/usr/bin/env bash
# Update nvm and Node.js 24 to their latest versions.

source "$(dirname "$0")/../../lib/common.sh"

NODE_MAJOR="24"
NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

nvm_installed() {
	[[ -s "$NVM_DIR/nvm.sh" ]]
}

load_nvm() {
	# shellcheck source=/dev/null
	source "$NVM_DIR/nvm.sh"
}

nvm_latest_install_script_url() {
	local tag
	tag=$(curl -fsSL \
		-H 'Accept: application/json' \
		https://api.github.com/repos/nvm-sh/nvm/releases/latest \
		| grep '"tag_name"' \
		| head -1 \
		| sed 's/.*"tag_name": *"\(.*\)".*/\1/')
	printf 'https://raw.githubusercontent.com/nvm-sh/nvm/%s/install.sh\n' "$tag"
}

main() {
	require_macos

	if ! nvm_installed; then
		fail 'nvm is not installed. Run install.sh first.'
	fi

	# Update nvm itself
	log 'Updating nvm to the latest version...'
	local url
	url=$(nvm_latest_install_script_url)
	log "Installing nvm from $url"
	PROFILE=/dev/null /bin/bash -c "$(curl -fsSL "$url")"

	load_nvm
	log "nvm   : $(nvm --version)"

	# Update Node.js to the latest release of the target major
	log "Updating Node.js $NODE_MAJOR to latest..."
	nvm install "$NODE_MAJOR"
	nvm alias default "$NODE_MAJOR"
	nvm use default

	log "node  : $(node --version)"
	log "npm   : $(npm --version)"
}

main "$@"
