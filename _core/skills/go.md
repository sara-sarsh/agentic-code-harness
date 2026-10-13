# SKILL: Go Engineering Patterns

## Core Constraints
- Follow standard Go idiomatic error handling: `if err != nil { return fmt.Errorf("context: %w", err) }`. Never ignore errors with `_`.
- Concurrency: Never leak goroutines. Use `context.Context` for cancellation and timeouts across network and IO calls.
- Package layout: Respect standard Go directory structure (`cmd/`, `internal/`, `pkg/`).

## Surgical Modification Rules
- Match existing receiver naming conventions (e.g., single-letter receivers matching the struct name).
- Run targeted tests only: `go test -v -run TestTargetFunction ./path/to/pkg`.

