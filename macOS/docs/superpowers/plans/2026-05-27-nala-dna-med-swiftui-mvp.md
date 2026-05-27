# NALA-DNA-Med SwiftUI MVP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build and test a native SwiftUI macOS MVP for NALA-DNA-Med with CAVEMAN Local Lite onboarding, LLM-Fit, safety-marked BioLab demo, support report, app icon, app bundle, and DMG script.

**Architecture:** SwiftPM package with a SwiftUI executable app and a reusable core library. Tests target the core services before UI wiring. Packaging scripts stage a real `.app` bundle and local DMG.

**Tech Stack:** Swift 6.3, SwiftUI, AppKit activation, XCTest, SwiftPM, macOS `iconutil`, `sips`, and `hdiutil`.

---

### Task 1: SwiftPM Skeleton And Tests

**Files:**
- Create: `Package.swift`
- Create: `Sources/NALADNAMedCore/*.swift`
- Create: `Tests/NALADNAMedCoreTests/NALADNAMedCoreTests.swift`

- [ ] Write failing XCTest coverage for LLM-Fit, download gate, BioLab demo flags, TenantShield, backup naming, and support report.
- [ ] Run `swift test` and confirm missing module/source failures.
- [ ] Implement core models and services.
- [ ] Run `swift test` and confirm tests pass.

### Task 2: Native SwiftUI App

**Files:**
- Create: `Sources/NALADNAMedApp/*.swift`

- [ ] Build a `WindowGroup` SwiftUI app with `NavigationSplitView`.
- [ ] Add CAVEMAN First Run, System Check, LLM-Fit, Dashboard, Projects, BioLab, Jobs/Audit, Resources, Settings, Backup/Restore, Support views.
- [ ] Keep safety warning visible on core screens.
- [ ] Build with `swift build`.

### Task 3: App Icon And Run Scripts

**Files:**
- Create: `script/build_and_run.sh`
- Create: `script/make_icns.sh`
- Create: `script/make_dmg.sh`
- Create: `.codex/environments/environment.toml`

- [ ] Generate `Resources/NALA-DNA-Med.icns` from the provided PNG.
- [ ] Stage `dist/NALA-DNA-Med.app` with Info.plist and icon.
- [ ] Wire Codex Run action.
- [ ] Verify app process launch with `./script/build_and_run.sh --verify`.

### Task 4: Documentation And Packaging Verification

**Files:**
- Modify: `README.md`
- Use existing: `docs/**`

- [ ] Ensure README points to generated app, scripts, and CAVEMAN path.
- [ ] Run `swift test`.
- [ ] Run `swift build`.
- [ ] Run `script/make_dmg.sh`.
- [ ] Verify DMG exists or report exact blocker.

