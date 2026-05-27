# Installation Guide

Stand: 2026-05-27

## User Installation

1. Download or build `NALA-DNA-Med.dmg`.
2. Open the DMG.
3. Drag `NALA-DNA-Med.app` into `/Applications`.
4. Start the app.
5. On first launch, review the safety notice.
6. Let the app run System Check and LLM-Fit.
7. Choose one model profile:
   - `Kleiner`
   - `Optimal`
   - `Maximal`
8. Confirm any large downloads before they start.

## Add Models Without Terminal

Use `Resources > Model Manager`:

1. For a Weblink, paste a trusted `https://` model URL, click `Check Weblink`, then click `Download Weblink`.
2. For a file on disk, click `Choose Local Model File...`, select a `.gguf`, `.safetensors`, `.bin`, `.mlmodel`, or `.mlpackage` from Finder or an external drive, then click `Import Selected File`.
3. Wait until the status turns green.

The app stores imported/downloaded model files in `~/Library/Application Support/NALA-DNA-Med/Models`.

## CAVEMAN Installation Requirement

Normal Local Lite installation must be possible without Terminal, Docker, Python, Git, Xcode, or developer knowledge.

The generated app must support this simple path:

1. Open DMG.
2. Drag app into Applications.
3. Start app.
4. Read safety notice.
5. Let System Check run.
6. Choose `Kleiner`.
7. Use Demo Mode.

If something is missing, the app must show green/yellow/red status and a clear next step. It must never show only raw developer errors.

## Developer Prerequisites

For macOS generation and local builds:

- macOS on Apple Silicon recommended.
- Xcode installed.
- Swift toolchain available through Xcode.
- Ollama optional but recommended for local LLM workflows.
- Docker or OrbStack optional for Core Mode.
- Git recommended for repository management.

## Local Lite Mode

Local Lite Mode must not require Docker. It should support:

- System Check
- Project creation
- Local vault metadata
- Upload placeholders
- BioLab dry-run
- LLM-Fit recommendation
- Resource catalog download
- Audit-log simulation
- Backup/restore of app-local configuration

## Core Mode

Core Mode should use Docker-compatible services:

- FastAPI backend
- PostgreSQL
- Qdrant
- MinIO
- Redis
- BioModel API stub

The app should detect whether Docker or OrbStack is installed before enabling Core Mode controls.

## First-Run Resource Policy

Allowed automatically on first run:

- Small JSON model/resource catalogs.
- App templates and demo prompts.
- Citation/source metadata.
- Lightweight embedding/model metadata.

Requires explicit confirmation:

- LLM weights.
- Biomedical model weights.
- Large datasets.
- Anything over the configured download threshold.
- Any resource from an unverified URL.

## Troubleshooting

If downloads fail:

- Check network connectivity.
- Check free disk space.
- Open Settings > Resources and retry.
- Use Local Lite Demo Mode without model downloads.

If Core Mode fails:

- Confirm Docker or OrbStack is installed.
- Confirm ports are available.
- Open System Check.
- Use Local Lite Mode until Core services pass checks.

If the user is non-technical:

- Use `Kleiner`.
- Use Local Lite Demo Mode.
- Click `Copy Support Report`.
- Send the report to a helper instead of trying random Terminal commands.
