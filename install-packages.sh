#!/usr/bin/env bash
#
# install-required-apps.sh
#
# Description:
#   - Checks whether paru is installed.
#   - If not installed:
#       * Ensures base-devel & git are installed (requires sudo).
#       * Clones or updates a local 'paru' directory as a normal user.
#       * Attempts to fix permissions if needed.
#       * Builds and installs paru (exits on failure).
#       * Removes the 'paru' directory only after a successful install.
#   - Installs (via paru) a list of packages, skipping those already installed.
#   - Must be run as a normal user. Only uses sudo for `pacman` commands.

set -euo pipefail

#######################################
# 0) Exit if script is run as root    #
#######################################
if [[ $EUID -eq 0 ]]; then
    echo "ERROR: This script must NOT be run as root or with sudo."
    echo "       Run it as a normal user. The script will prompt for sudo when needed."
    exit 1
fi

#######################################
# 1) Function to install paru         #
#######################################
install_paru() {
    echo "paru is not installed. Proceeding with installation..."

    # Step 1: Ensure git & base-devel are installed (system-level -> requires sudo).
    sudo pacman -S --needed --noconfirm git base-devel

    # Step 2: If paru dir does not exist, clone it. Otherwise, attempt to reuse existing.
    if [[ ! -d "paru" ]]; then
        echo "Cloning paru from the AUR..."
        if ! git clone https://aur.archlinux.org/paru.git; then
            echo "ERROR: Failed to clone paru repository from AUR."
            exit 1
        fi
    else
        echo "Directory 'paru' already exists. Reusing existing directory."
        pushd paru >/dev/null

        # (A) Fix ownership if we do not have write permission
        if [[ ! -w . ]]; then
            echo "WARNING: You do not have write permissions on the 'paru' directory."
            echo "Attempting to fix ownership with sudo..."
            # Attempt to correct ownership so current user can write
            sudo chown -R "$USER":"$USER" .
        fi

        # (B) Attempt a git pull (may fail if git marks it as 'dubious ownership')
        echo "Pulling the latest changes (if any)..."
        if ! git pull --rebase; then
            echo "WARNING: 'git pull --rebase' failed. Possible 'dubious ownership' or other git error."
            echo "If you see 'dubious ownership' warnings, run:"
            echo "  git config --global --add safe.directory \"$(pwd)\""
            echo "Continuing with the existing repo."
        fi
        popd >/dev/null
    fi

    # Step 3: Build and install paru (must be done as normal user, not root).
    pushd paru >/dev/null
    echo "Building and installing paru..."
    if makepkg -si --noconfirm; then
        echo "paru was installed successfully."
        popd >/dev/null
        # Remove directory only after successful install
        echo "Removing 'paru' directory..."
        rm -rf paru
    else
        echo "ERROR: Failed to build or install paru. Directory retained for debugging."
        popd >/dev/null
        exit 1
    fi
}

#######################################
# 2) Main Execution                   #
#######################################

# 2a) Check if paru is already installed.
if command -v paru &>/dev/null; then
    echo "paru is already installed. Skipping installation."
else
    install_paru
fi

# 2b) List of packages to install via paru
packages=(
    uwsm
    dunst
    hypridle
    hyprpaper
    hyprland
    hyprlock
    waybar
    xdg-desktop-portal-hyprland
    xdg-desktop-portal
)

# 2c) Install or skip each package
echo "Checking required packages..."
for package in "${packages[@]}"; do
    # Check if installed in official repos
    if pacman -Q "$package" &>/dev/null; then
        echo "[$package] is already installed (official repository). Skipping."
        continue
    fi
    # Check if installed via AUR
    if paru -Q "$package" &>/dev/null; then
        echo "[$package] is already installed (AUR). Skipping."
        continue
    fi

    # If not installed anywhere, install via paru
    echo "Installing [$package]..."
    if paru -S --noconfirm "$package"; then
        echo "[$package] installed successfully."
    else
        echo "ERROR: Failed to install [$package]."
    fi
done

echo "All package checks complete!"

