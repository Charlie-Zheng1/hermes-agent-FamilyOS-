# Config Directory

This directory stores Hermes Agent configuration for syncing across devices.

## What's Stored Here

- `config.yaml` - Hermes configuration (providers, models, memory settings)
- `skills/` - Custom skills you've created
- `auth.json` - Authentication tokens (if not sensitive)

## What's NOT Stored

- `.env` - Contains API keys and secrets (use `.env.example` pattern)
- `cache/` - Temporary cache files
- `cron/` - Local cron state

## Usage

### Backup (save current config to repo):
```bash
./scripts/backup-config.sh
```

### Restore (set up Hermes on new device):
```bash
./scripts/restore-config.sh
```

## Security Note

API keys in `.env` are NOT committed to GitHub. On a new device:
1. Copy `.env.example` to `.env`
2. Fill in your API keys
3. Run `restore-config.sh` to get the rest

---

**Never commit `.env` with real API keys!**
