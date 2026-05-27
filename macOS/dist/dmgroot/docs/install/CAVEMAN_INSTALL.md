# CAVEMAN Install Guide

Stand: 2026-05-27

## Meaning

`CAVEMAN Install Mode` means a non-technical user can install and start NALA-DNA-Med without understanding Terminal, Docker, Python, Swift, Git, Hugging Face, or model files.

The user experience must be:

1. Open DMG.
2. Drag app into Applications.
3. Open app.
4. Read safety notice.
5. Run automatic System Check.
6. Pick `Kleiner`, `Optimal`, or `Maximal`.
7. Use Local Lite Demo Mode.

## Hard Rules

- No terminal command is required for normal Local Lite installation.
- No Docker or OrbStack is required for Local Lite.
- No large model download starts automatically.
- No destructive action happens without confirmation.
- Every failure message must say what happened, why it matters, and what to do next.
- Every technical check should show a simple status: green, yellow, or red.
- The app must offer `Copy Support Report` so a user can send a diagnostic summary to a helper.

## First Launch Wizard

The generated app must include a first-launch wizard:

1. Safety notice
2. App data location confirmation
3. System Check
4. LLM-Fit recommendation
5. Resource policy explanation
6. Local Lite start

The wizard must provide a `Use Demo Mode` path even when network, Docker, Ollama, or model downloads are unavailable.

## Optional Model Import

A non-technical user can add models later without Terminal:

1. Open `Resources`.
2. Paste a trusted Weblink and choose `Download Weblink`, or choose `Choose Local Model File...` for a file on the Mac or external drive.
3. Wait for a green status.

Large models are optional. The app must stay usable in Demo Mode even when the user skips downloads.

## Error Message Format

Use this format for user-facing errors:

```text
Status: Yellow
Problem: Only 12 GB free disk space found.
Impact: Larger local models may not fit.
Next step: Use Kleiner mode now, or free disk space before choosing Maximal.
Technical detail: /System/Volumes/Data has 12 GB available.
```

## CAVEMAN Acceptance Test

A fresh user should be able to complete this path:

1. Download or build `NALA-DNA-Med.dmg`.
2. Open the DMG.
3. Drag the app into `/Applications`.
4. Launch the app.
5. Accept/read the safety notice.
6. Click through System Check.
7. Select `Kleiner`.
8. Open Dashboard.
9. Create a demo project.
10. Run BioLab dry-run.
11. Export or copy a support report.

No Terminal commands may be required for this path.

## Developer Responsibility

Developer docs and scripts may use Terminal, but user-facing installation must not depend on it. If a feature requires developer tools, Docker, Xcode, or command-line knowledge, label it as `Advanced` or `Developer`.
