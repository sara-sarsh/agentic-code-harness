# SKILL: React & Modern Frontend Patterns

## Core Constraints
- Component granularity: Keep components focused on a single UI responsibility. Extract complex logic into custom hooks (`useX`).
- State management: Keep state as local as possible. Do not introduce global state stores for transient UI states.
- Performance: Memoize callbacks (`useCallback`) and expensive calculations (`useMemo`) only when measured or passing functions to optimized child components.

## Surgical Modification Rules
- When modifying JSX/TSX, preserve existing Tailwind CSS classes, inline styles, and semantic accessibility attributes (ARIA).
- Do not refactor functional components to arrow functions or vice versa; preserve existing component declaration syntax.
