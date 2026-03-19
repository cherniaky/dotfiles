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
  .config/karabiner/karabiner.json
  .config/gitui/key_bindings.ron
  .config/git/ignore
  .config/gh/config.yml
  .config/kanata/kanata.kbd
  .claude/settings.json
  .claude/statusline-command.sh
  .claude/fetch-usage.sh
  scripts/start_kanata
  scripts/tmux-sessionizer
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

echo "Done! All dotfiles linked."
