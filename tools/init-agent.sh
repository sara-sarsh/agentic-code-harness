#!/usr/bin/env bash
# tools/init-agent.sh
# Scaffolding tool to inject the Agentic Code Harness into any project in seconds.
#
# Usage (Local):
#   ./tools/init-agent.sh [--target /path/to/project] [--skill python] [--skill flask-api]
#
# Usage (Remote curl):
#   curl -sL https://raw.githubusercontent.com/sara-sarsh/agentic-code-harness/main/tools/init-agent.sh | bash -s -- --skill python

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
LOCAL_SOURCE_DIR=""
if [[ -n "$SCRIPT_DIR" && -d "$SCRIPT_DIR/../_core" ]]; then
  LOCAL_SOURCE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
fi

GITHUB_RAW_URL="https://raw.githubusercontent.com/sara-sarsh/agentic-code-harness/main"
TARGET_DIR="."
SKILLS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    --target)
      TARGET_DIR="$2"
      shift 2
      ;;
    --skill)
      SKILLS+=("$2")
      shift 2
      ;;
    -h|--help)
      echo "Agentic Code Harness Scaffolder"
      echo "Usage: ./init-agent.sh [--target <dir>] [--skill <skill_name>]..."
      echo "Available skills: python, flask-api, node, react, go"
      exit 0
      ;;
    *)
      shift
      ;;
  esac
done

echo "=================================================="
echo "⚡ Injecting Agentic Code Harness into: $TARGET_DIR"
echo "=================================================="

mkdir -p "$TARGET_DIR/_core/skills" "$TARGET_DIR/.cursor/rules" "$TARGET_DIR/.agents" "$TARGET_DIR/tools"

copy_or_download() {
  local rel_path="$1"
  local dest_path="$TARGET_DIR/$rel_path"
  mkdir -p "$(dirname "$dest_path")"

  if [[ -n "$LOCAL_SOURCE_DIR" && -f "$LOCAL_SOURCE_DIR/$rel_path" ]]; then
    cp "$LOCAL_SOURCE_DIR/$rel_path" "$dest_path"
    echo "  [local] copied: $rel_path"
  else
    echo "  [remote] downloading: $rel_path"
    curl -sSfL "$GITHUB_RAW_URL/$rel_path" -o "$dest_path" || {
      echo "  ⚠️ Warning: Could not fetch $rel_path" >&2
    }
  fi
}

# 1. Sync Core Files
copy_or_download "_core/RULES.md"
copy_or_download "tools/sync-rules.sh"
chmod +x "$TARGET_DIR/tools/sync-rules.sh" 2>/dev/null || true

# 2. Inject Requested Skills
for skill in "${SKILLS[@]}"; do
  copy_or_download "_core/skills/${skill}.md"
done

# 3. Generate Tool-Specific Rule Files
if [[ -x "$TARGET_DIR/tools/sync-rules.sh" ]]; then
  echo "→ Synchronizing multi-tool configs (CLAUDE.md, Cursor MDC, AGENTS.md)..."
  (cd "$TARGET_DIR" && ./tools/sync-rules.sh)
fi

echo "=================================================="
echo "✓ Agentic Code Harness successfully installed!"
echo "  - Edit _core/RULES.md to customize project constraints."
echo "  - Run 'tools/sync-rules.sh' anytime you update rules."
echo "=================================================="

