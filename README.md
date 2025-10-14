# AI-PRDs: Development Environment & Agent Workflow Setup

A comprehensive repository providing Ubuntu/Debian development environment setup tools and AI agent workflow guides for structured feature development.

> **Note:** All setup tools and scripts are designed exclusively for **Ubuntu/Debian** Linux distributions.

## 📁 Repository Structure

### `/tools` - Development Environment Setup

Scripts and configuration files for Ubuntu/Debian development environment setup.

**Core Installation Scripts:**

- **`dev_tools_menu.sh`** - Interactive menu for installing development tools
  - Includes: Claude Code, Ghostty Terminal, Tmux + TPM, Neovim, AmpCode, Lazygit, Git updates, PyCharm Community, Lite XL, Pass CLI, Cursor AI CLI, Sublime Text
  - Usage: `chmod +x dev_tools_menu.sh && ./dev_tools_menu.sh`

- **`master_tmux_setup.sh`** - Complete Tmux installation and configuration
  - Builds from source, installs TPM, configures Catppuccin theme
  - Vim-style navigation and custom keybindings

- **`master_neovim_setup.sh`** - Complete Neovim installation and configuration
  - Installs via PPA, sets up file explorer, Tokyonight theme
  - Integrates Lazygit, Telescope, Treesitter

- **`master_litexl_setup.sh`** - Complete Lite XL installation and configuration
  - Builds from source with SDL3 support, includes markdown preview
  - Usage: `chmod +x master_litexl_setup.sh && ./master_litexl_setup.sh`

**Documentation & Guides:**

- **`manual_setup.md`** - Step-by-step manual installation guide
  - Terminal, development, password management, AI, and Git tools
  - Configuration instructions and key binding reference

- **`tmux-install-guide.md`** - Comprehensive Tmux installation guide
  - Building from source, TPM setup, troubleshooting, configuration

- **`PASS_INSTALLATION_GUIDE.md`** - Complete Pass CLI password manager setup
  - Installation, GPG setup, password store configuration, security practices

- **`git_guide.md`** - The Ultimate Git Guide
  - Command reference, repository management, advanced operations, CI/CD workflows

**Configuration Files:**

- **`tmux.conf`** - Production-ready Tmux configuration
  - Custom prefix key (Ctrl+a), vim-style navigation, Catppuccin theme
  - Plugin integration (TPM, vim-tmux-navigator, catppuccin, yank, copycat)

**Utility Scripts:**

- **`validate_scripts.sh`** - Script validation and testing utility
  - Usage: `chmod +x validate_scripts.sh && ./validate_scripts.sh`

- **`SPLIT_SUMMARY.md`** - Repository organization summary

### `/debian_setup` - Debian System Setup & Recovery

Specialized guides for Debian-based system setup, recovery, and maintenance.

**System Setup & Recovery Guides:**

- **`clonezilla-zorin-guide.md`** - Complete Clonezilla backup and restore guide for Zorin OS
  - System backup strategies, live USB creation, full system backup/restore procedures

- **`partition_recovery_guide.md`** - Advanced partition recovery and data rescue guide
  - Recovering deleted/corrupted partitions using TestDisk, PhotoRec, GParted

- **`zorin-hibernate-guide.md`** - Zorin OS hibernation setup and configuration
  - Enabling hibernation, swap configuration, GRUB settings, troubleshooting

### `/debian_tools_scripts` - Window Manager & Productivity Tools

Comprehensive setup guides for window managers and productivity tools on Debian-based systems.

**Window Manager Setups:**

- **`bspwm_setup.md`** - Minimal but functional BSPWM rice script
  - Complete installation, Polybar status bar, enhanced keybindings, GTK theme integration

- **`dwm_setup.md`** - Minimal suckless DWM 6.6 setup
  - Suckless philosophy, multiple layouts, named scratchpads, comprehensive patches

- **`openbox_setup.md`** - Complete Openbox configuration script
  - Polished theme, smart automation, lightweight floating window manager

**Development Tools:**

- **`nvim_setup.md`** - Minimal, fast, and intuitive Neovim configuration
  - Fast startup via lazy.nvim, buffer-based file explorer, GitHub-inspired theme

**Productivity Tools:**

- **`butterbase_setup.md`** - Smooth, modular Bash configuration framework
  - FZF integration, git-aware prompts, extensive aliases, works with any shell

- **`butternotes_setup.md`** - Streamlined note-taking and todo management tool
  - Smart fzf-enhanced project management, "inbox first" philosophy

- **`butterscripts_setup.md`** - Modular collection of utility scripts for Debian setups
  - Automates installs, configures tools, applies theming, organized by functionality

### `/agents_guide` - AI Agent Workflow

Structured 3-step process for building features with AI-powered IDEs and CLIs (Cursor, Claude Code, Windsurf, etc.).

**Core Workflow Files:**

