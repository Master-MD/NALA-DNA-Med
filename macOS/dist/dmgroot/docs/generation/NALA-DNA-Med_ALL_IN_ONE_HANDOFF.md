# NALA-DNA-Med All-in-One Handoff

Stand: 2026-05-27

This is the single-file handoff for Codex, Antigravity, or another coding agent. It contains the product boundary, app architecture, documentation requirements, safety rules, LLM-Fit plan, Windows strategy, tests, packaging expectations, and the full generation prompt.

## 1. Goal

Generate a native macOS SwiftUI app called `NALA-DNA-Med` for local-first biomedical research support.

The generated project must include:

- native SwiftUI app
- app icon
- Local Lite Mode
- optional Core Mode
- LLM-Fit advisor
- first-run resource flow
- BioLab dry-run
- TenantShield data rules
- tests
- README
- FAQ
- installation guide
- CAVEMAN install guide
- DMG packaging guide
- safety documentation
- Windows native strategy

## 2. Medical Boundary

NALA-DNA-Med is not medical advice, not a medical device, and not validated for diagnosis, treatment, prescription, or clinical decision-making.

Mandatory UI text:

```text
This system is not medical advice and is not validated for diagnosis or treatment.
```

German UI text:

```text
Dieses System ist keine medizinische Beratung und nicht fuer Diagnose oder Therapie validiert.
```

Allowed wording:

- research support
- education/demo
- literature triage
- project vault
- screening assistance
- hypothesis generation
- dry-run

Forbidden wording:

- diagnoses patients
- recommends treatment
- discovers medication
- replaces medical review
- validated clinical decision support

## 3. Primary Platform

Build a native macOS SwiftUI app.

Use:

- `WindowGroup` for main window
- `Settings` scene
- `NavigationSplitView`
- native toolbar actions
- modular app folders
- app-local persistence for v0.1
- native macOS interaction patterns

Recommended file layout:

```text
NALA-DNA-Med/
  App/
  Models/
  Stores/
  Services/
  Views/
  Support/
  Tests/
  docs/
  script/
```

## 4. App Icon

Use this icon source:

```text
/Users/ultramacuser/Library/Mobile Documents/com~apple~CloudDocs/-DC_Consulting-/___INTERN___/*****AppEntwicklung*****/*****NALA-Bilder*****/NALA/***NALA-AppZ-IconS***/NALA-DNA-Med.png
```

Generate `.icns` sizes:

- 16x16
- 32x32
- 128x128
- 256x256
- 512x512
- 1024x1024

## 5. Visual Direction

NALA Black Edition:

- black
- graphite
- gunmetal
- emerald accent
- industrial but readable
- native macOS controls where possible
- no clutter
- no sound by default

## 6. Required Screens

1. First Run / Safety Notice
2. System Check
3. LLM-Fit Advisor
4. Dashboard
5. Projects / Vaults
6. Upload Center
7. BioLab Demo
8. Jobs / Audit
9. Resources
10. Settings
11. Backup / Restore
12. Support Report

## 6.1 CAVEMAN Install Mode

CAVEMAN Install Mode is a hard requirement for Local Lite.

It means a non-technical user can complete this path without Terminal, Docker, Python, Git, Xcode, or developer knowledge:

1. Open DMG.
2. Drag app into Applications.
3. Start app.
4. Read safety notice.
5. Run automatic System Check.
6. Choose `Kleiner`.
7. Use Local Lite Demo Mode.

The app must show green/yellow/red status for technical checks.

Failures must explain:

- problem
- impact
- next step
- technical detail

The app must include `Copy Support Report`.

Developer-only features must be clearly marked as `Advanced`.

## 7. Runtime Modes

### Local Lite Mode

Must work without Docker or OrbStack.

Includes:

- native UI
- local project metadata
- demo vaults
- upload placeholders
- BioLab dry-run
- LLM-Fit
- resource catalog
- audit events
- backup/restore

### Core Mode

Optional, Docker/OrbStack-based.

Prepared services:

- FastAPI backend
- PostgreSQL
- Qdrant
- MinIO
- Redis
- BioModel API stub

The app must detect Docker/OrbStack before enabling Core actions.

## 8. LLM-Fit Advisor

LLM-Fit recommends a local model setup. It must detect:

- macOS version
- architecture
- chip name
- unified memory
- GPU/Metal support
- free disk
- Ollama availability
- Docker/OrbStack availability
- existing local models
- network availability

Profiles:

