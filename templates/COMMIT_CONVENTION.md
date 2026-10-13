# AGENTIC ATOMIC COMMIT CONVENTIONS

## Core Rule
Each commit must encapsulate exactly **one atomic unit of work** (Single Concern). Never bundle refactors, multiple features, or unrelated file changes into a single commit.

## Format
```text
<type>(<scope>): <short imperative sentence matching task spec>

[optional body describing the surgical change and verification test]
```

## Types
- `feat`: A new verifiable capability or feature unit.
- `fix`: A surgical bugfix for a specific defect.
- `test`: Addition or modification of unit tests.
- `refactor`: Structural change requested explicitly by the user (no behavioral changes).
- `docs`: Documentation or specification update.

## Examples
- `feat(auth): validate email domain whitelist on signup`
- `test(auth): add unit test for forbidden domain rejection`
- `fix(planner): resolve off-by-one error in lunar phase calculation`

