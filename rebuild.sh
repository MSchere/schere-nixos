#!/bin/bash
# A rebuild script that commits on a successful build
set -e

# cd to your config dir
pushd ~/nixos/

# Check for changes in .nix files (both staged and unstaged)
if git diff --quiet HEAD -- '*.nix' && git diff --quiet --cached -- '*.nix' && git diff --quiet HEAD -- '**/*.nix'; then
    echo "No changes detected, exiting."
    popd
    exit 0
fi

# Alternative simpler check - any changes at all in the repo
# if git diff --quiet && git diff --quiet --cached; then
#     echo "No changes detected, exiting."
#     popd
#     exit 0
# fi

# Shows your changes
git diff HEAD -- '*.nix' '**/*.nix'

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
# Fixed typo: deafult -> default
sudo nixos-rebuild switch --flake ~/nixos#default &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes with the generation metadata
git add .
git commit -m "$current"

# Back to where you were
popd

# Notify all OK!
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available

