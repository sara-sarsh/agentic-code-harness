# THE AGENTIC CODE HARNESS METHODOLOGY

## Overview
As AI coding assistants evolve from simple line-completion tools to autonomous multi-file agents, the primary failure mode of software development shifts from **syntax errors** to **architectural drift** and **scope creep**.

The **Agentic Code Harness** is built around three foundational pillars:
1. **Context Engineering over Prompt Engineering**
2. **Negative Constraints & Minimal Diffs**
3. **Spec-Driven Atomic TDD Execution**

---

## 1. Context Engineering over Prompt Engineering
Prompt engineering attempts to convince an LLM through clever phrasing. Context engineering shapes the environment in which the agent operates:
- High-priority, lean bootstrap files (< 150 lines).
- Modular, on-demand skill discovery instead of bloated root prompts.
- Section-tagged master rules (`_core/RULES.md`) that propagate deterministically to all editor configs.

---

## 2. The Surgical Diff Principle
When an LLM produces a diff, it often "cleans up while it's in there":
- Reformatting whitespace.
- Rewording developer comments into generic summaries.
- Modernizing idiomatically chosen legacy patterns.

The Harness strictly treats the repository as a sacred ground:
- Existing code and comments are **read-only** by default.
- Changes are restricted to the **exact lines** addressing the user's explicit task.
- Unrequested refactors trigger immediate task review.

---

## 3. The Spec-Driven Atomic Loop
Rather than prompting: *"Build an authentication system"*, tasks follow a rigorous finite-state machine:

```text
       ┌──────────┐
       │   SPEC   │  (One-sentence contract + max 5 acceptance criteria)
       └────┬─────┘
            ▼
       ┌──────────┐
       │IMPLEMENT │  (Surgical code change only)
       └────┬─────┘
            ▼
       ┌──────────┐
       │   TEST   │  (Unit test verifying the acceptance criteria)
       └────┬─────┘
            ▼
       ┌──────────┐
       │ SIMULATE │  (Run target test command: pytest / vitest)
       └────┬─────┘
            │
     Pass   │   Fail (>= 2 times)
   ─────────┴──────────────────────► [ ESCALATE & STOP ]
            │
            ▼
       ┌──────────┐
       │  COMMIT  │  (Atomic git commit: feat(scope): message)
       └──────────┘
```

