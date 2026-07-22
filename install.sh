#!/usr/bin/env bash

set -e

DOTFILES="$HOME/dotfiles"
CONFIG="$HOME/.config"

info()    { echo -e "\e[34m[INFO]\e[0m  $*"; }
success() { echo -e "\e[32m[OK]\e[0m    $*"; }
warn()    { echo -e "\e[33m[WARN]\e[0m  $*"; }
error()   { echo -e "\e[31m[ERROR]\e[0m $*"; exit 1; }

[[ -d "$DOTFILES" ]] || error "Dotfiles not found at $DOTFILES. Clone the repo there first."

safe_link() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ]; then
        info "Already symlinked: $dst — skipping"
        return
    fi

    if [ -e "$dst" ]; then
        warn "Backing up existing: $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi

    ln -s "$src" "$dst"
    success "Linked: $dst -> $src"
}

safe_link "$DOTFILES/home/.zshrc"           "$HOME/.zshrc"
safe_link "$DOTFILES/config/alacritty"      "$CONFIG/alacritty"
safe_link "$DOTFILES/config/bspwm"          "$CONFIG/bspwm"
safe_link "$DOTFILES/config/nvim"           "$CONFIG/nvim"
safe_link "$DOTFILES/config/tmux"           "$CONFIG/tmux"
safe_link "$DOTFILES/config/fastfetch"      "$CONFIG/fastfetch"

mkdir -p "$CONFIG/zsh"

echo ""
echo "────────────────────────────────────────────────────────────"
echo "  Done! Reload your shell:  source ~/.zshrc"
echo ""
echo "  Required packages (Arch):"
echo "    bspwm sxhkd polybar picom alacritty tmux neovim"
echo "    fzf zoxide eza bat lazygit btop fastfetch yazi"
echo "    zsh-autosuggestions zsh-syntax-highlighting"
echo "    zsh-history-substring-search"
echo "    ttf-jetbrains-mono-nerd"
echo "────────────────────────────────────────────────────────────"
