# SKILL: Python & Pytest Engineering Patterns

## Core Constraints
- Target Python 3.10+ modern syntax (type annotations using `list[str]`, `dict[str, Any]`, `X | None`).
- Use `pytest` for all unit testing. Prefer fixtures over setup/teardown methods.
- Always run test commands targeting only the modified test file, never the entire test suite:
  `pytest tests/test_<module>.py -v`

## Style & Idioms
- Match existing docstring convention (Google style, Sphinx, or simple docstring). Do not reformat.
- Use early returns to reduce indentation depth.
- Prefer explicit exception handling over bare `except:`.
- If mocking is needed, use `unittest.mock.patch` with context managers or `mocker` fixture.

## Common Anti-Patterns to Avoid
- Do NOT rewrite list comprehensions into loops or vice versa unless directly requested.
- Do NOT add `typing.Optional` if the file already uses `| None`. Match the file's style.

