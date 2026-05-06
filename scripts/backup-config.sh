#!/bin/bash
# Backup Hermes config from ~/.hermes/ to config/

set -e

HERMES_SOURCE="$HOME/.hermes"
CONFIG_DIR="$(cd "$(dirname "$0")/.." && pwd)/config"

echo "=== Backing up Hermes config to repo ==="
echo "Source: $HERMES_SOURCE"
echo "Dest: $CONFIG_DIR"

# Create config dir if needed
mkdir -p "$CONFIG_DIR"

# Backup config.yaml
if [ -f "$HERMES_SOURCE/config.yaml" ]; then
    cp "$HERMES_SOURCE/config.yaml" "$CONFIG_DIR/"
    echo "✓ Backed up config.yaml"
else
    echo "✗ config.yaml not found"
fi

# Backup skills (custom skills you've created)
if [ -d "$HERMES_SOURCE/skills" ]; then
    rsync -av --delete "$HERMES_SOURCE/skills/" "$CONFIG_DIR/skills/"
    echo "✓ Backed up skills/"
else
    echo "✗ skills/ not found"
fi

# Backup auth.json (contains auth tokens)
if [ -f "$HERMES_SOURCE/auth.json" ]; then
    cp "$HERMES_SOURCE/auth.json" "$CONFIG_DIR/"
    echo "✓ Backed up auth.json"
else
    echo "✗ auth.json not found"
fi

# Create .env.example from .env (without secrets)
if [ -f "$HERMES_SOURCE/.env" ]; then
    grep -v "TOKEN\|KEY\|SECRET\|PASSWORD" "$HERMES_SOURCE/.env" > "$CONFIG_DIR/.env.example" || true
    echo "✓ Created .env.example (secrets stripped)"
fi

echo ""
echo "=== Backup complete ==="
echo "Review changes: git status"
echo "Commit: git add config/ && git commit -m 'Update Hermes config backup'"
