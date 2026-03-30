# Contributing to PyProxy

Thank you for considering a contribution! This document explains the process
and standards we follow to keep the codebase clean and reviewable.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Code Style](#code-style)
- [Testing](#testing)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)

---

## Code of Conduct

Be respectful. Constructive criticism of code is welcome; personal attacks
are not. We follow the
[Contributor Covenant v2.1](https://www.contributor-covenant.org/version/2/1/code_of_conduct/).

---

## Getting Started

```bash
# 1. Fork and clone
git clone https://github.com/<your-fork>/pyproxy.git
cd pyproxy

# 2. Create a virtual environment
python -m venv .venv
source .venv/bin/activate      # Windows: .venv\Scripts\activate

# 3. Install in editable mode with dev extras
pip install -e ".[dev]"

# 4. Verify everything works
pytest tests/ -v
```

---

## Development Workflow

```
main          ← protected, releases only
  └── develop ← integration branch (PR target for features)
        ├── feature/your-feature-name
        └── fix/short-description
```

1. Branch from `develop`.
2. Keep branches focused — one feature or fix per branch.
3. Rebase onto `develop` before opening a PR; do not merge-commit.

---

## Code Style

We use **Ruff** for linting and formatting (configured in `pyproject.toml`).

```bash
# Lint
ruff check src/ tests/

# Auto-fix safe issues
ruff check --fix src/ tests/

# Type checking
mypy src/
```

Key conventions:
- **PEP 8** throughout — max line length 99.
- `from __future__ import annotations` in every module.
- All public functions and classes must have docstrings.
- No mutable default arguments.
- Prefer `asyncio.create_task` over bare coroutines for fire-and-forget work.

---

## Testing

```bash
# Full suite
pytest tests/ -v

# With coverage
pytest tests/ --cov=src --cov-report=term-missing

# Single module
pytest tests/test_auth.py -v
```

Requirements for new code:
- Every new public function must have at least one positive and one negative
  unit test.
- Changes to header sanitisation **must** include a test asserting the header
  is absent from the outbound request.
- Changes to security policy **must** include a test asserting both the
  blocked and allowed cases.
- Minimum coverage threshold: **80 %** (enforced by CI).

---

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <short summary>

[optional body — wrap at 72 chars]

[optional footer: Fixes #123]
```

Types: `feat`, `fix`, `docs`, `test`, `refactor`, `perf`, `ci`, `chore`.

Examples:
```
feat(auth): add TOTP two-factor authentication support
fix(security): resolve SSRF bypass via URL-encoded hostnames
docs(readme): add Kubernetes deployment example
test(headers): add test for Connection-token stripping edge case
```

---

## Pull Request Process

1. Ensure `pytest`, `ruff check`, and `mypy` all pass locally.
2. Update `CHANGELOG.md` under the `[Unreleased]` section.
3. Open the PR against `develop` (not `main`).
4. Fill in the PR template — describe *what* and *why*, not just *how*.
5. At least one maintainer approval is required before merging.
6. Squash-merge is preferred for feature branches; merge-commit for releases.

---

Thank you for contributing! 🎉