- `Kleiner`: fastest, smallest, safest with low disk
- `Optimal`: balanced quality and footprint
- `Maximal`: larger model, only after explicit confirmation

Observed example machine on 2026-05-27:

- Apple M4 Max MacBook Pro
- 64 GB unified memory
- 40-core GPU
- Ollama installed
- Docker installed
- about 35 GB free disk

Disk is the limiting factor. The app should recommend conservative defaults until more disk is available.

## 9. Resource Download Policy

Allowed automatically:

- small JSON catalogs
- demo templates
- citation/source metadata
- model metadata

Require explicit confirmation:

- LLM weights
- biomedical model weights
- large datasets
- RDKit/BioPython heavy installs
- unknown-license resources

Download confirmation must show:

- model/resource name
- source
- size
- free disk
- license if known
- cancel option

## 10. BioLab v0.1

BioLab must be demo-only.

Every output must include:

```json
{
  "demo_mode": true,
  "not_medical_advice": true,
  "confidence": "low",
  "warnings": []
}
```

No real biomedical claim in v0.1.

## 11. TenantShield

Every important object should carry:

```json
{
  "tenant_id": "tenant_mike",
  "user_id": "user_mike",
  "project_id": "project_biolab_demo",
  "created_at": "ISO-8601",
  "updated_at": "ISO-8601"
}
```

No retrieval or tool call may run without tenant/project context and audit logging.

Initial entities:

- Tenant
- User
- Project
- Document
- Job
- AuditEvent
- ResourceCatalogEntry
- LLMFitRecommendation

## 12. Tests

Generate tests for:

- system check parsing
- LLM-Fit profile selection
- large download gate
- resource catalog parser
- BioLab dry-run safety flags
- TenantShield missing context rejection
- backup timestamp naming
- CAVEMAN first-launch path can reach Dashboard without developer tools

## 13. Documentation In Generated Repo

Generate:

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

## 14. DMG Packaging

Generate scripts:

- `script/build_debug.sh`
- `script/build_release.sh`
- `script/make_icns.sh`
- `script/make_dmg.sh`

Do not claim notarization unless it actually completes. Local DMG packaging is enough for v0.1 handoff.

## 15. Windows Strategy

Windows should be a separate native WinUI 3 app.

Share:

- API contracts
- data model
- LLM-Fit rules
- resource catalog schema
- safety copy
- docs

Do not try to reuse SwiftUI UI code for Windows.

## 16. Acceptance Criteria

1. SwiftUI app builds.
2. App opens to First Run or Dashboard.
3. Safety warning is visible.
4. LLM-Fit shows `Kleiner`, `Optimal`, `Maximal`.
5. Local Lite Mode works without Docker.
6. BioLab dry-run returns only safety-marked demo results.
7. Large model downloads require explicit confirmation.
8. Tests pass or blockers are documented.
9. README, FAQ, installation docs, and DMG docs exist.
10. DMG script exists and either creates a DMG or documents the exact blocker.
11. CAVEMAN path works: non-technical Local Lite install and demo use require no Terminal commands.

## 17. Full Generation Prompt

