# Hermes FamilyOS

A complete Hermes Agent setup with GBrain knowledge management, designed for easy migration to new devices.

## Structure

```
hermes-agent-FamilyOS-/
├── (Hermes Agent source code)  # Main agent code
├── tools/
│   └── gbrain/              # GBrain submodule (knowledge management tool)
├── wiki/                     # Personal knowledge base (MECE structure)
│   ├── RESOLVER.md          # Master decision tree for filing
│   ├── index.md             # Knowledge base index
│   ├── people/              # One page per person
│   ├── companies/           # One page per organization
│   ├── projects/            # Active projects
│   ├── concepts/            # Mental models and frameworks
│   ├── meetings/            # Meeting records
│   └── ... (more directories)
├── setup-familyos.sh        # Setup script for new devices
└── .gitmodules              # Submodule configuration
```

## Quick Clone & Setup (New Device)

```bash
# Clone with submodules
git clone --recurse-submodules https://github.com/Charlie-Zheng1/hermes-agent-FamilyOS-.git
cd hermes-agent-FamilyOS-

# Run setup script
./setup-familyos.sh
```

The setup script will:
1. Install Bun (required for GBrain)
2. Set up GBrain from the submodule
3. Initialize GBrain database
4. Import your wiki into GBrain
5. Set up Hermes Agent Python environment
6. Configure environment files

## Components

### 1. Hermes Agent
The core AI agent - see [AGENTS.md](AGENTS.md) for development guide.

### 2. GBrain (tools/gbrain/)
Personal knowledge management tool - browse, search, and maintain your wiki.
- Docs: See `tools/gbrain/docs/`
- Usage: `cd tools/gbrain && gbrain --help`

### 3. Wiki (wiki/)
Your personal knowledge base with MECE directory structure:
- **people/** - One page per person
- **companies/** - One page per organization  
- **projects/** - Active projects
- **concepts/** - Mental models and frameworks
- **meetings/** - Meeting records

Each directory has a `README.md` resolver that explains what goes there.

## Live Sync

A cron job runs every 15 minutes to:
- Sync wiki/ to GitHub
- Update GBrain search index

## Migration to New Device

1. **Clone**: `git clone --recurse-submodules <repo-url>`
2. **Run setup**: `./setup-familyos.sh`
3. **Configure**: Edit `.env` and `~/.hermes/.env` with your API keys
4. **Start**: `hermes` or `python run_agent.py`

That's it! Everything (Hermes, GBrain, wiki) comes with the clone.

## Requirements

- Python 3.11+
- Bun (installed automatically by setup script)
- Git with submodule support
- API keys: OpenRouter, etc. (see `.env.example`)

## Memory System

This repo is configured to use:
- **HINDSIGHT** - Vector database for persistent memory across sessions
- **GBrain** - Personal wiki for structured knowledge

Configuration: `~/.hermes/config.yaml`

## Contributing

This is a personal repo. Fork it and adapt to your own needs!

---

**Setup time on new device: ~5 minutes** (after clone)
