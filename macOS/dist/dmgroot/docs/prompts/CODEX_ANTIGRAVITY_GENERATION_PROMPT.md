# Codex / Antigravity Generation Prompt

Use this prompt in Codex or Antigravity to generate the actual app.

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
