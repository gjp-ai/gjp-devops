#!/usr/bin/env bash
# Install nvm (Node Version Manager) and Node.js 24.

source "$(dirname "$0")/../../lib/common.sh"

NODE_MAJOR="24"
NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

# ---------------------------------------------------------------------------
# nvm helpers
# ---------------------------------------------------------------------------

nvm_installed() {
	[[ -s "$NVM_DIR/nvm.sh" ]]
}

load_nvm() {
	# shellcheck source=/dev/null
	source "$NVM_DIR/nvm.sh"
}

nvm_latest_install_script_url() {
	# Resolve the latest release tag from the GitHub API, then build the raw URL.
	local tag
	tag=$(curl -fsSL \
		-H 'Accept: application/json' \
		https://api.github.com/repos/nvm-sh/nvm/releases/latest \
		| grep '"tag_name"' \
		| head -1 \
		| sed 's/.*"tag_name": *"\(.*\)".*/\1/')
	printf 'https://raw.githubusercontent.com/nvm-sh/nvm/%s/install.sh\n' "$tag"
}

install_nvm() {
	local url

	log 'Resolving latest nvm release...'
	url=$(nvm_latest_install_script_url)
	log "Installing nvm from $url"
	PROFILE=/dev/null /bin/bash -c "$(curl -fsSL "$url")"
}

# ---------------------------------------------------------------------------
# shell profile helpers
# ---------------------------------------------------------------------------

ensure_nvm_profile() {
	local shell_rc nvm_block

	shell_rc="$HOME/.zprofile"
	nvm_block='export NVM_DIR="$HOME/.nvm"'

	if [[ -f "$shell_rc" ]] && grep -Fq "$nvm_block" "$shell_rc"; then
		log "nvm shell initialisation already present in $shell_rc"
		return 0
	fi

	touch "$shell_rc"
	cat >> "$shell_rc" <<'EOF'

# nvm -- Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh"            ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion"   ] && source "$NVM_DIR/bash_completion"
EOF
	log "Added nvm initialisation to $shell_rc"
}

# ---------------------------------------------------------------------------
# Node.js helpers
# ---------------------------------------------------------------------------

install_node() {
	log "Installing latest Node.js $NODE_MAJOR with nvm..."
	nvm install "$NODE_MAJOR"
	nvm alias default "$NODE_MAJOR"
	nvm use default
}

node_version_ok() {
	# Returns true if the nvm default alias resolves to the expected major.
	local version
	version=$(nvm run --silent node --version 2>/dev/null || true)
	[[ "$version" == v${NODE_MAJOR}.* ]]
}

verify() {
	log "node  : $(node --version)"
	log "npm   : $(npm --version)"
	log "nvm   : $(nvm --version)"
}

# ---------------------------------------------------------------------------
# main
# ---------------------------------------------------------------------------

main() {
	require_macos

	# ---- nvm ----------------------------------------------------------------
	if nvm_installed; then
		log "nvm already installed at $NVM_DIR"
		load_nvm
	else
		install_nvm
		load_nvm
	fi

	ensure_nvm_profile

	# ---- Node.js ------------------------------------------------------------
	if node_version_ok; then
		log "Node.js $NODE_MAJOR already the nvm default -- skipping reinstall"
	else
		install_node
	fi

	verify
}

main "$@"