```text
You are a senior macOS SwiftUI engineer, local AI systems engineer, and safety-focused biomedical software architect.

Project:
NALA-DNA-Med

Build a native macOS SwiftUI app for local-first biomedical research support.

Critical boundary:
This is not medical advice, not a medical device, and not validated for diagnosis or treatment. Do not generate any claim that the app diagnoses, treats, prescribes, or discovers real medication. Use research support, education/demo, literature triage, project vault, screening assistance, and hypothesis-generation language only.

Primary deliverable:
A native macOS SwiftUI app with complete documentation, tests, and DMG packaging scripts.

CAVEMAN requirement:
Normal Local Lite installation must be possible for a non-technical user. The user must be able to open the DMG, drag the app into Applications, start the app, read the safety notice, run System Check, choose Kleiner, and use Demo Mode without Terminal, Docker, Python, Git, Xcode, or developer knowledge. Technical failures must be shown as green/yellow/red status with problem, impact, next step, and technical detail. Include a Copy Support Report action.

Use this app icon:
/Users/ultramacuser/Library/Mobile Documents/com~apple~CloudDocs/-DC_Consulting-/___INTERN___/*****AppEntwicklung*****/*****NALA-Bilder*****/NALA/***NALA-AppZ-IconS***/NALA-DNA-Med.png

App architecture:
- Native SwiftUI macOS app.
- Use WindowGroup for the main window.
- Use Settings scene for app preferences.
- Use NavigationSplitView for sidebar/detail layout.
- Use native macOS toolbar actions and menus.
- Keep files modular: App, Models, Stores, Services, Views, Support.
- Use app-local persistence suitable for v0.1.
- Local Lite Mode must work without Docker.
- Core Mode is optional and should detect Docker/OrbStack before enabling actions.

Visual style:
- NALA Black Edition.
- Black, graphite, gunmetal, emerald accent.
- Industrial and focused, but readable.
- Use native macOS controls where possible.
- Avoid clutter.
- No audio by default.

Required screens:
1. First Run / Safety Notice
2. System Check
3. LLM-Fit Advisor
4. Dashboard
5. Projects / Vaults
6. Upload Center
7. BioLab Demo
8. Jobs / Audit
9. Resources
10. Settings
11. Backup / Restore
12. Support Report

Local Lite Mode:
Must run without Docker or OrbStack.
Include local project creation, demo vault metadata, upload placeholders, BioLab dry-run, resource catalog handling, audit events, and backup/restore.

Core Mode:
Prepare optional integration for:
- FastAPI backend
- PostgreSQL
- Qdrant
- MinIO
- Redis
- BioModel API stub
Do not make Core Mode required for first launch.

LLM-Fit:
Build a model advisor that detects:
- macOS version
- architecture
- chip name if possible
- unified memory
- GPU/Metal support
- free disk space
- Ollama availability
- Docker/OrbStack availability
- existing local models
- network availability

LLM-Fit must recommend one of:
- Kleiner
- Optimal
- Maximal

It must explain why and must block automatic large downloads.

Current example machine:
- Apple M4 Max MacBook Pro
- 64 GB unified memory
- 40-core GPU
- Ollama installed
- Docker installed
- only about 35 GB free disk observed on 2026-05-27
This means disk space is the limiting factor. Recommend conservative defaults until more space is available.

First-run resources:
Allowed automatic downloads:
- small JSON catalogs
- demo templates
- citation/source metadata
- model metadata

Require explicit confirmation for:
- LLM weights
- biomedical model weights
- large datasets
- RDKit/BioPython/heavy dependency installs
- unknown-license resources

BioLab v0.1:
Implement demo endpoints/service logic only. Every result must include:
- demo_mode: true
- not_medical_advice: true
- confidence: low
- warnings
Do not create real biomedical claims.

TenantShield:
Every important entity should include tenant/project metadata where applicable:
- tenant_id
- user_id where applicable
- project_id where applicable
- created_at
- updated_at
No retrieval or tool call may run without tenant/project context and audit event.

Data entities:
- Tenant
- User
- Project
- Document
- Job
- AuditEvent
- ResourceCatalogEntry
- LLMFitRecommendation

Tests:
Add automated tests for:
- SystemCheckService
- LLMFitService profile selection
- large download gate
- resource catalog parser
- BioLab dry-run safety flags
- TenantShield missing context rejection
- backup timestamp naming

Documentation:
Generate:
- README.md
- FAQ.md
- docs/ARCHITECTURE.md
- docs/INSTALLATION.md
- docs/CAVEMAN_INSTALL.md
- docs/DMG_PACKAGING.md
- docs/BIOMEDICAL_SAFETY.md
- docs/LLM_FIT.md
- docs/WINDOWS_NATIVE_STRATEGY.md
- docs/TROUBLESHOOTING.md
- docs/DEVELOPER_GUIDE.md

Packaging:
Generate scripts:
- script/build_debug.sh
- script/build_release.sh
- script/make_icns.sh
- script/make_dmg.sh

The generated DMG workflow should be local-build ready. Do not claim Apple notarization unless signing and notarization actually run successfully.

Windows future:
Document Windows as a separate native WinUI 3 app sharing backend contracts, data model, LLM-Fit rules, resource schema, and safety copy. Do not try to reuse SwiftUI code for Windows.

Acceptance criteria:
1. The SwiftUI app builds.
2. The app opens to First Run or Dashboard.
3. Safety warning is visible.
4. LLM-Fit shows Kleiner/Optimal/Maximal.
5. Local Lite Mode works without Docker.
6. BioLab dry-run returns only demo/safety-marked results.
7. Large model downloads require explicit confirmation.
8. Tests pass or blockers are documented.
9. README, FAQ, installation docs, and DMG docs exist.
10. DMG script exists and either creates a DMG or documents the exact blocker.
11. CAVEMAN path works: non-technical Local Lite install and demo use require no Terminal commands.

Do not expand scope beyond v0.1. Prefer robust, readable, testable code over fake heavy biomedical integration.
```