- **`1-create-prd.md`** - Product Requirement Document (PRD) generation guide
  - Instructions for AI to generate detailed PRDs with clarifying questions template
  - Saves to `/tasks/[n]-prd-[feature-name].md`

- **`2-generate-tasks.md`** - Task list generation from PRD
  - Two-phase process: high-level tasks, then sub-tasks
  - Saves to `/tasks/tasks-[prd-file-name].md`

- **`3-process-task-list.md`** - Task execution and tracking guide
  - One sub-task at a time implementation with git commits and test-driven workflow

**Additional Guides:**

- **`agents_guide.md`** - Complete workflow documentation
  - Overview of 3-step process (PRD → Tasks → Implementation)
  - Tool-specific instructions and best practices

- **`AGENT_RULES.md`** - Communication and work preferences
  - How to work with AI agents effectively, tool preferences, tech stack preferences

- **`CLAUDE_UI_BEST_PRACTICE.MD`** - UI development best practices with Claude Code
  - Communication strategies, screenshot usage, iterative development workflow

- **`awesome_mcp_servers.md`** - Curated list of awesome Model Context Protocol (MCP) servers
  - Production-ready and experimental MCP servers for extending AI capabilities
  - File access, database connections, API integrations, and contextual services

### Root Files

- **`LICENSE`** - Apache License 2.0
- **`VIBE_CONSULT_CODE.md`** - Consulting services information

## 🚀 Quick Start

### Development Environment Setup:

1. **Interactive Menu** (Recommended):
   ```bash
   cd tools && chmod +x dev_tools_menu.sh && ./dev_tools_menu.sh
   ```

2. **Automated Setup**:
   ```bash
   cd tools && chmod +x master_*_setup.sh && ./master_tmux_setup.sh && ./master_neovim_setup.sh && ./master_litexl_setup.sh
   ```

3. **Manual Installation**: Follow `tools/manual_setup.md`

### Window Manager & Productivity Tools:

- Browse `debian_tools_scripts/` for BSPWM, DWM, Openbox, Neovim, ButterBash, ButterNotes, ButterScripts guides

### System Setup & Recovery:

- Follow `debian_setup/` guides for Clonezilla backup/restore, partition recovery, hibernation setup

### AI Agent Workflow:

1. **3-step process**:
   - Step 1: Use `agents_guide/1-create-prd.md` to generate a PRD
   - Step 2: Use `agents_guide/2-generate-tasks.md` to create task list
   - Step 3: Use `agents_guide/3-process-task-list.md` to implement tasks
2. **Read** `agents_guide/agents_guide.md` for detailed workflow documentation
3. **Explore** `agents_guide/awesome_mcp_servers.md` for MCP server integrations

## 💡 Use Cases

**This repository is for you if you want to:**

- ✅ Set up complete Ubuntu/Debian development environment with modern tools
- ✅ Configure Tmux, Neovim, Lite XL, Sublime Text with optimal settings
- ✅ Install window managers (BSPWM, DWM, Openbox) and productivity tools
- ✅ Use AI agents (Claude, Cursor, etc.) to build features systematically
- ✅ Break down complex features into manageable, trackable tasks
- ✅ Automate development tool installation and configuration
- ✅ Set up system backup, recovery, and hibernation procedures
- ✅ Explore MCP server integrations for enhanced AI capabilities

## 🛠️ System Requirements

- **Operating System:** Ubuntu or Debian Linux distributions
- **Prerequisites:** `git`, `curl`, `sudo` access

## 📚 Additional Resources

### Development Tools
- **Tmux Navigation:** See `tools/manual_setup.md` for keybinding reference
- **Neovim Shortcuts:** Prefix = Space, Ctrl+n for file tree, Space+ff for file search
- **Lite XL:** Markdown preview with Ctrl+Shift+M
- **Pass CLI:** Complete setup guide in `tools/PASS_INSTALLATION_GUIDE.md`
- **Git Operations:** Ultimate Git reference guide in `tools/git_guide.md`

### Window Managers & Productivity
- **BSPWM, DWM, Openbox:** Complete guides in `debian_tools_scripts/`
- **ButterBash, ButterNotes:** Shell and note-taking systems in `debian_tools_scripts/`

### System Recovery & Setup
- **Clonezilla, Partition Recovery, Hibernation:** Guides in `debian_setup/`

### AI Workflow & MCP Servers
- **AI Workflow Demo:** [How I AI podcast](https://www.youtube.com/watch?v=fD4ktSkNCw4)
- **MCP Servers:** Explore `agents_guide/awesome_mcp_servers.md` for AI capability extensions

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Open issues for bugs or feature requests
- Submit pull requests for improvements
- Share your setup configurations and workflows

## 📄 License

Apache License 2.0 - See [LICENSE](LICENSE) file for details

---

**Made with ❤️ for developers who value automation, AI-assisted development, and clean workflows.**
