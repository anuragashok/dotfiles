#!/bin/bash
set -euo pipefail

# Dotfiles setup script
# Prerequisites: bws must be installed and authenticated

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "${GREEN}[+]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; exit 1; }

# Check prerequisites
command -v bws &> /dev/null || error "bws is not installed. Install it first: https://bitwarden.com/help/secrets-manager-cli/"
bws secret list &> /dev/null || error "bws is not authenticated. Run: bws login"

# Detect OS
OS="$(uname -s)"
log "Detected OS: $OS"

# Install Ansible
if ! command -v ansible &> /dev/null; then
    log "Installing Ansible..."
    if [[ "$OS" == "Darwin" ]]; then
        # Install Homebrew if needed
        if ! command -v brew &> /dev/null; then
            log "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        brew install ansible
    elif [[ "$OS" == "Linux" ]]; then
        if command -v apt &> /dev/null; then
            sudo apt update && sudo apt install -y ansible
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y ansible
        elif command -v pacman &> /dev/null; then
            sudo pacman -S --noconfirm ansible
        else
            error "Unsupported Linux distribution"
        fi
    fi
fi

log "Ansible version: $(ansible --version | head -1)"

# Install Ansible requirements
cd "$(dirname "$0")/ansible"
log "Installing Ansible roles and collections..."
ansible-galaxy collection install -r requirements.yml
ansible-galaxy role install -r requirements.yml

# Run playbook
TAGS="${1:-}"
if [[ -n "$TAGS" ]]; then
    log "Running playbook with tags: $TAGS"
    ansible-playbook site.yml --tags "$TAGS" --ask-become-pass
else
    log "Running full playbook..."
    ansible-playbook site.yml --ask-become-pass
fi

log "Setup complete!"
