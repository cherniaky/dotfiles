# dotfiles

My macOS development environment config.

## What's inside

| Area | Config | Description |
|------|--------|-------------|
| Shell | `.zshrc`, `.zprofile`, `.zshenv`, `.profile` | Oh My Zsh with `zsh-vi-mode` (`kj` to escape), zoxide, nvm, aliases |
| Editor | `.cursor/` | Cursor settings — vim mode, harpoon bindings, relative line numbers, format on save, ESLint default formatter |
| Tiling WM | `.aerospace.toml` | AeroSpace — vim-style focus/move (`alt-hjkl`), 5 workspaces, zero gaps |
| Terminal | `.tmux.conf` | tmux — 1-indexed windows/panes |
| AI | `.claude/` | Claude Code — custom statusline (model, branch, usage %), notification hook, usage fetch |
| Keyboard | `.config/kanata/`, `com.example.kanata.plist` | Kanata keyboard remapping with LaunchAgent |
| Git | `.gitconfig`, `.config/git/ignore`, `.config/gh/config.yml` | Git LFS, gh CLI (`co` alias for `pr checkout`) |
| Scripts | `scripts/tmux-sessionizer` | fzf-powered tmux session picker (`ctrl-f`) |

## Prerequisites

- [Oh My Zsh](https://ohmyz.sh/) + [zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode)
- [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- [Cursor](https://cursor.com)
- [Claude Code](https://github.com/anthropics/claude-code)
- [terminal-notifier](https://github.com/julienXX/terminal-notifier) (for Claude notification hook)
- [zoxide](https://github.com/ajeetdsouza/zoxide), [fzf](https://github.com/junegunn/fzf), [exa](https://github.com/ogham/exa)
- [nvm](https://github.com/nvm-sh/nvm)
- [Kanata](https://github.com/jtroo/kanata) (optional, keyboard remapping)

## Install

```sh
git clone https://github.com/sudo-yurii-cherniak/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script symlinks everything to `~` (and `~/Library/Application Support/Cursor/User/` for Cursor settings). Existing files are backed up as `.bak`. Cursor extensions from `extensions.txt` are installed automatically if the `cursor` CLI is available.
