# MULTI-TOOL COMPATIBILITY & HARMONIZATION

The Agentic Code Harness is designed to be completely tool-agnostic. Instead of maintaining distinct rule files for every editor, the single source of truth (`_core/RULES.md`) compiles into native configuration files for:

| Tool | Config Location | How it is Generated |
|---|---|---|
| **Claude Code (Anthropic)** | `CLAUDE.md` | Extracts `universal` + `claude` scopes |
| **Cursor** | `.cursor/rules/harness.mdc` | Extracts `universal` + `cursor` scopes with MDC frontmatter |
| **Antigravity / Spec-Kit** | `.agents/AGENTS.md` | Extracts full rules & skills matrix |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Can symlink or sync from `CLAUDE.md` |

## Preventing "Rule Rot"
Rule Rot occurs when a team updates a convention in Cursor's `.cursorrules`, but forgets to update `CLAUDE.md` or `.agents/AGENTS.md`.

In the Harness:
- Developers **only** edit `_core/RULES.md`.
- Running `tools/sync-rules.sh` updates all tool configurations simultaneously.
- CI/CD can enforce that `tools/sync-rules.sh` produces no git diff before merging PRs.
