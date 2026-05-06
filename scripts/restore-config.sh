#!/bin/bash
# Restore Hermes config from config/ to ~/.hermes/

set -e

HERMES_TARGET="$HOME/.hermes"
CONFIG_DIR="$(cd "$(dirname "$0")/.." && pwd)/config"

echo "=== Restoring Hermes config from repo ==="
echo "Source: $CONFIG_DIR"
echo "Dest: $HERMES_TARGET"

# Create .hermes dir if needed
mkdir -p "$HERMES_TARGET"

# Restore config.yaml
if [ -f "$CONFIG_DIR/config.yaml" ]; then
    cp "$CONFIG_DIR/config.yaml" "$HERMES_TARGET/"
    echo "✓ Restored config.yaml"
else
    echo "✗ config.yaml not found in repo"
fi

# Restore skills
if [ -d "$CONFIG_DIR/skills" ]; then
    rsync -av "$CONFIG_DIR/skills/" "$HERMES_TARGET/skills/"
    echo "✓ Restored skills/"
else
    echo "✗ skills/ not found in repo"
fi

# Restore auth.json
if [ -f "$CONFIG_DIR/auth.json" ]; then
    cp "$CONFIG_DIR/auth.json" "$HERMES_TARGET/"
    echo "✓ Restored auth.json"
else
    echo "✗ auth.json not found in repo"
fi

# Remind about .env
if [ -f "$CONFIG_DIR/.env.example" ]; then
    echo ""
    echo "⚠️  Don't forget to set up .env:"
    echo "   cp ~/.hermes/.env.example ~/.hermes/.env"
    echo "   # Then edit .env and add your API keys!"
else
    echo "⚠️  No .env.example found - you'll need to create .env manually"
fi

echo ""
echo "=== Restore complete ==="
