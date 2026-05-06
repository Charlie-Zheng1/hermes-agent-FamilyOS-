---
name: gbrain-integration
description: "Install and integrate GBrain knowledge base with Hermes Agent. Covers setup, architecture, and Hermes interaction patterns."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [gbrain, knowledge-base, memory, external-tools, brain]
    homepage: https://github.com/garrytan/gbrain
---

# GBrain Integration with Hermes

GBrain is a personal knowledge base tool that Hermes can use via CLI calls. This skill covers installation, architecture understanding, and integration patterns.

## Architecture (Critical to Understand)

**GBrain (the tool)** - `~/code/hermes/tools/gbrain/`
- The software application (like Microsoft Word)
- Contains: source code, CLI binary, built-in skills, documentation
- Installed separately from Hermes
- Hermes calls it via `terminal` tool, NOT by importing skills
- **Note**: Tools go in `tools/` subfolder per user convention

**Wiki Repo (your content)** - `~/code/hermes/wiki/` (user prefers "wiki" over "brain")
- YOUR knowledge base (like your documents folder)
- Contains: markdown files (notes, docs, ideas, concepts)
- Indexed by GBrain via `gbrain import` and `gbrain embed`
- Queried via `gbrain query "..."`
- **Naming**: User explicitly chose "wiki" over "brain", "knowledge-base", "notes"

**Hermes Skills** (`~/.hermes/skills/`) vs **GBrain Skills** (`~/code/hermes/gbrain/skills/`)
- Hermes skills: Procedures Hermes uses (how to debug, how to set up projects)
- GBrain skills: Procedures GBrain uses when YOU run it (how to ingest voice notes, analyze books)
- Hermes does NOT copy GBrain skills - it calls `gbrain` CLI commands

## Installation

Follow the official guide: https://raw.githubusercontent.com/garrytan/gbrain/master/INSTALL_FOR_AGENTS.md

**Quick reference (tested on macOS):**

```bash
# Step0: Read AGENTS.md first (if not Claude Code)
curl -s https://raw.githubusercontent.com/garrytan/gbrain/master/AGENTS.md

# Step1: Clone to correct location (see Convention below)
mkdir -p ~/code/hermes/tools
git clone https://github.com/garrytan/gbrain.git ~/code/hermes/tools/gbrain
cd ~/code/hermes/tools/gbrain

# Install Bun (use Homebrew, NOT pipe-to-bash)
brew install oven-sh/bun/bun

# Install dependencies
bun install

# Link globally
bun link

# Verify
gbrain --version

# Step2: API Keys (optional for basic use)
# Add to ~/.hermes/.env:
# OPENAI_API_KEY=sk-...     # required for vector search
# ANTHROPIC_API_KEY=sk-...  # optional, improves search

# Step3: Initialize brain
gbrain init
gbrain doctor --json

# Step4: Create wiki repo (separate from tool, user prefers "wiki" over "brain")
mkdir -p ~/code/hermes/wiki
cd ~/code/hermes/wiki && git init

# Set up MECE directory structure:
# people/, companies/, projects/, concepts/, meetings/, ideas/, writing/, etc.
# Create RESOLVER.md (master decision tree) and directory READMEs

# Step5: Import and index
gbrain import ~/code/hermes/wiki/ --no-embed
gbrain embed --stale
gbrain query "test query"
```

## Convention: Repo Location

**ALL repositories and documentation projects must be saved under `~/code/hermes/` folder.**

This is the designated workspace for Hermes-related work, clones, and docs.

**Subdirectory structure:**
- `~/code/hermes/tools/` - tools like gbrain, gstack, etc.
- `~/code/hermes/wiki/` - your knowledge base (user prefers "wiki" over "brain")
- `~/code/hermes/` - other project repos

This rule is saved in Hermes memory and should be followed for all future work.

## How Hermes Uses GBrain

Hermes interacts with GBrain by running CLI commands via the `terminal` tool:

