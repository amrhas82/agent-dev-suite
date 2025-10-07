# Ubuntu Development Tools Setup Guide

## Table of Contents
- [Terminal Tools](#terminal-tools)
- [Development Tools](#development-tools)
- [Git Tools](#git-tools)
- [Tmux Configuration](#tmux-configuration)
- [Neovim with Tmux Navigator](#neovim-with-tmux-navigator)

## Terminal Tools

### Claude code
```bash
npm install -g @anthropic-ai/claude-code

#Install stable version (default)
curl -fsSL https://claude.ai/install.sh | bash
```

### Ghostty Terminal
```bash
sudo snap install ghostty --classic
```

### Tmux
```bash
sudo apt update
sudo apt install tmux
```

### Tmux Plugin Manager (TPM)
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Development Tools

### Neovim
```bash
sudo snap install nvim --classic
```

### AmpCode
```bash
curl -fsSL https://ampcode.com/install.sh | bash
amp --jetbrains
```

## Git Tools

### Lazygit
```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
lazygit --version
```

### Update Git to Latest Version
```bash
wget https://github.com/git/git/archive/refs/tags/v2.40.0.tar.gz
tar -zxf v2.40.0.tar.gz
cd git-2.40.0
make prefix=/usr/local all
sudo make prefix=/usr/local install
git --version
```

## Tmux Configuration

### Complete Tmux Configuration
Create or edit `~/.tmux.conf`:
mkdir ~/.tmuf.conf
nano ~/.tmuf.conf

```tmux
set-option -sa terminal-overrides ",xterm*:Tc"

# Turn mouse on
set -g mouse on

# Change Prefix from Ctrl+b to Ctrl+a
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# tmux.conf hot reload
bind r source-file ~/.tmux.conf\; display "Reloaded!"

# Fix backspace issue
set -g default-terminal "xterm-256color"

# Vim style pane selection
bind h select-pane -L
bind j select-pane -D 
bind k select-pane -U
bind l select-pane -R

# Start windows and panes at 1, not 0
set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

# Use Alt-arrow keys without prefix key to switch panes
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Shift arrow to switch windows
bind -n S-Left  previous-window
bind -n S-Right next-window

# Shift Alt vim keys to switch windows
bind -n M-H previous-window
bind -n M-L next-window

# set catpuccin color them
set -g @catppuccin_flavour 'mocha'
# Configure the catppuccin plugin
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "rounded"

# Load catppuccin
run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux
# For TPM, instead use `run ~/.tmux/plugins/tmux/catppuccin.tmux`

# Make the status line pretty and add some modules
set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_application}"
set -agF status-right "#{E:@catppuccin_status_cpu}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -ag status-right "#{E:@catppuccin_status_uptime}"
set -agF status-right "#{E:@catppuccin_status_battery}"

run ~/.config/tmux/plugins/tmux-plugins/tmux-cpu/cpu.tmux
run ~/.config/tmux/plugins/tmux-plugins/tmux-battery/battery.tmux
# Or, if using TPM, just run TPM


# Set al Plugins options
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'dreamsofcode-io/catppuccin-tmux'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-copycat'

run '~/.tmux/plugins/tpm/tpm'

# set vi-mode
set-window-option -g mode-keys vi
# keybindings
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

bind '"' split-window -v -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
```

### Setup Steps for Tmux

1. **Install Tmux Plugin Manager:**
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#check if you have git installed 
ls ~/.tmux/plugins/tpm

#go to git location
cd ~/.tmux/plugins/tpm

#check git status
git status
```

2. **Create the tmux configuration:**
```bash
# Create the file
nano ~/.tmux.conf

# Or if using the default config directory
mkdir -p ~/.config/tmux
nano ~/.config/tmux/tmux.conf
```

3. **Reload tmux configuration:**
```bash
# If using ~/.tmux.conf
tmux source-file ~/.tmux.conf

# If using ~/.config/tmux/tmux.conf
tmux source-file ~/.config/tmux/tmux.conf
```

4. **Install plugins (inside tmux):**
Press `Prefix + I` (now `Ctrl + Space` followed by `I`) to install all plugins.

## Neovim with Tmux Navigator

### Configure Neovim

1. **Navigate to Neovim config directory:**
```bash
mkdir -p ~/.config/nvim/lua/custom
cd ~/.config/nvim
```

2. **Create/edit plugins configuration** (`lua/custom/plugins.lua`):
```lua
local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false
  }
}

return plugins
```

3. **Configure key mappings** (`lua/custom/mappings.lua`):
```lua
local M = {}

M.general = {
  n = {
    ["<C-h>"] = {"<cmd> TmuxNavigateLeft<CR>", "window left"},
    ["<C-l>"] = {"<cmd> TmuxNavigateRight<CR>", "window right"},
    ["<C-j>"] = {"<cmd> TmuxNavigateDown<CR>", "window down"},
    ["<C-k>"] = {"<cmd> TmuxNavigateUp<CR>", "window up"},
  }
}

return M
```

### Key Binding Summary

**Tmux Prefix:** `Ctrl + Space` (instead of default `Ctrl + b`)

**Pane Navigation:**
- `Prefix + h/j/k/l` - Navigate panes with prefix
- `Alt + Arrow Keys` - Navigate panes without prefix
- `Alt + H/L` - Switch windows without prefix

**Window Management:**
- `Shift + Left/Right` - Switch between windows
- `"` - Split window vertically
- `%` - Split window horizontally

**Others:**
- `Prefix + c` = create new window
- `Prefix + 1` = window selection
- `tmux ls` = list all windows
- `Prefix + %` = split horizontal
- `Prefix + "` = split vertical
- `Prefix + R` = search commands
- `tmux kill server` = exit all terminals
- `tmux kill-session` = kill current session
- `tmux kill-session -t session_name` = close certain session
- `tmux kill-session -a` = kill all sessions but current
- `exit` = closes that window/pane
- `tmux new -s agent-ai` = create new session with a name
- `tmux rename-window "Agent AI"` = close rename current session
- `tmux source ~/.tmux.conf` = reload tmux.conf

**Copy Mode (Vi-style):**
- `Prefix + [` - Enter copy mode
- `v` - Begin selection
- `Ctrl + v` - Rectangle toggle
- `y` - Copy selection

## Installation Checklist

- [ ] Install Ghostty terminal
- [ ] Install tmux and TPM
- [ ] Configure tmux with the provided config
- [ ] Install Neovim
- [ ] Set up Neovim with tmux navigator
- [ ] Install Lazygit
- [ ] Update Git to latest version
- [ ] Install AmpCode (optional)

After setup, you'll have seamless navigation between Neovim and tmux with a beautiful Catppuccin theme and enhanced productivity workflow.
