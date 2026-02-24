# Dotfiles (Hyprland setup)

Base configs for Hyprland + Wayland tools, terminals, prompt, and related utilities.

## What’s included
- Hypr: `.config/hypr/`
- Waybar: `.config/waybar/`
- Waypaper: `.config/waypaper/`
- Mako: `.config/mako/`
- SwayOSD: `.config/swayosd/`
- UWSM: `.config/uwsm/`
- Terminals: `.config/alacritty/`, `.config/ghostty/`
- Prompt: `.config/starship.toml`
- System info: `.config/fastfetch/`
- BTOP: `.config/btop/`
- Environment: `.config/environment.d/`
- Input: `.config/fcitx5/`

## Sync from current system into repo
1) Ensure the sync script is executable:
   ```bash
   chmod +x scripts/sync-config.sh
   ```
2) Run sync (from repo root or anywhere):
   ```bash
   ./scripts/sync-config.sh
   ```
   This mirrors the listed items from `~/.config` into `./.config` (and deletes files inside those synced subfolders that don’t exist in `~/.config`).

## Publish to GitHub
- Initialize and commit (first time):
  ```bash
  git init
  git add .
  git commit -m "Add Hyprland base dotfiles"
  ```
- Push (after configuring SSH or HTTPS):
  ```bash
  git push -u origin main
  ```

## Apply on a new machine
1) Install `stow`:
   ```bash
   sudo pacman -S stow
   ```
2) Clone:
   ```bash
   git clone git@github.com:zieqs/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```
3) Symlink configs:
   ```bash
   stow -t ~/.config .config
   ```
   Or pick subsets (examples):
   ```bash
   stow -t ~/.config .config/hypr .config/waybar .config/mako
   ```

## Notes
- Keep secrets (tokens/keys) out of tracked configs or add them to `.gitignore`.
- Update the repo after local changes by rerunning `./scripts/sync-config.sh`, then `git add/commit/push`.
- If you add more tools/configs, include them in `scripts/sync-config.sh` and adjust `.gitignore` if needed.