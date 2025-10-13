# AI-PRDs: Development Environment & Agent Workflow Setup

A comprehensive repository providing both Ubuntu/Debian development environment setup tools and AI agent workflow guides for structured feature development.

> **Note:** All setup tools and scripts are designed exclusively for **Ubuntu/Debian** Linux distributions.

## 📁 Repository Structure

### `/tools` - Development Environment Setup

This directory contains scripts and configuration files to set up your complete development environment on Ubuntu/Debian systems. You can install tools manually, use automated scripts, or run an interactive menu.

**Core Installation Scripts:**

- **`dev_tools_menu.sh`** - Interactive menu system for installing development tools
  - Choose individual tools or install everything at once
  - Includes: Claude Code, Ghostty Terminal, Tmux + TPM, Neovim, AmpCode, Lazygit, Git updates, PyCharm Community, **Lite XL, Pass CLI, Cursor AI CLI, Sublime Text**
  - Color-coded output with installation status tracking
  - Usage: `chmod +x dev_tools_menu.sh && ./dev_tools_menu.sh`

- **`master_tmux_setup.sh`** - Complete Tmux installation and configuration script
  - Builds Tmux from source
  - Installs Tmux Plugin Manager (TPM)
  - Configures tmux.conf with Catppuccin theme
  - Sets up vim-style navigation and custom keybindings
  - Automatically installs all plugins

- **`master_neovim_setup.sh`** - Complete Neovim installation and configuration script
  - Installs latest Neovim via PPA
  - Sets up nvim-tree file explorer
  - Configures Tokyonight theme and lualine
  - Integrates Lazygit, Telescope, Treesitter
  - Includes vim-plug and all necessary plugins

- **`master_litexl_setup.sh`** - Complete Lite XL installation and configuration script
  - Builds Lite XL from source with SDL3 support
  - Installs all dependencies (meson, cmake, SDL3)
  - Includes markdown preview plugin
  - Sets up proper PATH configuration
  - Usage: `chmod +x master_litexl_setup.sh && ./master_litexl_setup.sh`

**Documentation & Guides:**

- **`manual_setup.md`** - Step-by-step manual installation guide
  - Terminal tools (Claude Code, Ghostty, Tmux + TPM)
  - Development tools (Neovim, AmpCode, Lite XL, Sublime Text)
  - Password management (Pass CLI)
  - AI tools (Cursor AI CLI)
  - Git tools (Lazygit, Git version updates)
  - Detailed configuration instructions and key binding reference

- **`tmux-install-guide.md`** - Comprehensive Tmux installation guide
  - Building from source instructions
  - TPM (Tmux Plugin Manager) setup
  - Troubleshooting common issues
  - Sample configuration with explanations
  - Plugin management commands

- **`PASS_INSTALLATION_GUIDE.md`** - Complete Pass CLI password manager setup
  - Installation and initialization instructions
  - GPG key setup and management
  - Password store configuration
  - Integration with other tools
  - Security best practices

**Configuration Files:**

- **`tmux.conf`** - Production-ready Tmux configuration file
  - Custom prefix key (Ctrl+a instead of Ctrl+b)
  - Vim-style pane navigation
  - Catppuccin Mocha color theme
  - Multiple navigation methods (vim keys, arrow keys)
  - Vi-mode copy/paste
  - Auto-renumbering windows
  - Plugin integration (TPM, vim-tmux-navigator, catppuccin, yank, copycat)

**Utility Scripts:**

- **`validate_scripts.sh`** - Script validation and testing utility
  - Checks script syntax and permissions
  - Validates dependencies and requirements
  - Tests installation functions
  - Usage: `chmod +x validate_scripts.sh && ./validate_scripts.sh`

- **`SPLIT_SUMMARY.md`** - Repository organization summary
  - Documents the split between tools, debian_setup, and debian_tools_scripts
  - Migration notes and file organization
  - Usage guidelines for each directory

### `/debian_setup` - Debian System Setup & Recovery

This directory contains specialized guides for Debian-based system setup, recovery, and maintenance tasks.

**System Setup & Recovery Guides:**

- **`clonezilla-zorin-guide.md`** - Complete Clonezilla backup and restore guide for Zorin OS
  - System backup strategies and best practices
  - Clonezilla live USB creation and usage
  - Full system backup and restore procedures
  - Partition management and disk imaging
  - Troubleshooting common backup/restore issues

- **`partition_recovery_guide.md`** - Advanced partition recovery and data rescue guide
  - Recovering deleted or corrupted partitions
  - Using tools like TestDisk, PhotoRec, and GParted
  - Data recovery from damaged filesystems
  - Partition table repair and reconstruction
  - Emergency recovery procedures

- **`zorin-hibernate-guide.md`** - Zorin OS hibernation setup and configuration
  - Enabling hibernation on Zorin OS
  - Swap partition configuration
  - GRUB hibernation settings
  - Troubleshooting hibernation issues
  - Power management optimization

