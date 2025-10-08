#!/bin/bash

# Complete Development Environment Setup Script
# Installs and configures: Neovim + nvim-tree + Lazygit + Tmux + TPM

set -e

echo "================================================"
echo "  Complete Development Environment Setup"
echo "================================================"
echo ""
echo "This script will install and configure:"
echo "  • Neovim (latest) with nvim-tree file explorer"
echo "  • Lazygit for Git management"
echo "  • Tmux (from source) with plugin manager"
echo "  • All necessary plugins and configurations"
echo ""
read -p "Continue with installation? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

# Check if running as root
if [ "$EUID" -eq 0 ]; then 
    echo "Please do not run this script as root"
    echo "The script will ask for sudo password when needed"
    exit 1
fi

# ==========================================
# PART 1: NEOVIM SETUP
# ==========================================

echo ""
echo "================================================"
echo "PART 1: Setting up Neovim"
echo "================================================"
echo ""

echo "Installing prerequisites..."
sudo apt update
sudo apt install -y \
    curl \
    git \
    build-essential \
    unzip \
    gettext \
    cmake \
    ripgrep \
    fd-find \
    software-properties-common \
    ninja-build \
    pkg-config \
    automake \
    autoconf

echo ""
echo "Installing Node.js..."
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
fi

echo ""
echo "Installing Neovim..."
# Remove old neovim if exists
sudo apt remove neovim -y 2>/dev/null || true

# Clone Neovim repository
cd ~
if [ -d "neovim" ]; then
    rm -rf neovim
fi

git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable

# Build Neovim
echo "Compiling Neovim (this takes 5-10 minutes)..."
make CMAKE_BUILD_TYPE=RelWithDebInfo

# Install Neovim
echo "Installing Neovim..."
sudo make install

cd ~
rm -rf neovim
hash -r

echo ""
echo "Installing Lazygit..."
if ! command -v lazygit &> /dev/null; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz
fi

echo ""
echo "Installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p ~/.config/nvim

echo ""
echo "Creating Neovim configuration..."
cat > ~/.config/nvim/init.vim << 'NVIM_EOF'
set number
set relativenumber
set mouse=a
set ignorecase
set smartcase
set hlsearch
set incsearch
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent
set termguicolors
set clipboard=unnamedplus
set hidden
set updatetime=300
set timeoutlen=500
set splitright
set splitbelow
set cursorline
set signcolumn=yes
set scrolloff=8
set noshowmode

call plug#begin('~/.local/share/nvim/plugged')
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'folke/tokyonight.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lewis6991/gitsigns.nvim'
Plug 'kdheepak/lazygit.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'numToStr/Comment.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

colorscheme tokyonight-night

lua << LUAEND
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 35,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = "name",
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
  },
})

require('lualine').setup({
  options = {
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    globalstatus = true,
  },
})

