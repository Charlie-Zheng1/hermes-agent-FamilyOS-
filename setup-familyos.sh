#!/bin/bash
# Hermes FamilyOS Setup Script
# Run this after: git clone --recurse-submodules https://github.com/Charlie-Zheng1/hermes-agent-FamilyOS-.git
# Usage: ./setup-familyos.sh

set -e

echo "=== Hermes FamilyOS Setup ==="
echo ""

# 1. Install Bun (required for GBrain)
if ! command -v bun &> /dev/null; then
    echo "[1/6] Installing Bun..."
    curl -fsSL https://bun.sh/install | bash
    export PATH="$HOME/.bun/bin:$PATH"
else
    echo "[1/6] Bun already installed: $(bun --version)"
fi

# 2. Set up GBrain from submodule
echo "[2/6] Setting up GBrain..."
cd tools/gbrain
bun install
bun link
cd ..
echo "GBrain ready: $(gbrain --version)"

# 3. Initialize GBrain database
echo "[3/6] Initializing GBrain database..."
export PATH="$HOME/.bun/bin:$PATH"
gbrain init

# 4. Import wiki into GBrain
echo "[4/6] Importing wiki into GBrain..."
gbrain import wiki/ --no-embed
echo "Wiki imported."

# 5. Set up Hermes Agent (Python venv)
echo "[5/6] Setting up Hermes Agent..."
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
fi
source .venv/bin/activate
pip install -e ".[dev]" 2>/dev/null || pip install -r requirements.txt 2>/dev/null || echo "No requirements.txt found, skipping pip install"
echo "Hermes Agent ready."

# 6. Configure environment
echo "[6/6] Setting up environment..."
if [ ! -f ".env" ] && [ -f ".env.example" ]; then
    cp .env.example .env
    echo "Created .env from .env.example - please edit it with your API keys"
fi

# Set up Hermes home directory
export HERMES_HOME="$HOME/.hermes"
mkdir -p "$HERMES_HOME"

# Link wiki to hermes home
ln -sf "$(pwd)/wiki" "$HERMES_HOME/wiki" 2>/dev/null || true

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "Next steps:"
echo "1. Edit .env with your API keys"
echo "2. Edit ~/.hermes/.env with your HERMES_API_KEYS"
echo "3. Run: cd tools/gbrain && gbrain doctor --json"
echo "4. Run: hermes (to start Hermes Agent)"
echo ""
echo "Wiki location: $(pwd)/wiki/"
echo "GBrain DB: ~/.gbrain/brain.pglite"
echo ""

# 7. Restore Hermes config from repo backup
echo "[7/7] Restoring Hermes config..."
if [ -d "config" ]; then
    mkdir -p "$HOME/.hermes"
    
    # Restore config.yaml.example (with placeholders)
    if [ -f "config/config.yaml.example" ]; then
        cp config/config.yaml.example "$HOME/.hermes/config.yaml"
        echo "✓ Created ~/.hermes/config.yaml (edit to add your API keys)"
    fi
    
    # Restore skills
    if [ -d "config/skills" ]; then
        rsync -av config/skills/ "$HOME/.hermes/skills/"
        echo "✓ Restored skills/ to ~/.hermes/"
    fi
    
    echo ""
    echo "⚠️  Don't forget to:"
    echo "   1. Edit ~/.hermes/config.yaml and add your API keys"
    echo "   2. Copy ~/.hermes/.env.example to ~/.hermes/.env and fill in secrets"
else
    echo "No config/ directory found, skipping config restore"
fi

echo ""
echo "=== Setup complete! ==="
echo "Next steps:"
echo "1. Edit ~/.hermes/.env and add your API keys"
echo "2. Edit ~/.hermes/config.yaml and configure providers"
echo "3. Run: hermes (to start Hermes Agent)"
echo "4. Run: cd tools/gbrain && gbrain query 'test' (to test GBrain)"
