# WHY SPEC-DRIVEN DEVELOPMENT (SDD)?

## The Illusion of "Vibe Coding"
"Vibe Coding" refers to writing software by describing abstract desires in natural language and letting an AI agent synthesize code without formal specifications or testing gates.

While vibe coding produces rapid initial progress on greenfield toy projects, it breaks down quickly in mature systems:
1. **Context Decay:** As files grow, the agent loses track of architectural constraints and invents conflicting patterns.
2. **Silent Regressions:** Without atomic specs and tests, fixes in module A quietly break edge cases in module B.
3. **Loss of Authorship:** The human developer ceases to understand how the codebase works, transforming maintenance into a nightmare.

---

## The Spec-Driven Alternative
Under Spec-Driven Development (SDD):
- **The Spec is the Source of Truth:** Code is merely a compiled downstream artifact of clear specifications.
- **Micro-Acceptance Criteria:** Every pull request or commit ties directly to verifiable bullet points.
- **Zero Vibe Merging:** If a requirement is not in the spec, it does not enter the codebase.

By forcing the agent to operate within the bounds of a verified specification, developer productivity increases while architectural sanity is preserved.

