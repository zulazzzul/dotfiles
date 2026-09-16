#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/dotfiles"

# ── 1. Dependencies ──────────────────────────────────────────────────────────

install_stow() {
	if command -v stow &>/dev/null; then
		echo "GNU Stow already installed, skipping."
		return
	fi

	echo "Installing GNU Stow..."

	# Try package managers
	if command -v pacman &>/dev/null && sudo -v 2>/dev/null; then
		sudo pacman -S --noconfirm stow && return
	fi
	if command -v apt-get &>/dev/null && sudo -v 2>/dev/null; then
		sudo apt-get install -y stow && return
	fi
	if command -v brew &>/dev/null; then
		brew install stow && return
	fi
	if command -v dnf &>/dev/null && sudo -v 2>/dev/null; then
		sudo dnf install -y stow && return
	fi

	# No sudo access or all package managers failed — build from source
	echo "No sudo access or package manager unavailable. Building Stow from source..."

	if ! command -v perl &>/dev/null; then
		echo "ERROR: Perl is required to build Stow but was not found."
		exit 1
	fi

	local stow_version="2.4.1"
	local stow_tar="stow-${stow_version}.tar.gz"
	local stow_url="https://ftp.gnu.org/gnu/stow/${stow_tar}"
	local build_dir
	build_dir="$(mktemp -d)"

	echo "Downloading Stow ${stow_version}..."
	if command -v curl &>/dev/null; then
		curl -fsSL "${stow_url}" -o "${build_dir}/${stow_tar}"
	elif command -v wget &>/dev/null; then
		wget -q "${stow_url}" -O "${build_dir}/${stow_tar}"
	else
		echo "ERROR: Neither curl nor wget found. Cannot download Stow."
		exit 1
	fi

	echo "Building and installing to ~/.local ..."
	tar -xzf "${build_dir}/${stow_tar}" -C "${build_dir}"
	cd "${build_dir}/stow-${stow_version}"

	./configure --prefix="${HOME}/.local" \
    		--with-pmdir="${HOME}/.local/lib/perl5" 2>/dev/null
	make install
	cd - >/dev/null
	rm -rf "${build_dir}"
	export PATH="${HOME}/.local/bin:${PATH}"
	export PERL5LIB="${HOME}/.local/lib/perl5${PERL5LIB:+:${PERL5LIB}}"


	if ! command -v stow &>/dev/null; then
		echo "ERROR: Stow build succeeded but binary not found in PATH."
		echo "       Add ~/.local/bin to your PATH and re-run."
		exit 1
	fi

	echo "Stow installed to ~/.local/bin/stow"
}

# ── Main ─────────────────────────────────────────────────────────────────────

install_stow
