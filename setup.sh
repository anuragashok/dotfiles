#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Starting system setup...${NC}"

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}Please do not run this script as root${NC}"
    exit 1
fi

# Check if Ansible is installed
if ! command -v ansible >/dev/null 2>&1; then
    echo -e "${YELLOW}Installing Ansible...${NC}"
    if command -v apt-get >/dev/null 2>&1; then
        sudo apt-get update
        sudo apt-get install -y ansible
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y ansible
    elif command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm ansible
    else
        echo -e "${RED}Unsupported package manager${NC}"
        exit 1
    fi
fi

# Run Ansible playbook
echo -e "${YELLOW}Running Ansible playbook...${NC}"
ansible-playbook ansible/setup.yml --ask-become-pass

echo -e "${GREEN}Setup complete!${NC}"
echo -e "${YELLOW}Please restart your shell to apply changes${NC}" 