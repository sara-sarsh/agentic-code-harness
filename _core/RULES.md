# AGENTIC CODE HARNESS — MASTER RULES

<!-- @scope: universal -->
# UNIVERSAL CONSTRAINTS & CODE INTEGRITY

## 1. Comment & Docstring Preservation
- NEVER alter, reword, reformat, expand, or delete existing comments or docstrings.
- NEVER add unsolicited inline comments to code lines that previously had none.
- If an existing comment is factually incorrect, FLAG it: `# FIXME(agent): <reason>` — do NOT rewrite it silently.
- Existing docstrings are strictly READ-ONLY. If clarifications or notes are needed, append `# AGENT NOTE: <clarification>` below.

## 2. Code Style & Architecture Preservation
- Mirror the exact indentation (tabs/spaces), naming conventions, and quote styles of the surrounding code.
- Do NOT apply external formatters (black, prettier, gofmt) unless the task explicitly specifies "format entire file".
- If adjacent code uses `camelCase`, use `camelCase`. If it uses `snake_case`, use `snake_case`. Match the file, not personal preference.
- Match existing blank line spacing and method ordering.

## 3. Surgical Diff Minimality (Zero Scope Creep)
- Touch ONLY the exact lines and functions required by the explicit task specification.
- Never "clean up while you're in there". No unsolicited renaming, dead-code removal, or style adjustments.
- If adjacent code appears buggy or deprecated, do NOT touch it. Mark it with: `# REVIEW(agent): possible issue — left untouched`.
- Add ONLY the imports directly required by the new change; NEVER prune existing imports unless explicitly instructed.

## 4. Spec-Driven Task Execution & Escalation Triggers
- Do not write code without an approved Task Spec and verification criteria.
- Adhere strictly to the ATOMIC TASK loop: `SPEC -> IMPLEMENT -> TEST -> VERIFY -> ATOMIC COMMIT`.
- STOP execution and demand human review immediately if any of these **Escalation Triggers** occur:
  * [ ] Any file under `migrations/` or database schema is modified.
  * [ ] The test suite fails 2 consecutive times for the same fix.
  * [ ] A single change would affect more than 3 files simultaneously.
  * [ ] Authentication, session management, permissions, or security token logic is touched.
  * [ ] An environment variable (`.env`) is added, renamed, or modified.
  * [ ] External credentials or un-mocked third-party APIs are required.

<!-- @scope: universal -->

<!-- @scope: claude -->
# CLAUDE CODE EXECUTION RULES
- Keep responses concise and focused on executable commands and code changes.
- Prioritize targeted block replacements (`Search & Replace`) over full-file overwrites.
- Show git diff before making broad modifications when task ambiguity exists.
<!-- @scope: claude -->

<!-- @scope: cursor -->
---
description: "Agentic Code Harness — Surgical Precision & Anti-Scope-Creep"
globs: "*.*"
alwaysApply: true
---
# CURSOR SURGICAL EXECUTION RULES
- Use targeted edits. Do not rewrite files from line 1 to end.
- Respect all Hard Constraints in _core/RULES.md.
<!-- @scope: cursor -->

<!-- @scope: universal -->
# MODULAR SKILL DISCOVERY
When a task involves a specific domain or technology stack, read the corresponding skill file on-demand before proceeding:
- Python / Pytest: read `_core/skills/python.md`
- Flask / REST APIs: read `_core/skills/flask-api.md`
- Node.js / TypeScript: read `_core/skills/node.md`
- React / Frontend: read `_core/skills/react.md`
- Go: read `_core/skills/go.md`

Do NOT load or process skills irrelevant to the immediate task to preserve context window budget.
<!-- @scope: universal -->

