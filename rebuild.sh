#!/bin/bash
# A rebuild script that commits on a successful build
set -euo pipefail

# Configuration
CONFIG_DIR="$HOME/nixos"
FLAKE_CONFIG="$CONFIG_DIR#default"
LOG_FILE="nixos-switch.log"

# cd to your config dir
pushd "$CONFIG_DIR"

# Check for changes in .nix files (both staged and unstaged)
if git diff --quiet HEAD -- '*.nix' '**/*.nix' && git diff --quiet --cached -- '*.nix' '**/*.nix'; then
    echo "No changes detected in .nix files, exiting."
    popd
    exit 0
fi

# Show your changes
git diff HEAD -- '*.nix' '**/*.nix'

# Confirm before proceeding (optional - remove if you want automatic)
read -p "Proceed with rebuild? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "Rebuild cancelled."
    popd
    exit 0
fi

echo "NixOS Rebuilding..."

# Rebuild with better error handling
if ! sudo nixos-rebuild switch --flake "$FLAKE_CONFIG" &>"$LOG_FILE"; then
    echo "❌ Build failed! Error log:"
    grep -i error "$LOG_FILE" || echo "No specific errors found. Full log:"
    tail -20 "$LOG_FILE"
    popd
    exit 1
fi

echo "✅ Build successful!"

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep True | awk '{print $1}')

# Get generation info for commit message
gen_info=$(nixos-rebuild list-generations | grep True | awk '{print $1 " " $3}')

# Commit all changes with more detailed metadata
git add .
git commit -m "nixos: generation $current

Built on: $(date)
Kernel: $(nixos-rebuild list-generations | grep True | awk '{print $5}')
"

# Push with error handling
if ! git push; then
    echo "⚠️  Git push failed, but build was successful"
    notify-send -e "NixOS Rebuilt OK! (Push failed)" --icon=software-update-available
else
    echo "✅ Changes pushed to remote"
    notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
fi

# Clean up old log files (keep last 5)
ls -t nixos-switch.log.* 2>/dev/null | tail -n +6 | xargs rm -f 2>/dev/null || true
mv "$LOG_FILE" "$LOG_FILE.$(date +%Y%m%d_%H%M%S)"

# Back to where you were
popd

echo "🎉 Rebuild complete! Generation: $current"
