#!/usr/bin/env bash
# Install redesign-director into ~/.claude/ (skill + subagent + hook).
# Does NOT touch settings.json — you merge settings.snippet.json yourself (see the note printed at the end).
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="${CLAUDE_HOME:-$HOME/.claude}"

echo "→ Installing from: $REPO"
echo "→ Into:            $DEST"

mkdir -p "$DEST/skills" "$DEST/agents" "$DEST/hooks"

# skill (+ references)
rm -rf "$DEST/skills/redesign-director"
cp -R "$REPO/skills/redesign-director" "$DEST/skills/redesign-director"

# subagent
cp "$REPO/agents/mockup-designer.md" "$DEST/agents/mockup-designer.md"

# hook
cp "$REPO/hooks/deep-research-cost-guard.sh" "$DEST/hooks/deep-research-cost-guard.sh"
chmod +x "$DEST/hooks/deep-research-cost-guard.sh"

echo "✓ Installed:"
echo "  - skill    $DEST/skills/redesign-director/"
echo "  - subagent $DEST/agents/mockup-designer.md"
echo "  - hook     $DEST/hooks/deep-research-cost-guard.sh"
echo
echo "LAST STEP — enable the deep-research cost-guard hook."
echo "Merge settings.snippet.json into $DEST/settings.json (or a project .claude/settings.json)."
echo "It makes the token-heavy deep-research workflow ask for confirmation before running."
echo
echo "Then, in Claude Code:  /redesign-director"
