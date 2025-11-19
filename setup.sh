#!/usr/bin/env bash
set -Eeuo pipefail

# Minimal setup for configs + vicinae + services.
# Expected repo layout:
#   ./install-packages.sh (optional)
#   ./vicinae/{vicinae.json,vicinae.db}
#   ./keyd/default.conf    (optional)
#   ./[alacritty|bspwm|dunst|eww|hypr|niri|polybar|rofi|sxhkd|wezterm|zsh|waybar|DankMaterialShell]

cd "$(dirname "${BASH_SOURCE[0]}")"

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"

VIC_CFG="$CONFIG_DIR/vicinae"
VIC_DATA="$DATA_DIR/vicinae"

say() { printf '%s\n' "$*"; }

# 1) Packages (optional)
[[ -x ./install-packages.sh ]] && { say "Installing packages..."; ./install-packages.sh; }

echo -e "\n=================================================================================\n\n"


# 2) Configs → ~/.config (XDG)
say "Syncing configs to $CONFIG_DIR"
mkdir -p "$CONFIG_DIR" "$VIC_CFG" "$VIC_DATA"

CONFIG_ITEMS=(niri DankMaterialShell alacritty wezterm dunst rofi bspwm polybar sxhkd zsh eww hypr waybar)
for item in "${CONFIG_ITEMS[@]}"; do
  [[ -e "$item" ]] && cp -a "$item" "$CONFIG_DIR/"
done

# vicinae config + data
[[ -f vicinae/vicinae.json ]] && install -Dm644 vicinae/vicinae.json "$VIC_CFG/vicinae.json"
[[ -f vicinae/vicinae.db   ]] && install -Dm600 vicinae/vicinae.db   "$VIC_DATA/vicinae.db"

# 3) keyd (optional)
if [[ -f keyd/default.conf ]]; then
  say "Installing keyd config"
  sudo install -Dm644 keyd/default.conf /etc/keyd/default.conf
fi

# 4) zsh (optional)
if [[ -f "$CONFIG_DIR/zsh/.zshrc" ]]; then
  say "Linking .zshrc"
  ln -sfn "$CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc"
fi

# 5) Services
say "Enabling services (best effort)"
systemctl --user enable dms.service
sudo systemctl enable seatd.service
sudo systemctl enable greetd.service

dms greeter enable || true
dms greeter sync   || true

say "Done."
