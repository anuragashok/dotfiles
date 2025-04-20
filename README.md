# Dotfiles Management System

This repository contains configuration files and setup scripts for managing multiple systems using Ansible and chezmoi.

## Structure

- `ansible/` - Contains Ansible playbooks for system setup
- `setup.sh` - Bootstrap script for new systems
- `chezmoi/` - Dotfiles managed by chezmoi

## Setup

To set up a new system:

```bash
# Clone the repository
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles

# Run the setup script
./setup.sh
```

## Requirements

- Ansible
- chezmoi
- zsh
- git

## License

MIT 