# AI-PRDs: Development Environment & Agent Workflow Setup

A comprehensive repository providing both Ubuntu/Debian development environment setup tools and AI agent workflow guides for structured feature development.

> **Note:** All setup tools and scripts are designed exclusively for **Ubuntu/Debian** Linux distributions.

## 📁 Repository Structure

### `/tools` - Development Environment Setup

This directory contains scripts and configuration files to set up your complete development environment on Ubuntu/Debian systems. You can install tools manually, use automated scripts, or run an interactive menu.

**Files:**

- **`dev_tools_menu.sh`** - Interactive menu system for installing development tools
  - Choose individual tools or install everything at once
  - Includes: Claude Code, Ghostty Terminal, Tmux + TPM, Neovim, AmpCode, Lazygit, Git updates, PyCharm Community
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

- **`manual_setup.md`** - Step-by-step manual installation guide
  - Terminal tools (Claude Code, Ghostty, Tmux + TPM)
  - Development tools (Neovim, AmpCode)
  - Git tools (Lazygit, Git version updates)
  - Detailed Tmux and Neovim configuration instructions
  - Key binding reference and installation checklist

- **`tmux-install-guide.md`** - Comprehensive Tmux installation guide
  - Building from source instructions
  - TPM (Tmux Plugin Manager) setup
  - Troubleshooting common issues
  - Sample configuration with explanations
  - Plugin management commands

- **`tmux.conf`** - Production-ready Tmux configuration file
  - Custom prefix key (Ctrl+a instead of Ctrl+b)
  - Vim-style pane navigation
  - Catppuccin Mocha color theme
  - Multiple navigation methods (vim keys, arrow keys)
  - Vi-mode copy/paste
  - Auto-renumbering windows
  - Plugin integration (TPM, vim-tmux-navigator, catppuccin, yank, copycat)

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
   chmod +x master_tmux_setup.sh master_neovim_setup.sh
   ./master_tmux_setup.sh
   ./master_neovim_setup.sh
   ```

3. **Manual Installation**:
   ```bash
   # Follow the step-by-step guide
   cat tools/manual_setup.md
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
- ✅ Configure Tmux and Neovim with optimal settings and themes
- ✅ Use AI agents (Claude, Cursor, etc.) to build features systematically
- ✅ Break down complex features into manageable, trackable tasks
- ✅ Maintain code quality with PRD-driven development
- ✅ Automate development tool installation and configuration

## 🛠️ System Requirements

- **Operating System:** Ubuntu or Debian Linux distributions
- **Prerequisites:** `git`, `curl`, `sudo` access
- **Recommended:** Fresh Ubuntu/Debian installation or clean user environment

## 📚 Additional Resources

- **Tmux Navigation:** See `tools/manual_setup.md` for complete keybinding reference
- **Neovim Shortcuts:** Prefix = Space, Ctrl+n for file tree, Space+ff for file search
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
