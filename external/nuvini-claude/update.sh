#!/bin/bash

# Update script for Nuvini Claude skills
# Fetches latest versions from GitHub

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="Nuvinigroup/claude"

echo "🔄 Updating Nuvini Claude skills..."

# Function to fetch and decode a file
fetch_file() {
    local remote_path="$1"
    local local_path="$2"

    echo "  Fetching: $remote_path"

    gh api "repos/$REPO/contents/$remote_path" > /tmp/gh_content.json 2>/dev/null

    if [ -f /tmp/gh_content.json ]; then
        node -e "
        const fs = require('fs');
        const data = JSON.parse(fs.readFileSync('/tmp/gh_content.json', 'utf8'));
        if (data.content) {
            const content = Buffer.from(data.content, 'base64').toString('utf8');
            fs.writeFileSync('$local_path', content);
            console.log('    ✅ Updated: $local_path');
        } else {
            console.log('    ⚠️  No content found');
        }
        "
    else
        echo "    ❌ Failed to fetch"
    fi
}

# Update autonomous-dev
echo ""
echo "📦 autonomous-dev:"
fetch_file "skills/autonomous-dev/SKILL.md" "$SCRIPT_DIR/skills/autonomous-dev/SKILL.md"
fetch_file "skills/autonomous-dev/references/examples.md" "$SCRIPT_DIR/skills/autonomous-dev/references/examples.md"

# Update website-replicator
echo ""
echo "📦 website-replicator:"
fetch_file "skills/website-replicator/SKILL.md" "$SCRIPT_DIR/skills/website-replicator/SKILL.md"
fetch_file "skills/website-replicator/scripts/replicate_website.py" "$SCRIPT_DIR/skills/website-replicator/scripts/replicate_website.py"
fetch_file "skills/website-replicator/scripts/authenticated_website_replicator.py" "$SCRIPT_DIR/skills/website-replicator/scripts/authenticated_website_replicator.py"

# Update project-orchestrator
echo ""
echo "📦 project-orchestrator:"
fetch_file "agents/orchestration/project-orchestrator.md" "$SCRIPT_DIR/agents/orchestration/project-orchestrator.md"

echo ""
echo "✅ Update complete!"
echo "📅 Updated: $(date '+%Y-%m-%d %H:%M:%S')"
