#!/bin/bash
# Setup script for Toto-Code Claude extensions
# Run this after cloning the repo on a new machine

set -e

echo "=== Toto-Code Setup ==="
echo ""

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
    echo "Claude Code not found. Installing..."
    curl -fsSL https://claude.ai/install.sh | bash

    # Add to PATH if needed
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
        export PATH="$HOME/.local/bin:$PATH"
    fi
    echo "Claude Code installed!"
else
    echo "Claude Code already installed: $(claude --version 2>/dev/null || echo 'version unknown')"
fi

echo ""

# Copy .claude to home directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -d "$SCRIPT_DIR/.claude" ]; then
    echo "Copying .claude to ~/.claude..."
    rsync -av --ignore-errors "$SCRIPT_DIR/.claude/" ~/.claude/
    echo "Done!"
else
    echo "Warning: .claude directory not found in repo"
fi

echo ""
echo "=== Plugin Installation ==="
echo ""
echo "Run these commands inside Claude Code to install plugins:"
echo ""
echo "  /plugin marketplace add thedotmack/claude-mem"
echo "  /plugin install claude-mem"
echo ""
echo "Then restart Claude Code."
echo ""
echo "=== Setup Complete ==="
echo ""
echo "Start Claude Code with: claude"
echo "Or navigate to a project and run: claude"
