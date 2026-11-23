---
name: Python conventions
applyTo: "**/*.py"
---

# Python conventions

- Follow the repository's Python version, formatter, linter, typing level, and package structure.
- Prefer standard-library solutions and existing dependencies where practical.
- Prefer simple functions and clear control flow; use classes when state or established patterns justify them.
- Use type annotations consistently with nearby code; do not undertake repo-wide typing cleanup.
- Use context managers for owned resources and specific exceptions for expected failure modes.
- Do not add broad `except Exception`, silent fallbacks, or redundant validation without a concrete reason.
- Prefer the narrowest relevant existing test or check; add tests only for meaningful changed behavior.
