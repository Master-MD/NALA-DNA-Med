# NALA-DNA-Med Master Generation Brief

Stand: 2026-05-27

## One-Line Goal

Generate a native SwiftUI macOS app called `NALA-DNA-Med` for local-first biomedical research support, with LLM-Fit model recommendations, safe resource downloads, Local Lite Mode, optional Core Mode, complete documentation, tests, and DMG packaging.

## Critical Product Boundary

NALA-DNA-Med is not medical advice, not a medical device, and not validated for diagnosis or treatment. All generated UI, docs, demo outputs, and README text must preserve that boundary.

## Primary Platform

macOS native SwiftUI.

The app must feel like a real Mac app:

- native window
- sidebar/detail layout
- Settings scene
- toolbar actions
- app icon
- local app data
- DMG packaging
- CAVEMAN install path for non-technical users

## App Icon

Use:

```text
/Users/ultramacuser/Library/Mobile Documents/com~apple~CloudDocs/-DC_Consulting-/___INTERN___/*****AppEntwicklung*****/*****NALA-Bilder*****/NALA/***NALA-AppZ-IconS***/NALA-DNA-Med.png
```

Generate `NALA-DNA-Med.icns` from it and configure it as the app icon.

## Runtime Modes

## CAVEMAN Install Mode

The generated app must be installable and usable by non-technical users in Local Lite Mode.

The required simple path:

1. Open DMG.
2. Drag app into Applications.
3. Start app.
4. Read safety notice.
5. Run automatic System Check.
6. Choose `Kleiner`.
7. Use Local Lite Demo Mode.

No Terminal, Docker, Python, Git, Xcode, or developer knowledge may be required for that path.

All checks must show green/yellow/red status. Failures must explain problem, impact, next step, and technical detail. The app must include `Copy Support Report`.

### Local Lite Mode

Must work without Docker or OrbStack.

Includes:

- native UI
- local project vaults
- local app data
- first-run safety screen
- system check
- LLM-Fit
- BioLab dry-run
- resource catalog download
- audit simulation
- backup/restore

### Core Mode

Optional. Requires Docker/OrbStack.

Services:

- FastAPI app backend
- PostgreSQL
- Qdrant
- MinIO
- Redis
- BioModel API stub

Core Mode can be generated after Local Lite is stable, but the UI should expose planned support.

## LLM-Fit Advisor

LLM-Fit must:

- detect hardware
- detect free disk
- detect Ollama
- detect Docker/OrbStack
- detect existing local models
- fetch small model catalogs
- recommend one of:
  - `Kleiner`
  - `Optimal`
  - `Maximal`
- explain the recommendation
- require confirmation for large downloads

Current observed machine:

- Apple M4 Max MacBook Pro
- 64 GB unified memory
- 40-core GPU
- Ollama installed
- Docker installed
- approximately 35 GB free disk at inspection time

That machine is strong, but current free disk is limited. The generated recommendation logic must treat disk as a hard constraint.

## First-Run Resources

Allowed automatic downloads:

- small JSON catalogs
- demo templates
- citation/source metadata
- remote plugin metadata

Blocked without user confirmation:

- LLM weights
- MAMMAL weights
- RDKit/BioPython heavy dependency installs
- large datasets
- unknown-license resources

## Core Safety Rules

Every BioLab result must be marked:

```json
{
  "demo_mode": true,
  "not_medical_advice": true,
  "confidence": "low"
}
```

No real biomedical claim in v0.1.

## TenantShield

Every important data object must carry tenant/project metadata where applicable.

No retrieval/tool call may run without:

- tenant_id
- project_id
- audit event

## Required Screens

1. First Run / Safety
2. System Check
3. LLM-Fit
4. Dashboard
5. Projects / Vaults
6. Upload Center
7. BioLab Demo
8. Jobs / Audit
9. Resources
10. Settings
11. Backup / Restore
12. Support Report

## Required Docs In Generated Repo

- `README.md`
- `FAQ.md`
- `docs/ARCHITECTURE.md`
- `docs/INSTALLATION.md`
- `docs/CAVEMAN_INSTALL.md`
- `docs/DMG_PACKAGING.md`
- `docs/BIOMEDICAL_SAFETY.md`
- `docs/LLM_FIT.md`
- `docs/WINDOWS_NATIVE_STRATEGY.md`
- `docs/TROUBLESHOOTING.md`
- `docs/DEVELOPER_GUIDE.md`

## Required Tests

Generate automated tests for:

- system check
- LLM-Fit profile selection
- large download gate
- resource catalog parsing
- BioLab dry-run safety flags
- TenantShield validation
- backup naming
- CAVEMAN first-launch path can reach Dashboard without developer tools

## Windows Future

Windows should be a separate native WinUI 3 app, not a SwiftUI port. It should reuse:

- API contracts
- data model
- LLM-Fit rules
- resource catalog schema
- safety language
- docs

## Generation Quality Bar

The generated app should build, run, and show a useful first screen. If the generator cannot complete a full DMG, it must still generate:

- source code
- build scripts
- tests
- docs
- exact remaining blocker list
- a CAVEMAN install path that does not require Terminal for Local Lite