### `/debian_tools_scripts` - Window Manager & Productivity Tools

This directory contains comprehensive setup guides for various window managers and productivity tools, all designed for Debian-based systems.

**Window Manager Setups:**

- **`bspwm_setup.md`** - Minimal but functional BSPWM rice script
  - Complete BSPWM installation with all core packages
  - Window manager configs and themes ready out of the box
  - Polybar status bar with optimized layout
  - Enhanced keybindings and scratchpad support
  - GTK and icon theme integration (Orchis & Colloid)

- **`dwm_setup.md`** - Minimal suckless DWM 6.6 setup
  - Follows suckless philosophy with carefully selected patches
  - Simple, efficient, and hackable window manager experience
  - Multiple layout support (Dwindle, Tile, Column, Centered Master, etc.)
  - Named scratchpads and advanced window management
  - Comprehensive patch documentation

- **`openbox_setup.md`** - Complete Openbox configuration script
  - Polished theme with smart automation and dynamic menus
  - Lightweight floating window manager setup
  - Sane keybindings and window snapping
  - GTK theme integration and system integration
  - Perfect for users preferring floating window managers

**Development Tools:**

- **`nvim_setup.md`** - Minimal, fast, and intuitive Neovim configuration
  - Designed for Markdown writing, scripting, and everyday editing
  - Fast startup via lazy.nvim with optimized loading
  - Buffer-based file explorer and fuzzy finding
  - GitHub-inspired theme and smart syntax highlighting
  - Markdown support with optional Prettier formatting

**Productivity Tools:**

- **`butterbase_setup.md`** - Smooth, modular Bash configuration framework
  - Makes your shell experience butter-smooth
  - FZF integration, git-aware prompts, and extensive aliases
  - Archive extraction and system functions
  - Extension ready for note-taking and todo management
  - Works with any shell (bash, zsh, fish)

- **`butternotes_setup.md`** - Streamlined note-taking and todo management tool
  - Smart fzf-enhanced project management
  - "Inbox first, organize later" philosophy for maximum productivity
  - Fast capture with persistent todos and markdown checkboxes
  - Mobile sync compatibility with standard markdown files
  - Terminal-native with clean sub-prompts

- **`butterscripts_setup.md`** - Modular collection of utility scripts for Debian setups
  - Automates installs, configures tools, and applies theming
  - Minimal and practical scripts for system tweaking
  - Organized by functionality (browsers, discord, fastfetch, neovim, etc.)
  - Built for Butter Bean Linux and other Debian-based systems

### `/agents_guide` - AI Agent Workflow

This directory contains the original AI Dev Tasks workflow - a structured 3-step process for building features with AI-powered IDEs and CLIs (Cursor, Claude Code, Windsurf, etc.).

**Core Workflow Files:**

- **`1-create-prd.md`** - Product Requirement Document (PRD) generation guide
  - Instructions for AI to generate detailed PRDs
  - Clarifying questions template
  - PRD structure (goals, user stories, functional requirements, success metrics)
  - Designed for junior developer comprehension
  - Saves to `/tasks/[n]-prd-[feature-name].md`

- **`2-generate-tasks.md`** - Task list generation from PRD
  - Analyzes PRD and current codebase
  - Two-phase process: high-level tasks, then sub-tasks
  - Identifies relevant files and test files
  - Creates actionable, step-by-step implementation plan
  - Saves to `/tasks/tasks-[prd-file-name].md`

- **`3-process-task-list.md`** - Task execution and tracking guide
  - One sub-task at a time implementation
  - Completion protocol with git commits
  - Test-driven workflow (tests must pass before commits)
  - Conventional commit format
  - Progress tracking and file maintenance

**Additional Guides:**

- **`agents_guide.md`** - Complete workflow documentation (original README)
  - Overview of the 3-step process (PRD → Tasks → Implementation)
  - Tool-specific instructions (Cursor, Claude Code, other IDEs)
  - Best practices and tips for success
  - Video demonstration and examples

- **`AGENT_RULES.md`** - Communication and work preferences
  - How to work with AI agents effectively
  - Tool preferences (DeepSeek, Replit, Claude)
  - Tech stack preferences (Node.js, TypeScript, React, Tailwind, PostgreSQL, etc.)
  - Development workflow and deployment strategy
  - Core principles: simplicity, open-source, no vendor lock-in

- **`CLAUDE_UI_BEST_PRACTICE.MD`** - UI development best practices with Claude Code
  - How to communicate UI changes effectively
  - Using screenshots for visual context
  - Component-level and layout change strategies
  - Iterative development workflow
  - Claude's UI capabilities and limitations

### Root Files

- **`LICENSE`** - Apache License 2.0
- **`VIBE_CONSULT_CODE.md`** - Consulting services information
  - Rapid prototyping & MVP development
  - Technical consulting and AI agent development
  - Engagement models and focus areas

