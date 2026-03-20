#!/bin/bash
# Symlink dotfiles to home directory
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="$HOME"

files=(
  .tmux.conf
  .zshrc
  .zprofile
  .zshenv
  .profile
  .gitconfig
  .aerospace.toml
  .config/gitui/key_bindings.ron
  .config/git/ignore
  .config/gh/config.yml
  .config/kanata/kanata.kbd
  .claude/settings.json
  .claude/statusline-command.sh
  .claude/fetch-usage.sh
  .claude/hooks/notification-alert.sh
  .cursor/cli-config.json
  .cursor/mcp.json
  .cursor/extensions.txt
  scripts/start_kanata
  scripts/tmux-sessionizer
  scripts/dotfiles-sync
  com.example.kanata.plist
)

for file in "${files[@]}"; do
  src="$DOTFILES_DIR/$file"
  dest="$HOME_DIR/$file"

  mkdir -p "$(dirname "$dest")"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up $dest → ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi

  ln -sf "$src" "$dest"
  echo "Linked $file"
done

# Neovim config (symlink entire directory)
NVIM_SRC="$DOTFILES_DIR/nvim"
NVIM_DEST="$HOME_DIR/.config/nvim"
if [ -e "$NVIM_DEST" ] && [ ! -L "$NVIM_DEST" ]; then
  echo "Backing up $NVIM_DEST → ${NVIM_DEST}.bak"
  mv "$NVIM_DEST" "${NVIM_DEST}.bak"
fi
mkdir -p "$(dirname "$NVIM_DEST")"
ln -sf "$NVIM_SRC" "$NVIM_DEST"
echo "Linked nvim config"

# Cursor user settings (stored in Application Support, not home dir)
CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
cursor_files=(settings.json keybindings.json)
for file in "${cursor_files[@]}"; do
  src="$DOTFILES_DIR/.cursor/$file"
  dest="$CURSOR_USER_DIR/$file"
  if [ -f "$src" ]; then
    mkdir -p "$CURSOR_USER_DIR"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "Backing up $dest → ${dest}.bak"
      mv "$dest" "${dest}.bak"
    fi
    ln -sf "$src" "$dest"
    echo "Linked .cursor/$file → Cursor User settings"
  fi
done

# Install Cursor extensions
if command -v cursor &> /dev/null && [ -f "$DOTFILES_DIR/.cursor/extensions.txt" ]; then
  echo "Installing Cursor extensions..."
  while IFS= read -r ext; do
    [ -z "$ext" ] && continue
    cursor --install-extension "$ext" 2>/dev/null || echo "  Skipped $ext"
  done < "$DOTFILES_DIR/.cursor/extensions.txt"
fi

echo "Done! All dotfiles linked."