require('nvim-treesitter.configs').setup({
  ensure_installed = { "lua", "vim", "python", "javascript", "html", "css", "bash", "json" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
})

require('gitsigns').setup({
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
})

require('nvim-autopairs').setup()
require('Comment').setup()

require("ibl").setup({
  indent = { char = "│" },
  scope = { enabled = true },
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})
LUAEND

let mapleader = " "

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>e :NvimTreeFocus<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>f :NvimTreeFindFile<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <leader>gg :LazyGit<CR>
nnoremap <leader>gc :LazyGitConfig<CR>
nnoremap <leader>gf :LazyGitFilter<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Esc> :noh<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>
vnoremap < <gv
vnoremap > >gv

autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'cd' argv()[0] | execute 'NvimTreeOpen' | endif
autocmd BufEnter * if winnr('

echo ""
echo "Installing Neovim plugins..."
nvim +PlugInstall +qall

echo "✓ Neovim setup complete"

# ==========================================
# PART 2: TMUX SETUP
# ==========================================

echo ""
echo "================================================"
echo "PART 2: Setting up Tmux"
echo "================================================"
echo ""

echo "Installing Tmux build dependencies..."
sudo apt install -y \
    libevent-dev \
    ncurses-dev \
    bison \
    pkg-config \
    automake \
    autoconf

# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo ""
echo "Cloning Tmux repository..."
git clone https://github.com/tmux/tmux.git
cd tmux

echo ""
echo "Building Tmux from source..."
sh autogen.sh
./configure
make
sudo make install

echo ""
echo "Cleaning up old tmux socket files..."
tmux kill-server 2>/dev/null || true
rm -rf /tmp/tmux-* 2>/dev/null || true

cd ~
rm -rf "$TEMP_DIR"

echo ""
echo "Installing Tmux Plugin Manager (TPM)..."
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
    cd "$TPM_DIR"
    git pull
else
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

cd ~

echo ""
echo "Creating Tmux configuration..."
cat > ~/.tmux.conf << 'TMUX_EOF'
set-option -sa terminal-overrides ",xterm*:Tc"
set -g default-terminal "xterm-256color"
set -g mouse on

unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

bind r source-file ~/.tmux.conf\; display "Reloaded!"

bind h select-pane -L
bind j select-pane -D 
bind k select-pane -U
bind l select-pane -R

set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

bind -n S-Left  previous-window
bind -n S-Right next-window

bind -n M-H previous-window
bind -n M-L next-window

set -g @catppuccin_flavour 'mocha'
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "rounded"

set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_application}"
set -agF status-right "#{E:@catppuccin_status_cpu}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -ag status-right "#{E:@catppuccin_status_uptime}"
set -agF status-right "#{E:@catppuccin_status_battery}"

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'dreamsofcode-io/catppuccin-tmux'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-copycat'

set-window-option -g mode-keys vi

bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

bind '"' split-window -v -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"

run '~/.tmux/plugins/tpm/tpm'
TMUX_EOF

echo ""
echo "Installing Tmux plugins..."
export TERM=xterm-256color
tmux start-server
tmux new-session -d -s setup
sleep 2
"$TPM_DIR/bin/install_plugins"
tmux kill-session -t setup 2>/dev/null || true

echo "✓ Tmux setup complete"

# ==========================================
# COMPLETION SUMMARY
# ==========================================

echo ""
echo "================================================"
echo "  ✓ Complete Setup Finished!"
echo "================================================"
echo ""
echo "Installed Software:"
echo "  • Neovim: $(nvim --version | head -n1)"
echo "  • Lazygit: $(lazygit --version)"
echo "  • Tmux: $(tmux -V)"
echo "  • Node.js: $(node --version)"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "NEOVIM KEYBINDINGS (Leader = Space)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Ctrl+n          - Toggle file tree"
echo "  Space+ff        - Find files"
echo "  Space+fg        - Search in files"
echo "  Space+gg        - Open Lazygit"
echo "  Space+w         - Save file"
echo "  Space+q         - Quit"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "TMUX KEYBINDINGS (Prefix = Ctrl+a)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Ctrl+a c        - New window"
echo "  Ctrl+a %        - Split horizontal"
echo "  Ctrl+a \"        - Split vertical"
echo "  Ctrl+a h/j/k/l  - Navigate panes (vim style)"
echo "  Shift+Left/Right- Switch windows"
echo "  Ctrl+a d        - Detach session"
echo "  Ctrl+a r        - Reload config"
echo ""
echo "Quick Start:"
echo "  1. Start tmux: tmux"
echo "  2. Open nvim in tmux: nvim"
echo "  3. Toggle file tree: Ctrl+n"
echo "  4. Open git: Space+gg"
echo ""
echo "Configuration Files:"
echo "  • Neovim: ~/.config/nvim/init.vim"
echo "  • Tmux: ~/.tmux.conf"
echo ""
echo "Enjoy your new development environment! 🚀"
echo ""
) == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
NVIM_EOF

echo ""
echo "Installing Neovim plugins..."
nvim +PlugInstall +qall

echo "✓ Neovim setup complete"

# ==========================================
# PART 2: TMUX SETUP
# ==========================================

