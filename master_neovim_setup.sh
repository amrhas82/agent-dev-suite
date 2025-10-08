#!/bin/bash

# Complete Neovim + nvim-tree Setup Script
# This master script runs both installation and configuration

set -e

echo "========================================"
echo "  Neovim + nvim-tree Complete Setup"
echo "========================================"
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then 
    echo "Please do not run this script as root"
    echo "The script will ask for sudo password when needed"
    exit 1
fi

# Create temp directory for scripts
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# ==========================================
# STEP 1: Installation
# ==========================================

echo "STEP 1: Installing Neovim and dependencies..."
echo ""

cat > install.sh << 'INSTALL_EOF'
#!/bin/bash
set -e

echo "Updating package list..."
sudo apt update

echo "Installing prerequisites..."
sudo apt install -y \
    curl \
    git \
    build-essential \
    unzip \
    gettext \
    cmake \
    ripgrep \
    fd-find

echo "Installing Node.js..."
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
fi

echo "Installing lazygit..."
if ! command -v lazygit &> /dev/null; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz
fi

echo "Adding Neovim PPA..."
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt update
sudo apt install -y neovim

echo "Installing vim-plug..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p ~/.config/nvim

echo "✓ Installation complete"
INSTALL_EOF

chmod +x install.sh
./install.sh

# ==========================================
# STEP 2: Configuration
# ==========================================

echo ""
echo "STEP 2: Creating Neovim configuration..."
echo ""

CONFIG_DIR="$HOME/.config/nvim"
INIT_FILE="$CONFIG_DIR/init.vim"

if [ -f "$INIT_FILE" ]; then
    echo "Backing up existing configuration..."
    cp "$INIT_FILE" "$INIT_FILE.backup.$(date +%Y%m%d_%H%M%S)"
fi

cat > "$INIT_FILE" << 'CONFIG_EOF'
set number
set relativenumber
set mouse=a
set ignorecase
set smartcase
set hlsearch
set incsearch
set expandtab
set tabstop=4
set shiftwidth=4
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
call plug#end()

colorscheme tokyonight-night

lua << END
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 35,
    side = "left",
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
})

require('lualine').setup {
  options = {
    theme = 'tokyonight',
    component_separators = '|',
    section_separators = '',
  },
}

require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "vim", "python", "javascript", "html", "css", "bash" },
  highlight = {
    enable = true,
  },
}

require('gitsigns').setup()
require('nvim-autopairs').setup()
require('Comment').setup()
END

let mapleader = " "

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>e :NvimTreeFocus<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>gg :LazyGit<CR>
nnoremap <leader>gc :LazyGitConfig<CR>
nnoremap <leader>gf :LazyGitFilter<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
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

autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'cd' argv()[0] | execute 'NvimTreeOpen' | endif
autocmd BufEnter * if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
CONFIG_EOF

echo "✓ Configuration complete"

# ==========================================
# STEP 3: Install Plugins
# ==========================================

echo ""
echo "STEP 3: Installing Neovim plugins..."
echo ""
echo "This will open Neovim and install plugins automatically..."
sleep 2

nvim +PlugInstall +qall

# ==========================================
# Cleanup and Summary
# ==========================================

cd ~
rm -rf "$TEMP_DIR"

echo ""
echo "========================================"
echo "  ✓ Setup Complete!"
echo "========================================"
echo ""
echo "Neovim version: $(nvim --version | head -n1)"
echo ""
echo "Quick Start Guide:"
echo "  1. Open Neovim: nvim"
echo "  2. Toggle file tree: Ctrl+n"
echo "  3. Find files: Space+ff"
echo ""
echo "Configuration file: ~/.config/nvim/init.vim"
echo ""
echo "Key Bindings Summary:"
echo "  Ctrl+n          - Toggle file explorer"
echo "  Space+ff        - Find files"
echo "  Space+fg        - Search in files"
echo "  Space+gg        - Open Lazygit"
echo "  Space+w         - Save file"
echo "  Space+q         - Quit"
echo ""
echo "For full keybindings, run:"
echo "  cat ~/.config/nvim/init.vim | grep 'nnoremap'"
echo ""
echo "Enjoy your new Neovim setup!"
echo ""
