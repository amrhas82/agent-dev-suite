##INSTALL
#tmux
tmux > sudo apt install tmux
tmux plugin manager > git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

##https://www.youtube.com/watch?v=DzNmUNvnB04
##CONFIG > nano ~/.tmux.conf  # You can use any text editor, e.g., vim, nano, or code


	vim tmux navigator
cd ~/.config/nvim

lua/custom/configs

> plugins.lua

local plugins = {
{
	"christoomey/vim-tmux-navigator"
	lazy = false
}

> mappings.lua

	M.general = {
		n = {
			["<C-h>"] = {"<cmd>" TmuxNavigateLeft<CR>, "window left"},
			["<C-l>"] = {"<cmd>" TmuxNavigateLeft<CR>, "window right"},
			["<C-j>"] = {"<cmd>" TmuxNavigateLeft<CR>, "window down"},
			["<C-k>"] = {"<cmd>" TmuxNavigateLeft<CR>, "window up"},
			}
	}

> tmux.config
	set -g @plugin 'christoomey/vim-tmux-navigator'
	run '~/.tmux/plugins/tpm/tpm'

> tmux source ~/.config/tmux/tmux.conf
