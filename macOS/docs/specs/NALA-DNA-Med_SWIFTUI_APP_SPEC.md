# NALA-DNA-Med SwiftUI App Spec

Stand: 2026-05-27

## Product Goal

Build a native macOS SwiftUI app for local-first biomedical research support, project vaults, LLM-fit model selection, demo BioLab workflows, auditability, and optional Core Mode services.

## Non-Goals

- No medical diagnosis.
- No treatment recommendation.
- No clinical decision support claim.
- No automatic large biomedical model download in v0.1.
- No production patient-data workflow in v0.1.

## macOS App Architecture

Use native SwiftUI:

- `WindowGroup` for main app window.
- `Settings` scene for preferences.
- `NavigationSplitView` for sidebar/detail layout.
- Toolbar actions for system check, resource refresh, backup, and Core Mode.
- `@AppStorage` for preferences.
- App-owned observable stores for projects, resources, audit events, and LLM-Fit state.

Recommended module layout:

```text
NALA-DNA-Med/
  App/
    NALADNAMedApp.swift
  Models/
    Tenant.swift
    User.swift
    Project.swift
    Document.swift
    Job.swift
    AuditEvent.swift
    ResourceCatalog.swift
    LLMFitProfile.swift
  Stores/
    AppState.swift
    ProjectStore.swift
    AuditStore.swift
    ResourceStore.swift
    SettingsStore.swift
  Services/
    SystemCheckService.swift
    LLMFitService.swift
    ResourceDownloadService.swift
    CoreModeService.swift
    BackupService.swift
    BioLabDemoService.swift
  Views/
    ContentView.swift
    SidebarView.swift
    DashboardView.swift
    FirstRunView.swift
    SystemCheckView.swift
    LLMFitView.swift
    ProjectsView.swift
    UploadCenterView.swift
    BioLabDemoView.swift
    JobsAuditView.swift
    ResourcesView.swift
    SettingsView.swift
  Support/
    Formatters.swift
    AppPaths.swift
    Constants.swift
```

## CAVEMAN Install Mode

The app must be installable and usable by non-technical users in Local Lite Mode.

Required behavior:

- DMG drag-and-drop installation.
- First Launch Wizard with safety notice, System Check, LLM-Fit, and Demo Mode.
- No Terminal requirement for normal Local Lite use.
- No Docker/OrbStack requirement for Local Lite.
- Green/yellow/red status for technical checks.
- `Copy Support Report` action.
- Human-readable error messages with problem, impact, next step, and technical detail.
- Developer-only features clearly marked as Advanced.

## Screens

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

## Visual Direction

Use NALA Black Edition:

- black / graphite / gunmetal
- emerald accent
- industrial but readable
- no audio by default
- high contrast
- dense but not cluttered
- native macOS controls where possible

Use the provided icon as the application icon.

## Data Model

Every entity should be tenant/project-aware where applicable:

```json
{
  "tenant_id": "tenant_mike",
  "user_id": "user_mike",
  "project_id": "project_biolab_demo",
  "created_at": "ISO-8601",
  "updated_at": "ISO-8601"
}
```

Initial entities:

- tenants
- users
- projects
- documents
- jobs
- audit_events
- resource_catalog_entries
- llm_fit_recommendations

## Local Lite Mode

Local Lite Mode must:

- work without Docker
- store local project metadata
- run demo BioLab outputs
- run LLM-Fit
- download only small resource catalogs automatically
- show safety disclaimers
- support backup/restore

## Core Mode

Core Mode is optional and can control:

- FastAPI
- PostgreSQL
- Qdrant
- MinIO
- Redis
- BioModel API stub

The SwiftUI app should detect Docker/OrbStack before enabling Core Mode actions.

## Resource Download Policy

First launch may fetch:

- small catalog JSON
- demo source metadata
- template prompts
- model metadata

First launch must not fetch:

- large LLM weights
- biomedical model weights
- large datasets
- unknown license resources

## Testing Requirements

Minimum generated tests:

- System check parses machine/runtime state.
- LLM-Fit returns `Kleiner`, `Optimal`, or `Maximal` from deterministic inputs.
- Large download gate blocks automatic large model pulls.
- BioLab dry-run always returns demo and safety flags.
- TenantShield rejects missing tenant/project context.
- Backup service writes timestamped archives.
- Resource catalog parser handles malformed or unavailable remote data.

## Documentation Requirements

Generated repo must include:

- README
- FAQ
- installation guide
- CAVEMAN install guide
- DMG packaging guide
- safety guide
- LLM-Fit guide
- Windows strategy
- architecture guide
- developer guide
- troubleshooting guide
