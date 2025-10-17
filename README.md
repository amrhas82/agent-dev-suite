# Agent Dev Suite

Complete Ubuntu/Debian development environment setup with AI-assisted workflows and agent-driven development.

## 🚀 Quick Start

### For Development Environment Setup:
```bash
git clone https://github.com/your-repo/agent-dev-suite.git
cd agent-dev-suite/tools
chmod +x dev_tools_menu.sh && ./dev_tools_menu.sh
```

### For AI-Assisted Development:
- **Simple 3-step workflow**: See `ai/simple/`
- **BMAD framework**: See `ai/bmad/`

## 📁 What's Included

### 🤖 AI Workflows (`ai/`)
Two comprehensive approaches to AI-assisted development:

#### Simple Workflow (`ai/simple/`)
- **3-step process**: PRD → Tasks → Implementation
- Perfect for features, small projects, and quick iterations
- Streamlined agent guidance for rapid development

#### BMAD Framework (`ai/bmad/`)
- **Full AI team simulation**: PM, Analyst, Architect, Dev, QA, UX Expert
- Role-based development with specialized agents
- Comprehensive project management and quality gates
- Ideal for complex, production-grade applications

### 🛠️ Development Tools (`tools/`)
- **📖 Complete Tools Guide**: [`tools_guide.md`](tools/tools_guide.md) - Comprehensive documentation with examples and quick start commands
- **Automated installation scripts** for Tmux, Neovim, Lite XL
- **Interactive dev tools menu** for easy setup
- **Configuration files** and comprehensive guides
- **AI development utilities** and automation scripts

### 🖥️ Environment Setup (`env/`)

#### System Setup (`env/setup/`)
- **Backup & recovery** with Clonezilla guides
- **Partition management** and recovery procedures
- **System configuration** for optimal development environment
- **Hibernate setup** and power management

#### Development Environments (`env/tools/`)
- **Window managers**: BSPWM, DWM, Openbox configurations
- **Productivity tools**: ButterBash, ButterNotes, ButterScripts
- **Editor setups**: Neovim configuration and plugins
- **Shell environments**: Customized terminal setups

### 🔌 Integrations (`integrations/`)
- **MCP Servers**: [awesome_mcp_servers.md](integrations/awesome_mcp_servers.md) - 200+ comprehensive list of Model Context Protocol servers
- **External tool integrations** for enhanced AI capabilities
- **API connections** and service integrations
- **Extension packs** for specialized development workflows

## 🎯 Use Cases

This suite is designed for developers who want to:

### 🏗️ **Environment Setup**
- Set up a complete Ubuntu/Debian development environment from scratch
- Configure optimal development tools and workflows
- Automate system setup and maintenance tasks

### 🤖 **AI-Driven Development**
- Use AI agents to build features systematically
- Implement role-based development workflows
- Leverage specialized AI agents for different development phases

### 🚀 **Productivity Enhancement**
- Streamline development workflows with automation
- Use proven configurations for popular tools
- Integrate AI capabilities into existing workflows

## 📚 Documentation Structure

### Getting Started
- [Quick Start Guide](#-quick-start)
- [Installation Instructions](tools/README.md)
- [Environment Configuration](env/)

### AI Development
- [Simple Workflow Guide](ai/simple/1-create-prd.md)
- [BMAD Framework Documentation](ai/bmad/.bmad-core/user-guide.md)
- [Agent Configuration](ai/bmad/.bmad-core/agents/)

### Tools & Environment
- [Development Tools Guide](tools/guides/)
- [Window Manager Setup](env/tools/)
- [System Administration](env/setup/)

### Integrations
- [MCP Server Integration](integrations/awesome_mcp_servers.md) - 200+ servers
- [External Tool Setup](integrations/README.md)

## 🛡️ System Requirements

- **OS**: Ubuntu 20.04+ or Debian 11+
- **Prerequisites**: `git`, `curl`, `sudo` access
- **Memory**: 4GB+ RAM recommended
- **Storage**: 10GB+ free space
- **Network**: Internet connection for AI services

## 🔄 Workflow Examples

### Simple 3-Step Workflow
```bash
# 1. Create PRD
cd ai/simple
./1-create-prd.md

# 2. Generate Tasks
./2-generate-tasks.md

# 3. Process Task List
./3-process-task-list.md
```

### BMAD Framework
```bash
# Initialize BMAD project
cd ai/bmad/.bmad-core
./user-guide.md

# Configure agents
./agents/
./workflows/
```

### Environment Setup
```bash
# Interactive tools setup
cd tools
./dev_tools_menu.sh

# Manual setup
./master_tmux_setup.sh
./master_neovim_setup.sh
```

## 🏗️ Architecture

```
agent-dev-suite/
├── ai/                          # AI workflows and agents
│   ├── simple/                  # 3-step workflow
│   └── bmad/                    # Full AI team framework
├── env/                         # Environment configuration
│   ├── setup/                   # System setup
│   └── tools/                   # Development environments
├── tools/                       # Development utilities
├── integrations/                # External integrations
└── docs/                        # Comprehensive documentation
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Workflow
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🔗 Related Projects

- [BMAD Framework](https://github.com/bmad-framework) - Core AI development framework
- [MCP Protocol](https://modelcontextprotocol.io) - Model Context Protocol specifications
- [Ubuntu Development Environment](https://ubuntu.com/desktop/developers) - Ubuntu development setup

## 📊 Project Status

- ✅ **Environment Setup**: Complete with automated scripts
- ✅ **Simple AI Workflow**: Ready for production use
- ✅ **BMAD Framework**: Full implementation with all agents
- ✅ **Integration Support**: MCP servers and external tools
- 🔄 **Documentation**: Continuously improving
- 🚧 **New Features**: Actively developing

## 🆘 Support

### Getting Help
- **Documentation**: Check the relevant section in this README
- **Issues**: [GitHub Issues](https://github.com/your-repo/agent-dev-suite/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-repo/agent-dev-suite/discussions)

### Common Issues
- **Permission Errors**: Use `sudo` for system-level installations
- **AI Service Limits**: Check API key configurations
- **Environment Conflicts**: Use the provided setup scripts

## 🎉 What's New

### Version 2.0.0
- 🔄 **Reorganized Structure**: New logical folder organization
- 🤖 **Enhanced AI Workflows**: Improved simple and BMAD frameworks
- 🛠️ **Updated Tools**: Latest configurations and automation
- 📚 **Better Documentation**: Comprehensive guides and examples

### Recent Updates
- Added MCP server integrations
- Enhanced BMAD framework with new agents
- Improved environment setup scripts
- Updated documentation structure

---

**Built with ❤️ for the AI-driven development community**

Transform your development workflow with intelligent automation and AI assistance.