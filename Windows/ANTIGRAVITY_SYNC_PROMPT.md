# Antigravity Prompt: Sync macOS Features Into Windows

You are working in the `NALA-DNA-Med` monorepo. The goal is to bring the Windows WinUI app closer to the current macOS SwiftUI feature set without deleting, overwriting, or duplicating existing Windows work.

## Read First

1. `README.md`
2. `docs/FEATURE_MATRIX.md`
3. `docs/FEATURE_PARITY_WORKFLOW.md`
4. `Windows/TODO_FROM_MACOS.md`
5. `Windows/README.md`
6. Current Windows source under `Windows/NalaDnaMedWin/`
7. Relevant macOS implementation under `macOS/Sources/`

## Non-Negotiable Rules

- Do not delete existing Windows features.
- Do not overwrite Windows app identity, icons, project files, ports, or installer configuration unless the TODO explicitly requires it.
- Do not copy SwiftUI code into Windows. Port behavior into native WinUI/C# patterns.
- New parity work starts as `Experimental`.
- Keep the medical safety boundary visible.
- Do not add medical claims, diagnosis, treatment, or prescription behavior.
- Update docs and `docs/FEATURE_MATRIX.md` after implementation.

## Current Porting Priorities

1. Port Model Manager:
   - trusted Weblink input
   - size warning
   - download progress
   - file picker import for local model files
   - supported file extensions
   - clear green/yellow/red status messages
2. Add Support Report copy/export.
3. Align LLM-Fit checks with macOS where practical.
4. Add a first-run responsible-use agreement screen after legal copy is finalized.
5. Keep everything usable in Local Lite Demo Mode without WSL, Docker, or Terminal.

## Verification Expected

- Build the Windows solution.
- Run any available tests.
- Manually verify navigation to Dashboard, LLM-Fit, BioLab, Resources/Model Manager, and Settings.
- Report what was implemented, what remains, and what stayed experimental.
