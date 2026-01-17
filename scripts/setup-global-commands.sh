#!/bin/bash
# Setup Global Claude Commands
# Run this once to make /plan, /architect, /devsecops, /ui, /review, /debug, /commit
# available in ANY project folder.

set -e

# Determine config location based on OS
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows (Git Bash)
    CONFIG_DIR="$APPDATA/claude"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    CONFIG_DIR="$HOME/.config/claude"
else
    # Linux
    CONFIG_DIR="$HOME/.config/claude"
fi

COMMANDS_DIR="$CONFIG_DIR/commands"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/../global-commands"

echo "=========================================="
echo "  Global Claude Commands Setup"
echo "=========================================="
echo ""
echo "Config location: $CONFIG_DIR"
echo ""

# Create directory
mkdir -p "$COMMANDS_DIR"

# Check if source files exist
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "ERROR: Source directory not found: $SOURCE_DIR"
    echo ""
    echo "Expected structure:"
    echo "  terminal-ai-orchestrator/"
    echo "    global-commands/"
    echo "      plan.md"
    echo "      architect.md"
    echo "      ..."
    echo "    scripts/"
    echo "      setup-global-commands.sh  <-- you are here"
    exit 1
fi

# Copy commands
echo "Installing commands..."
for file in "$SOURCE_DIR"/*.md; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        cp "$file" "$COMMANDS_DIR/$filename"
        echo "  ✓ $filename"
    fi
done

echo ""
echo "=========================================="
echo "  Setup Complete!"
echo "=========================================="
echo ""
echo "Available commands (in any project):"
echo "  /plan       - Requirements & research"
echo "  /architect  - System design"
echo "  /devsecops  - Secure implementation"
echo "  /ui         - Frontend & styling"
echo "  /review     - Code review"
echo "  /debug      - Troubleshooting"
echo "  /commit     - Git commit"
echo ""
echo "Start Claude Code in any folder and use these commands!"