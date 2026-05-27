# NALA-DNA-Med (Windows Edition)

Native WinUI 3 research-support app concept for local-first biomedical project work.

> **CRITICAL BOUNDARY:** NALA-DNA-Med is not medical advice, not a medical device, and not validated for diagnosis, treatment, prescription, or clinical decision-making. 

## Current Package

This repository contains the source code for the WinUI 3 (Windows App SDK) native client. It implements the same architecture, data models, LLM-Fit logic, and safety boundaries as the macOS version, but optimized for Windows 10/11 using Fluent Design.

## App Direction

- **Native WinUI 3 App:** Built with C# and .NET 8.
- **Local Lite Mode:** Must work without WSL2 or Docker. Data is stored locally via SQLite.
- **CAVEMAN Install Mode:** Non-technical users can install the `.exe` or `.msix` and use Local Lite without terminal knowledge.
- **LLM-Fit Advisor:** Detects Windows hardware (RAM, DXGI, CPU) to recommend the right local AI model.
- **Core Mode:** Optional, relies on local containerization for heavier backend components (FastAPI, Qdrant, PostgreSQL).

## Parity With macOS

Windows should follow the shared root docs instead of duplicating product decisions:

- [Feature Matrix](../docs/FEATURE_MATRIX.md)
- [Feature Parity Workflow](../docs/FEATURE_PARITY_WORKFLOW.md)
- [Roadmap](../docs/ROADMAP.md)
- [Responsible Use Policy Draft](../docs/RESPONSIBLE_USE_POLICY.md)
- [Legal and Governance Draft](../docs/LEGAL_AND_GOVERNANCE_DRAFT.md)

When macOS receives a feature, run the sync workflow and hand `Windows/ANTIGRAVITY_SYNC_PROMPT.md` plus `Windows/TODO_FROM_MACOS.md` to Antigravity. Port behavior into native WinUI/C# patterns; do not overwrite existing Windows features.

## Current Windows TODO

- Port macOS Model Manager Weblink download and File Explorer import.
- Align LLM-Fit free-disk/runtime checks with macOS.
- Add Support Report copy/export.
- Keep new parity features experimental until built and tested on Windows.

## Getting Started

Open `NalaDnaMedWin.sln` in Visual Studio 2022. 

See the `/docs/` folder for installation and architecture guidelines.