## 🚀 Quick Start

### For Development Environment Setup:

1. **Interactive Menu** (Recommended):
   ```bash
   cd tools
   chmod +x dev_tools_menu.sh
   ./dev_tools_menu.sh
   ```

2. **Automated Setup**:
   ```bash
   cd tools
   chmod +x master_tmux_setup.sh master_neovim_setup.sh master_litexl_setup.sh
   ./master_tmux_setup.sh
   ./master_neovim_setup.sh
   ./master_litexl_setup.sh
   ```

3. **Manual Installation**:
   ```bash
   # Follow the step-by-step guide
   cat tools/manual_setup.md
   ```

### For Window Manager & Productivity Tools:

1. **Browse Setup Guides**:
   ```bash
   cd debian_tools_scripts
   # Read individual setup guides for:
   # - BSPWM, DWM, Openbox window managers
   # - Neovim configuration
   # - ButterBash, ButterNotes, ButterScripts
   ```

2. **Follow Individual Guides**:
   - Each `.md` file contains complete installation instructions
   - All guides are designed for Debian-based systems
   - Includes configuration files and theming

### For System Setup & Recovery:

1. **System Backup & Recovery**:
   ```bash
   cd debian_setup
   # Follow guides for:
   # - Clonezilla backup/restore
   # - Partition recovery
   # - Zorin OS hibernation setup
   ```

### For AI Agent Workflow:

1. **Clone or reference this repository** in your project
2. **Follow the 3-step process**:
   - Step 1: Use `agents_guide/1-create-prd.md` to generate a PRD
   - Step 2: Use `agents_guide/2-generate-tasks.md` to create task list
   - Step 3: Use `agents_guide/3-process-task-list.md` to implement tasks
3. **Read** `agents_guide/agents_guide.md` for detailed workflow documentation

## 💡 Use Cases

**This repository is for you if you want to:**

- ✅ Set up a complete Ubuntu/Debian development environment with modern tools
- ✅ Configure Tmux, Neovim, Lite XL, and Sublime Text with optimal settings and themes
- ✅ Install and configure various window managers (BSPWM, DWM, Openbox)
- ✅ Set up productivity tools (ButterBash, ButterNotes, ButterScripts)
- ✅ Manage passwords securely with Pass CLI
- ✅ Use AI agents (Claude, Cursor, etc.) to build features systematically
- ✅ Break down complex features into manageable, trackable tasks
- ✅ Maintain code quality with PRD-driven development
- ✅ Automate development tool installation and configuration
- ✅ Set up system backup and recovery procedures
- ✅ Configure system hibernation and power management
- ✅ Recover from partition corruption or data loss

## 🛠️ System Requirements

- **Operating System:** Ubuntu or Debian Linux distributions
- **Prerequisites:** `git`, `curl`, `sudo` access
- **Recommended:** Fresh Ubuntu/Debian installation or clean user environment

## 📚 Additional Resources

### Development Tools
- **Tmux Navigation:** See `tools/manual_setup.md` for complete keybinding reference
- **Neovim Shortcuts:** Prefix = Space, Ctrl+n for file tree, Space+ff for file search
- **Lite XL:** Markdown preview with Ctrl+Shift+M, see `tools/master_litexl_setup.sh`
- **Sublime Text:** Launch with `subl`, see `tools/manual_setup.md` for installation
- **Pass CLI:** Complete setup guide in `tools/PASS_INSTALLATION_GUIDE.md`

### Window Managers & Productivity
- **BSPWM Setup:** Complete guide in `debian_tools_scripts/bspwm_setup.md`
- **DWM Configuration:** Suckless philosophy setup in `debian_tools_scripts/dwm_setup.md`
- **Openbox Setup:** Floating window manager in `debian_tools_scripts/openbox_setup.md`
- **ButterBash:** Shell configuration in `debian_tools_scripts/butterbase_setup.md`
- **ButterNotes:** Note-taking system in `debian_tools_scripts/butternotes_setup.md`

### System Recovery & Setup
- **Clonezilla Backup:** Zorin OS backup guide in `debian_setup/clonezilla-zorin-guide.md`
- **Partition Recovery:** Data rescue procedures in `debian_setup/partition_recovery_guide.md`
- **Hibernation Setup:** Zorin OS hibernation in `debian_setup/zorin-hibernate-guide.md`

### AI Workflow
- **AI Workflow Demo:** Watch the demonstration in the [How I AI podcast](https://www.youtube.com/watch?v=fD4ktSkNCw4)

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Open issues for bugs or feature requests
- Submit pull requests for improvements
- Share your setup configurations and workflows

## 📄 License

Apache License 2.0 - See [LICENSE](LICENSE) file for details

---

**Made with ❤️ for developers who value automation, AI-assisted development, and clean workflows.**
