# Pass Password Manager - Installation and Usage Guide

## Installation

### Install Pass
```bash
# Install password manager with git option
sudo apt install pass
```

## GPG Key Setup

### Generate GPG Key
```bash
# Generate a new GPG key
gpg --gen-key
```

### Display Keys
```bash
# Display all keys
gpg -K
```

### Set Key to Not Expire
```bash
# Edit key settings
gpg --edit-key xxxxxxx
gpg> expire
# Follow prompts to set no expiration
```

### Create Backup Keys
```bash
# Create public key for recovery
gpg --output public.gpg --armor --export avoidaccess@msn.com

# Create private key for recovery
gpg --output private.gpg --armor --export-secret-key avoidaccess@msn.com
```

### Set Key Trust Level
```bash
# Edit key to set trust level
gpg --edit-key avoidaccess@msn.com
gpg> trust
# Select option 5 (ultimate trust)
gpg> quit
```

## Pass Store Initialization

### Initialize Pass Store
```bash
# Initialize pass store using your GPG key ID
pass init xxxxxx
```

### Initialize Git Repository
```bash
# Initialize git repository for pass store
pass git init xxxxxx
# Or simply
pass git init
```

## Basic Pass Operations

### Generate Passwords
```bash
# Generate a password under specific directory
pass generate for/provider
```

### Find Passwords
```bash
# Find passwords by name
pass find
```

### Edit Passwords
```bash
# Edit a password entry
pass edit for/provider
```

### Search Passwords
```bash
# Search for specific content
pass grep "info@email.com"
pass grep "email:"
```

### Display Passwords
```bash
# Display password on screen
pass show for/provider

# Copy password to clipboard
pass show -c for/provider
```

### Remove Passwords
```bash
# Remove a password entry
pass rm for/provider
```

## Git Operations

### Check Git
```bash
# Check commit log
pass git log

# Check commit log
pass git branch -a
```


### Revert Changes
```bash
# Revert last git change
pass git revert HEAD
```

### Create initial commit
```bash
cd ~/.password-store
pass git add .
pass git commit -m "Initial password store commit"
pass git push -u origin master
```

### Rename branch to main
```bash
cd ~/.password-store
git branch -M main
pass git push -u origin main
```

### Push to Remote Repository
```bash
# Add remote repository
pass git remote set-url origin https://github.com/amrhas82/store.git

# Push to remote
pass git push origin master
```

## Setting Up on New Machine

### Import Keys
```bash
# Navigate to exported keys directory
cd exported-keys

# Import private key
gpg --import private.gpg

# Import public key
gpg --import public.gpg
```

### Test Access
```bash
# Test password access
pass show for/provider
```

## Using Pass in Scripts

### Export Passwords to Environment Variables
```bash
# Use pass to set environment variables
export GITHUB_TOKEN=$(pass show for/provider)
echo $GITHUB_TOKEN
```

## Directory Structure

Pass organizes passwords in a hierarchical structure:
```
pass/
├── for/
│   ├── provider/
│   │   └── password.gpg
│   └── provider2/
│       └── password.gpg
└── for2/
    └── provider/
        └── password.gpg
```

## Best Practices

1. **Regular Backups**: Always keep your GPG keys backed up securely
2. **Git Integration**: Use git to track changes and sync across devices
3. **Strong Passwords**: Use `pass generate` for strong, unique passwords
4. **Organize Structure**: Use meaningful directory structures (e.g., `work/github`, `personal/email`)
5. **Environment Variables**: Use pass to securely manage API keys and tokens in scripts

## Troubleshooting

### Common Issues
- **GPG Key Issues**: Ensure your GPG key is properly imported and trusted
- **Git Sync Issues**: Check your git remote configuration and authentication
- **Permission Issues**: Ensure proper file permissions on the pass store directory

### Useful Commands
```bash
# Check pass store status
pass ls

# Check git status
pass git status

# List all entries recursively
pass ls -R
```

## Security Notes

- Never commit your private GPG key to version control
- Store backup keys in a secure location
- Use strong passphrases for your GPG keys
- Regularly update your GPG keys and pass installation
