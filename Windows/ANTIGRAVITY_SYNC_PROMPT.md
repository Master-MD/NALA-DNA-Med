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
8. Public docs: `docs/PITCH_SUMMARY.md`, `docs/FAQ.md`, `docs/HOWTO.md`, `docs/SOURCES_AND_FOUNDATION.md`

## Non-Negotiable Rules

- Do not delete existing Windows features.
- Do not overwrite Windows app identity, icons, project files, ports, or installer configuration unless the TODO explicitly requires it.
- Do not duplicate old source drops, generated binaries, private PDFs, ZIP packages, local paths, personal e-mail addresses, API keys, secrets, or real health data.
- Do not re-add `-NALA-DNA-MED-fundamentdateien-/`, `macOS/dist/`, generated `.app` bundles, generated DMGs, or obsolete mockup screenshots to Git.
- If `docs/fundamentals/`, `macOS/dist/`, root files with trailing spaces, old pitch PDFs, old ZIP packages, or obsolete screenshot dumps appear in `git status`, remove them from Git before doing any feature work.
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
6. Bring Windows docs to the same public-documentation level as macOS:
   - README links to pitch summary, FAQ, HowTo, feature matrix, and safety boundary.
   - Windows-specific install notes stay CAVEMAN-friendly.
   - Use the current public screenshots/previews only.

## Verification Expected

- Build the Windows solution.
- Run any available tests.
- Manually verify navigation to Dashboard, LLM-Fit, BioLab, Resources/Model Manager, and Settings.
- Run a privacy scan before committing for local paths, personal e-mail addresses, API-key patterns, generated binaries, and real health data.
- Report what was implemented, what remains, and what stayed experimental.

## Privacy Scan Starter

Before committing, run an equivalent Windows-safe scan for:

```text
personal e-mail addresses
local filesystem paths
Google Drive/iCloud/private working paths
API keys and bearer tokens
private keys
real patient or health data
generated binaries and installer artifacts
```

If a file is useful but private, summarize it into public markdown instead of committing the raw source file.

## Hard Git Gate

Before any commit, the following command must return no tracked files:

```bash
git ls-files | rg '(^-NALA-DNA-MED-fundamentdateien-/|^docs/fundamentals/|^macOS/dist/|NALA-DNA-Med_Doctor-Funding-Pitch|NALA-DNA-Med_Quellen|NALA-DNA-Med-aPP_|04_login|05_projects|06_upload|07_jobs|08_settings|09_biolab|Master-MD-NALA-DNA-Med.*webloc)'
```

If it prints anything, stop and remove those tracked files instead of continuing.
