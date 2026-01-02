#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DOTFILES_DIR="$HOME/dotfiles"

echo -e "${GREEN}Setting up dotfiles...${NC}"

# Create directories
mkdir -p ~/.config/i3/scripts
mkdir -p ~/.config/kitty
mkdir -p ~/.config/helix
mkdir -p ~/.config/zellij

# Function to create symlink
link() {
    rm -f "$2" 2>/dev/null
    ln -s "$1" "$2"
    echo "Linked $1 -> $2"
}

# Link configs
link "$DOTFILES_DIR/i3/config" "$HOME/.config/i3/config"
link "$DOTFILES_DIR/helix/config.toml" "$HOME/.config/helix/config.toml"
link "$DOTFILES_DIR/helix/languages.toml" "$HOME/.config/helix/languages.toml"
link "$DOTFILES_DIR/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"
link "$DOTFILES_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# Link i3 scripts
for script in $DOTFILES_DIR/i3-scripts/*.sh; do
    if [ -f "$script" ]; then
        script_name=$(basename "$script")
        link "$DOTFILES_DIR/i3-scripts/$script_name" "$HOME/.config/i3/scripts/$script_name"
    fi
done

# Make scripts executable
chmod +x $DOTFILES_DIR/i3-scripts/*.sh

echo -e "${GREEN}✓ Setup complete!${NC}"
echo -e "${YELLOW}Reload i3 with Mod+Shift+r${NC}"
