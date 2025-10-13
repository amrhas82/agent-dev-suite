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
### Cursor
```bash
#Install Cursor agent
curl https://cursor.com/install -fsS | bash
```

### Pass password manager  [Pass Installation Guide](PASS_INSTALLATION_GUIDE.md)
```bash
#Install pass and follow instructions on
sudo apt install pass
```

### Sublime text editor
```bash
# Install GPG key
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null

# Add repository
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Update and install
sudo apt update
sudo apt install sublime-text
```

### Lite XL Markdown editor
```bash
# Build from script
sudo apt update
sudo apt install build-essential libsdl2-dev libfreetype6-dev
```

### Pycharm Community
```bash
#Install Pycharm Community classic
sudo snap install pycharm-professional --classic
```

### Ghostty Terminal
```bash
sudo snap install ghostty --classic
```

### Tmux [Full setup guide ](tmux-install-guide.md)

```bash
# 1. Clone the Repository
git clone https://github.com/tmux/tmux.git
cd tmux

# 2. Build and Install 

sh autogen.sh
./configure
make
sudo make install
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
# install gh auth
sudo apt install gh
```

### Update Git to Latest Version
```bash
wget https://github.com/git/git/archive/refs/tags/v2.40.0.tar.gz
tar -zxf v2.40.0.tar.gz
cd git-2.40.0
make prefix=/usr/local all
sudo make prefix=/usr/local install

#or from download from snap
sudo apt install git
git --version
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
# search for it
ls -a ~ | grep .tmux.conf

# or wider search
find / -name "tmux.conf" 2>/dev/null

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
