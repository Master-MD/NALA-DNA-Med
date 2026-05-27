#!/usr/bin/env bash
set -euo pipefail

BASE_REF="${1:-origin/main}"
OUT="Windows/TODO_FROM_MACOS.md"

{
  echo "# Windows TODO From macOS"
  echo
  echo "Generated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "Base ref: $BASE_REF"
  echo
  echo "## Changed macOS Files"
  echo
  if git rev-parse --verify "$BASE_REF" >/dev/null 2>&1; then
    git diff --name-only "$BASE_REF"...HEAD -- macOS | sed 's/^/- /'
  else
    echo "- Base ref not found. Fill this section manually."
  fi
  echo
  cat <<'PROMPT'
## Antigravity Instructions

Use `Windows/ANTIGRAVITY_SYNC_PROMPT.md`.

Port behavior, not SwiftUI code. Preserve existing Windows features. Add new work as experimental first. Update `docs/FEATURE_MATRIX.md` after implementation.

## Manual Notes

- Describe the feature behavior that changed on macOS.
- List required Windows UI changes.
- List required Windows services/models changes.
- List tests/manual checks.
PROMPT
} > "$OUT"

echo "Wrote $OUT"
