#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Installing essential i3 tools...${NC}"

# Update package list
sudo apt update

# Core i3 setup (from your list + essentials)
echo -e "${YELLOW}Installing i3 window manager essentials...${NC}"
sudo apt install -y \
    i3 \
    i3lock-fancy \
    i3status \
    rofi \
    dunst \
    picom \
    feh \
    arandr \
    flameshot \
    pamixer \
    brightnessctl \
    xss-lock \
    kitty \
    copyq

# Development tools you use
echo -e "${YELLOW}Installing your development tools...${NC}"
sudo apt install -y \
    helix \
    fzf \
    git

# Install Zellij (not in apt)
if ! command -v zellij &> /dev/null; then
    echo -e "${YELLOW}Installing Zellij...${NC}"
    curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz | tar xz
    sudo mv zellij /usr/local/bin/
fi

# Install Lazygit (not in apt)
if ! command -v lazygit &> /dev/null; then
    echo -e "${YELLOW}Installing Lazygit...${NC}"
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz
fi

echo -e "${GREEN}✓ i3 essentials installed!${NC}"
echo -e "${YELLOW}Now run ./setup.sh to link your configs${NC}"
