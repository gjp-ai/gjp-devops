#!/usr/bin/env bash
# Install OpenJDK 21 via Homebrew, register with macOS, and configure JAVA_HOME.

source "$(dirname "$0")/../../lib/common.sh"

FORMULA_NAME="openjdk@21"

jdk_home_path() {
	local brew_bin brew_prefix

	brew_bin=$(brew_bin_path)
	brew_prefix=$("$brew_bin" --prefix)
	printf '%s/opt/%s/libexec/openjdk.jdk/Contents/Home\n' "$brew_prefix" "$FORMULA_NAME"
}

jdk_symlink_target() {
	local brew_bin brew_prefix

	brew_bin=$(brew_bin_path)
	brew_prefix=$("$brew_bin" --prefix)
	printf '%s/opt/%s/libexec/openjdk.jdk\n' "$brew_prefix" "$FORMULA_NAME"
}

jdk_installed() {
	local brew_bin home_path

	brew_bin=$(brew_bin_path) || return 1
	if ! "$brew_bin" list --formula "$FORMULA_NAME" >/dev/null 2>&1; then
		return 1
	fi

	home_path=$(jdk_home_path)
	[[ -x "$home_path/bin/java" && -x "$home_path/bin/javac" ]]
}

ensure_shell_profile() {
	local shell_rc path_line java_home_line home_path

	shell_rc="$HOME/.zprofile"
	home_path=$(jdk_home_path)
	path_line="export PATH=\"${home_path}/bin:\$PATH\""
	java_home_line="export JAVA_HOME=\"${home_path}\""

	touch "$shell_rc"

	if [[ -f "$shell_rc" ]] && grep -Fqx "$java_home_line" "$shell_rc"; then
		log "JAVA_HOME already configured in $shell_rc"
	else
		printf '\n%s\n' "$java_home_line" >> "$shell_rc"
		log "Added JAVA_HOME for JDK 21 to $shell_rc"
	fi

	if [[ -f "$shell_rc" ]] && grep -Fqx "$path_line" "$shell_rc"; then
		log "JDK 21 PATH already configured in $shell_rc"
	else
		printf '%s\n' "$path_line" >> "$shell_rc"
		log "Added JDK 21 bin directory to PATH in $shell_rc"
	fi
}

install_jdk() {
	local brew_bin

	brew_bin=$(brew_bin_path)
	log "Installing $FORMULA_NAME with Homebrew via $brew_bin"
	"$brew_bin" install "$FORMULA_NAME"
}

register_jdk_with_macos() {
	local source_path target_path

	source_path=$(jdk_symlink_target)
	target_path="/Library/Java/JavaVirtualMachines/openjdk-21.jdk"

	if [[ ! -d "$source_path" ]]; then
		fail "Expected JDK bundle was not found at $source_path"
	fi

	log "Linking JDK bundle into $target_path"
	sudo mkdir -p /Library/Java/JavaVirtualMachines
	sudo ln -sfn "$source_path" "$target_path"
}

verify_jdk() {
	local home_path

	home_path=$(jdk_home_path)
	log "JDK 21 available at $home_path"
	"$home_path/bin/java" -version
	"$home_path/bin/javac" -version
}

main() {
	require_macos
	require_homebrew

	if jdk_installed; then
		log "$FORMULA_NAME already installed"
	else
		install_jdk
	fi

	register_jdk_with_macos
	ensure_shell_profile
	verify_jdk
}

main "$@"
