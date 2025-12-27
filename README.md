# Dotfiles

Ansible-managed dotfiles with Bitwarden Secrets Manager (BWS) for configuration.

## Prerequisites

1. **Install BWS CLI**: https://bitwarden.com/help/secrets-manager-cli/
2. **Authenticate**: `bws login`

## Quick Start

```bash
./setup.sh
```

## Selective Setup

```bash
# Only packages
./setup.sh packages

# Only dotfiles
./setup.sh dotfiles

# Only zsh
./setup.sh zsh

# Only macOS defaults
./setup.sh macos
```

## Structure

```
.
├── setup.sh                    # Bootstrap script
└── ansible/
    ├── site.yml                # Main playbook
    ├── requirements.yml        # External roles
    ├── group_vars/
    │   └── all.yml             # Variables + BWS secret IDs
    └── roles/
        ├── dotfiles/           # Deploys config files
        │   ├── tasks/
        │   ├── templates/      # .zshrc, .gitconfig, etc.
        │   └── files/          # Static files (p10k.zsh)
        └── macos/              # macOS system preferences
```

## Configuration

Edit [ansible/group_vars/all.yml](ansible/group_vars/all.yml):

```yaml
# Machine type
machine_type: personal  # or: work, server

# BWS Secret IDs
bws_secrets:
  git_name: "your-secret-id"
  git_email: "your-secret-id"
  github_token: "your-secret-id"

# Packages
homebrew_packages:
  - git
  - neovim
  # ...
```

## Adding a New Machine

1. Clone repo
2. Install and authenticate BWS
3. Update `machine_type` in `group_vars/all.yml` if needed
4. Run `./setup.sh`

## Adding New Dotfiles

1. Add template to `ansible/roles/dotfiles/templates/`
2. Add task to `ansible/roles/dotfiles/tasks/main.yml`
3. Run `./setup.sh dotfiles`
