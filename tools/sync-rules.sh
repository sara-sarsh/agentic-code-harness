#!/usr/bin/env bash
# tools/sync-rules.sh
# Generates tool-specific rule files (CLAUDE.md, .cursor/rules/harness.mdc, .agents/AGENTS.md)
# from the single source of truth: _core/RULES.md.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$REPO_ROOT"

if [[ ! -f "_core/RULES.md" ]]; then
  echo "Error: _core/RULES.md not found in $REPO_ROOT" >&2
  exit 1
fi

mkdir -p .cursor/rules .agents

# Use python3 for rock-solid cross-platform section parsing
python3 - << 'EOF'
import os
import re

rules_path = "_core/RULES.md"
with open(rules_path, "r", encoding="utf-8") as f:
    content = f.read()

# Pattern matches <!-- @scope: tags --> ... <!-- @scope: tags -->
pattern = re.compile(r"<!--\s*@scope:\s*([a-zA-Z0-9_,\s]+)\s*-->(.*?)<!--\s*@scope:\s*\1\s*-->", re.DOTALL)

matches = pattern.findall(content)

claude_sections = []
cursor_sections = []
agents_sections = []

for raw_tags, body in matches:
    tags = [t.strip().lower() for t in raw_tags.split(",")]
    clean_body = body.strip()
    
    if "universal" in tags or "claude" in tags:
        claude_sections.append(clean_body)
    if "universal" in tags or "cursor" in tags:
        cursor_sections.append(clean_body)
    if "universal" in tags or "agents" in tags or "spec-kit" in tags:
        agents_sections.append(clean_body)

# 1. Write CLAUDE.md
with open("CLAUDE.md", "w", encoding="utf-8") as f:
    f.write("<!-- AUTO-GENERATED FROM _core/RULES.md. DO NOT EDIT DIRECTLY. -->\n\n")
    f.write("\n\n".join(claude_sections) + "\n")

# 2. Write .cursor/rules/harness.mdc
with open(".cursor/rules/harness.mdc", "w", encoding="utf-8") as f:
    f.write("<!-- AUTO-GENERATED FROM _core/RULES.md. DO NOT EDIT DIRECTLY. -->\n\n")
    f.write("\n\n".join(cursor_sections) + "\n")

# 3. Write .agents/AGENTS.md
with open(".agents/AGENTS.md", "w", encoding="utf-8") as f:
    f.write("<!-- AUTO-GENERATED FROM _core/RULES.md. DO NOT EDIT DIRECTLY. -->\n\n")
    # For AGENTS.md, include universal and agents sections
    f.write("\n\n".join(agents_sections) + "\n")

print("✓ Successfully synchronized:")
print("  - CLAUDE.md")
print("  - .cursor/rules/harness.mdc")
print("  - .agents/AGENTS.md")
EOF

chmod +x tools/sync-rules.sh 2>/dev/null || true

