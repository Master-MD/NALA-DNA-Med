# Feature Parity Workflow

Status: 2026-05-27

Use this workflow when macOS gets a new feature and Windows, Android, iOS, or the future Ubuntu server need to catch up.

## Principles

- macOS and Windows remain native apps, not copied UI code.
- Root `docs/` are the shared product truth.
- `docs/FEATURE_MATRIX.md` tracks feature status.
- Experimental features stay labeled experimental until tested.
- Platform ports must preserve existing features and user workflows.
- Antigravity/Codex agents must read current code before editing.

## Loop

1. Add or update the feature on macOS.
2. Update `docs/FEATURE_MATRIX.md`.
3. Run `tools/make-windows-sync-todo.sh <base-ref>` to generate `Windows/TODO_FROM_MACOS.md`.
4. Start Antigravity in the repository root.
5. Paste or point it to `Windows/ANTIGRAVITY_SYNC_PROMPT.md`.
6. Make the Windows port as experimental first.
7. Run Windows build/tests.
8. Update the matrix with the new Windows status.
9. Repeat only while the next loop gives meaningful improvement.

## Stop Rule

If a second or third improvement loop produces only marginal gains but consumes high time/resources, stop the implementation loop and move the idea into `docs/ROADMAP.md` or `Windows/TODO_FROM_MACOS.md` under `Later`.

## Porting Checklist

- Identify changed macOS files.
- Identify user-facing behavior, not just code.
- Find the closest existing Windows pattern.
- Add tests or manual verification steps.
- Add docs.
- Keep the feature experimental until verified.
- Do not delete old Windows functionality.
- Do not overwrite ports, routes, package IDs, app icons, or installer settings without explicit reason.