echo ""
echo "================================================"
echo "PART 2: Setting up Tmux"
echo "================================================"
echo ""

echo "Installing Tmux build dependencies..."
sudo apt install -y \
    libevent-dev \
    ncurses-dev \
    bison \
    pkg-config \
    automake \
    autoconf

# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo ""
echo "Cloning Tmux repository..."
git clone https://github.com/tmux/tmux.git
cd tmux

echo ""
echo "Building Tmux from source..."
sh autogen.sh
./configure
make
sudo make install

echo ""
echo "Cleaning up old tmux socket files..."
tmux kill-server 2>/dev/null || true
rm -rf /tmp/tmux-* 2>/dev/null || true

cd ~
rm -rf "$TEMP_DIR"

echo ""
echo "Installing Tmux Plugin Manager (TPM)..."
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ -d "$TPM_DIR" ]; then
    cd "$TPM_DIR"
    git pull
else
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

cd ~

echo ""
echo "Creating Tmux configuration..."
cat > ~/.tmux.conf << 'TMUX_EOF'
set-option -sa terminal-overrides ",xterm*:Tc"
set -g default-terminal "xterm-256color"
set -g mouse on

unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

bind r source-file ~/.tmux.conf\; display "Reloaded!"

bind h select-pane -L
bind j select-pane -D 
bind k select-pane -U
bind l select-pane -R

set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

bind -n S-Left  previous-window
bind -n S-Right next-window

bind -n M-H previous-window
bind -n M-L next-window

set -g @catppuccin_flavour 'mocha'
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "rounded"

set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_application}"
set -agF status-right "#{E:@catppuccin_status_cpu}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -ag status-right "#{E:@catppuccin_status_uptime}"
set -agF status-right "#{E:@catppuccin_status_battery}"

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'dreamsofcode-io/catppuccin-tmux'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-copycat'

set-window-option -g mode-keys vi

bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

bind '"' split-window -v -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"

run '~/.tmux/plugins/tpm/tpm'
TMUX_EOF

echo ""
echo "Installing Tmux plugins..."
export TERM=xterm-256color
tmux start-server
tmux new-session -d -s setup
sleep 2
"$TPM_DIR/bin/install_plugins"
tmux kill-session -t setup 2>/dev/null || true

echo "✓ Tmux setup complete"

# ==========================================
# COMPLETION SUMMARY
# ==========================================

echo ""
echo "================================================"
echo "  ✓ Complete Setup Finished!"
echo "================================================"
echo ""
echo "Installed Software:"
echo "  • Neovim: $(nvim --version | head -n1)"
echo "  • Lazygit: $(lazygit --version)"
echo "  • Tmux: $(tmux -V)"
echo "  • Node.js: $(node --version)"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "NEOVIM KEYBINDINGS (Leader = Space)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Ctrl+n          - Toggle file tree"
echo "  Space+ff        - Find files"
echo "  Space+fg        - Search in files"
echo "  Space+gg        - Open Lazygit"
echo "  Space+w         - Save file"
echo "  Space+q         - Quit"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "TMUX KEYBINDINGS (Prefix = Ctrl+a)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Ctrl+a c        - New window"
echo "  Ctrl+a %        - Split horizontal"
echo "  Ctrl+a \"        - Split vertical"
echo "  Ctrl+a h/j/k/l  - Navigate panes (vim style)"
echo "  Shift+Left/Right- Switch windows"
echo "  Ctrl+a d        - Detach session"
echo "  Ctrl+a r        - Reload config"
echo ""
echo "Quick Start:"
echo "  1. Start tmux: tmux"
echo "  2. Open nvim in tmux: nvim"
echo "  3. Toggle file tree: Ctrl+n"
echo "  4. Open git: Space+gg"
echo ""
echo "Configuration Files:"
echo "  • Neovim: ~/.config/nvim/init.vim"
echo "  • Tmux: ~/.tmux.conf"
echo ""
echo "Enjoy your new development environment! 🚀"
echo ""