```bash
# Query the brain
gbrain query "What do I know about machine learning?"

# Import new content
gbrain import ~/code/hermes/wiki/

# Update embeddings
gbrain embed --stale

# Add content
gbrain put-page --slug "new-concept" --title "New Concept" --body "..."

# Check status
gbrain doctor --json
```

**Common patterns:**
- Check brain before external API calls: `gbrain query "topic"` → use results → external search only if needed
- Ingest new information: receive content → `gbrain put-page` or `gbrain import`
- Periodic sync: `gbrain sync --repo ~/code/hermes/wiki && gbrain embed --stale`

## Live Sync (Cron Job)

Set up automatic sync every 15 minutes:

```bash
# Via Hermes cron (recommended):
# In chat: /cron create "*/15 * * * *"
# Prompt: "Sync wiki repo and update GBrain index: cd ~/code/hermes/wiki && git add . && git commit -m 'Auto-sync' && git push || true && gbrain sync --repo ~/code/hermes/wiki && gbrain embed --stale"

# Or manually:
cd ~/code/hermes/wiki
git add . && git commit -m "Update" && git push
gbrain sync --repo ~/code/hermes/wiki
gbrain embed --stale
```

## GitHub Integration

Sync your wiki to a private GitHub repo:

```bash
# Install GitHub CLI (if not available)
brew install gh

# Authenticate (choose option 1: browser login)
gh auth login

# Create private repo
cd ~/code/hermes/wiki
gh repo create wiki --private

# Push existing content
git remote add origin git@github.com:USERNAME/wiki.git
git branch -M main
git push -u origin main
```

**Automated via cron**: The live sync cron job (above) includes `git push` so your wiki stays synced to GitHub automatically.

## Pitfalls

1. **Bun install via pipe-to-bash is blocked** - Use Homebrew instead: `brew install oven-sh/bun/bun`
2. **GBrain skills are NOT Hermes skills** - Don't try to copy them to `~/.hermes/skills/`
3. **Wiki repo is SEPARATE from tool repo** - `~/code/hermes/tools/gbrain/` (tool) vs `~/code/hermes/wiki/` (content)
4. **HINDSIGHT memory uses HINDSIGHT_API_KEY** - not HINDSIGHT_KEY (see hermes-agent skill)
5. **`bun link` required** - After `bun install`, run `bun link` to make `gbrain` CLI available globally
6. **User prefers "wiki" not "brain"** - When referring to the knowledge repo, use "wiki" (e.g., `~/code/hermes/wiki/`)
7. **Tools go in `tools/` subfolder** - GBrain tool lives at `~/code/hermes/tools/gbrain/`, not `~/code/hermes/gbrain/`
8. **GBrain binary location** - After `bun link`, `gbrain` is at `~/.bun/bin/gbrain`, may need `export PATH="$HOME/.bun/bin:$PATH"` in scripts
9. **GitHub auth needed for sync** - Install `gh` CLI and run `gh auth login` before trying to create/push to GitHub
10. **Cron job needs PATH** - When setting up cron jobs that call `gbrain`, ensure PATH includes `~/.bun/bin`

## Verification

After installation:
```bash
gbrain --version          # Should print version number
gbrain doctor --json      # Should show status (warnings OK for empty brain)
gbrain query "test"       # Should return empty results (no content yet)
```

## References

- Full installation guide: `~/code/hermes/tools/gbrain/INSTALL_FOR_AGENTS.md`
- Agent protocol: `~/code/hermes/tools/gbrain/AGENTS.md`
- Skill resolver: `~/code/hermes/tools/gbrain/skills/RESOLVER.md`
- GBrain docs: https://github.com/garrytan/gbrain/tree/master/docs
- Recommended schema: `~/code/hermes/tools/gbrain/docs/GBRAIN_RECOMMENDED_SCHEMA.md`
- Wiki structure: `~/code/hermes/wiki/RESOLVER.md` (master decision tree)
- Wiki index: `~/code/hermes/wiki/index.md`
