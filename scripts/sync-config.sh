#!/usr/bin/env bash
set -euo pipefail

# Sync selected configs from ~/.config into the repo's .config directory.
# Run this from anywhere; it resolves the repo root relative to this script.
# Make sure this file is executable: chmod +x scripts/sync-config.sh

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
DEST="${REPO_ROOT}/.config"

mkdir -p "${DEST}"

rsync -av --delete \
  "$HOME/.config/hypr" \
  "$HOME/.config/waybar" \
  "$HOME/.config/waypaper" \
  "$HOME/.config/mako" \
  "$HOME/.config/swayosd" \
  "$HOME/.config/uwsm" \
  "$HOME/.config/alacritty" \
  "$HOME/.config/ghostty" \
  "$HOME/.config/btop" \
  "$HOME/.config/environment.d" \
  "$HOME/.config/fcitx5" \
  "$HOME/.config/fastfetch" \
  "$HOME/.config/starship.toml" \
  "${DEST}"

echo "Sync complete -> ${DEST}"
