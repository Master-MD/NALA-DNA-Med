# NALA-DNA-Med aPP

Native macOS research-support app concept for local-first biomedical project work.

> NALA-DNA-Med is not medical advice, not a medical device, and not validated for diagnosis, treatment, prescription, or clinical decision-making.

## Current Package

This folder contains source material, mockups, pitch documents, and a generator-ready documentation package for building a native SwiftUI macOS app.

Start here:

- [Master Generation Brief](docs/generation/NALA-DNA-Med_MASTER_GENERATION_BRIEF.md)
- [Codex / Antigravity Prompt](docs/prompts/CODEX_ANTIGRAVITY_GENERATION_PROMPT.md)
- [FAQ](docs/generation/FAQ.md)
- [Installation Guide](docs/install/INSTALLATION.md)
- [CAVEMAN Install Guide](docs/install/CAVEMAN_INSTALL.md)
- [DMG Packaging Guide](docs/install/DMG_PACKAGING.md)

## App Direction

- Native SwiftUI macOS app first.
- Local Lite Mode must work without Docker.
- CAVEMAN Install Mode: non-technical users must be able to install and start Local Lite from the DMG without terminal knowledge.
- OrbStack/Docker Core Mode is optional for heavier services.
- LLM-Fit recommends model sizes based on hardware, disk, runtime, and user preference.
- Large model downloads require explicit user confirmation.
- Windows is planned as a separate native WinUI app using the same backend contracts and documentation.

## Included Existing Assets

- App icon: `/Users/ultramacuser/Library/Mobile Documents/com~apple~CloudDocs/-DC_Consulting-/___INTERN___/*****AppEntwicklung*****/*****NALA-Bilder*****/NALA/***NALA-AppZ-IconS***/NALA-DNA-Med.png`
- Mockups: `04_login_tenant_shield.png` through `09_biolab_graph_view.png`
- Concept package: `NALA-DNA-Med-aPP_MasterPackage.zip`
- Source/data sheet: `NALA-DNA-Med_Quellenpaket.zip`
- Pitch deck/PDF: `NALA-DNA-Med_Doctor-Funding-Pitch.pptx` and `.pdf`

## Generation Goal

Use the prompt in `docs/prompts/CODEX_ANTIGRAVITY_GENERATION_PROMPT.md` to generate the app in Codex or Antigravity. The generated repository should include source code, tests, docs, README, FAQ, installation instructions, and a local DMG build workflow.

## Local Build

This workspace now contains a native SwiftUI MVP.

```bash
swift test
swift build
./script/build_and_run.sh --verify
./script/make_dmg.sh
```

Generated artifacts:

- `dist/NALA-DNA-Med.app`
- `dist/NALA-DNA-Med.dmg`

Local Lite is the default CAVEMAN path. It does not require Docker, OrbStack, Xcode, or Terminal usage for the end user once the DMG exists.
