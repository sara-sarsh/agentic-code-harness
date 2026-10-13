# 🛡️ Agentic Code Harness

> **A battle-tested harness, single-source-of-truth rules engine, and anti-vibe-coding toolkit for modern AI coding agents.**  
> Supports **Claude Code**, **Cursor**, **Antigravity / Gemini**, and **GitHub Copilot / Spec-Kit**.

---

## 🎯 The Problem: Why Agents Drift
When developers work with AI agents without strict guardrails, three failure modes emerge:
1. **Unsolicited Refactoring (Scope Creep):** The agent cleans up or changes adjacent code you never asked it to touch.
2. **Comment & Style Erosion:** The agent re-writes your comments, removes docstrings, and converts your formatting into generic LLM styles.
3. **Vibe Coding Disasters:** Generating hundreds of un-tested lines from loose natural language prompts, leading to context decay and silent regressions.

---

## ⚡ The Solution: The Harness
The **Agentic Code Harness** enforces engineering rigor across your repositories:
* **Single Source of Truth (`_core/RULES.md`):** Write rules once; compile automatically into `CLAUDE.md`, `.cursor/rules/harness.mdc`, and `.agents/AGENTS.md`.
* **Non-Negotiable Negative Constraints:** Explicit boundaries prohibiting comment rewrites, unwarranted reformatting, and broad diffs.
* **Surgical Diff Principle:** Only touch the exact lines addressing the atomic task spec.
* **Spec-Driven Atomic TDD Loop:** `SPEC -> IMPLEMENT -> TEST -> SIMULATE -> ATOMIC COMMIT`.
* **Escalation Triggers:** Automated stop conditions when an agent must halt and request human sign-off (e.g. database migrations, consecutive test failures).

---

## 🚀 Quick Start (5-Second Injection)

### 1. In a Local Project
Inject the harness into any existing codebase:
```bash
# From within the agentic-code-harness directory:
./tools/init-agent.sh --target /path/to/my-project --skill python --skill flask-api
```

### 2. Remote One-Liner (curl)
```bash
curl -sL https://raw.githubusercontent.com/sara-sarsh/agentic-code-harness/main/tools/init-agent.sh \
  | bash -s -- --skill python --skill flask-api
```

---

## 📂 Repository Structure

```text
agentic-code-harness/
├── README.md                     # You are here
├── CLAUDE.md                     # Auto-generated for Claude Code
├── .cursor/
│   └── rules/
│       └── harness.mdc           # Auto-generated for Cursor
├── .agents/
│   └── AGENTS.md                 # Auto-generated for Antigravity & Spec-Kit
│
├── _core/                        # SOURCE OF TRUTH
│   ├── RULES.md                  # Master rules file with section tags
│   └── skills/                   # On-demand domain skills (<150 lines)
│       ├── python.md
│       ├── flask-api.md
│       ├── node.md
│       ├── react.md
│       └── go.md
│
├── templates/
│   ├── TASK_SPEC.md              # Template for atomic task specifications
│   ├── ESCALATION_LOG.md         # Template for agent escalation decisions
│   └── COMMIT_CONVENTION.md      # Standards for atomic single-concern commits
│
├── tools/
│   ├── sync-rules.sh             # Compiles _core/RULES.md to all tool configs
│   └── init-agent.sh             # Scaffolder to inject harness into any repo
│
├── examples/
│   └── bad-vs-good-diffs/
│       └── DIFF_COMPARISON.md    # Visual breakdown of Vibe Coding vs Surgical Diffs
│
└── docs/
    ├── methodology.md            # Philosophy & context engineering
    ├── why-sdd.md                # Why Spec-Driven Development prevents decay
    └── tool-compatibility.md     # Multi-tool synchronization architecture
```

---

## 🔄 How Rule Synchronization Works
Never edit `CLAUDE.md` or `.cursor/rules/harness.mdc` manually!

1. Edit your master rules in `_core/RULES.md`. Use scoped tags:
   ```markdown
   <!-- @scope: universal -->
   ## UNIVERSAL CONSTRAINTS
   ...
   <!-- @scope: universal -->

   <!-- @scope: claude -->
   ## CLAUDE-SPECIFIC INSTRUCTIONS
   ...
   <!-- @scope: claude -->
   ```
2. Run the sync command:
   ```bash
   ./tools/sync-rules.sh
   ```
3. All editor configurations are updated in milliseconds.

---

## 🛑 Escalation Triggers (Human Sign-off)
By default, the harness orders the agent to **STOP IMMEDIATELY** and await human review if:
* [x] Any database migration or schema file is touched.
* [x] The test suite fails twice on the same fix attempt.
* [x] A single task affects more than 3 files simultaneously.
* [x] Authentication, session, or encryption logic is involved.
* [x] An environment variable (`.env`) is added or modified.

---

## 📖 Educational Documentation
- Read [`docs/methodology.md`](file:///Users/sara/Documents/Personal/bussiness-ideas/agentic-code-harness/docs/methodology.md) to understand Context Engineering.
- Read [`docs/why-sdd.md`](file:///Users/sara/Documents/Personal/bussiness-ideas/agentic-code-harness/docs/why-sdd.md) on why Spec-Driven Development eliminates Vibe Coding.
- Inspect [`examples/bad-vs-good-diffs/DIFF_COMPARISON.md`](file:///Users/sara/Documents/Personal/bussiness-ideas/agentic-code-harness/examples/bad-vs-good-diffs/DIFF_COMPARISON.md) to see concrete diff examples.

---

## 📄 License
MIT © 2026. Built for developers engineering with AI agents.

