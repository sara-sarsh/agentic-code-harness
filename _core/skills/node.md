# SKILL: Node.js & TypeScript Patterns

## Core Constraints
- Strict typing: Never use `any` unless wrapping un-typed legacy dependencies. Prefer `unknown` with type guards.
- Async code: Use `async/await` with explicit `try/catch`. Never mix raw callbacks with promises.
- Package scripts: Use the detected package manager (`pnpm`, `npm`, or `yarn`) as defined by the repository's lockfile.

## Testing Standards
- Run targeted tests via `npm test -- <test-file-path>` or `vitest run <test-file-path>`.
- Isolate file system or network operations using test doubles (mocks/stubs).
