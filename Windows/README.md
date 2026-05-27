# NALA-DNA-Med (Windows Edition)

Native WinUI 3 research-support app concept for local-first biomedical project work.

> **CRITICAL BOUNDARY:** NALA-DNA-Med is not medical advice, not a medical device, and not validated for diagnosis, treatment, prescription, or clinical decision-making. 

## Current Package

This repository contains the source code for the WinUI 3 (Windows App SDK) native client. It implements the same architecture, data models, LLM-Fit logic, and safety boundaries as the macOS version, but optimized for Windows 10/11 using Fluent Design.

## App Direction

- **Native WinUI 3 App:** Built with C# and .NET 8.
- **Local Lite Mode:** Works fully out-of-the-box without WSL2, Docker, or terminal access. Data persists locally via a lightweight SQLite database.
- **CAVEMAN Install Mode:** Non-technical users can install the `.zip` / `.exe` and run the app in Local Lite mode with zero terminal commands or configuration.
- **LLM-Fit Advisor:** Automatically scans Windows hardware capabilities (CPU, RAM, disk space, and DXGI DirectX GPU VRAM) to recommend the optimal local model profile (`Kleiner`, `Optimal`, or `Maximal`).
- **Integrated Biomedical Sources:** The "Resources" tab hosts a curated catalog of primary literature, database reference models (ClinVar, dbSNP, UniProt, ChEMBL), and the core research vision (disease cures vs. symptom management).
- **Core Mode:** Optional, relies on local containerization for heavier backend components (FastAPI, Qdrant, PostgreSQL).

## Monorepo Feature Parity Status

All 8 core pages have been fully ported to the WinUI 3 architecture:
- **Dashboard:** Modern, high-performance Fluent overview showing active local vaults and resources.
- **LLM-Fit Advisor:** Scans hardware capabilities for custom local profile recommendation.
- **Projects / Vaults:** Secure, tenant-isolated workspaces with full SQLite persistence.
- **Upload Center:** Safe, local drag-and-drop ingestion placeholder.
- **BioLab Demo:** Fully sandboxed dry-run simulator with strict safety banners.
- **Jobs / Audit:** Audit-friendly trace log tracking all database operations and support report generation.
- **Resources:** Hosts the local Model Manager (Weblink validator + File Explorer import) and the **integrated Biomedical Sources catalog**.
- **Settings:** Manages safety agreement toggles and custom local database exports.

## How to Get the Compiled Windows Binary (.exe / .zip)

Since compiling a native Windows WinUI 3 C# application is not natively supported on a macOS environment, the monorepo is equipped with an automated **GitHub Actions CI/CD Pipeline**:
1. Every time changes are pushed to GitHub, a free Microsoft Windows builder automatically compiles, publishes, and signs the application.
2. Go to your **GitHub Actions** tab in [Master-MD/NALA-DNA-Med](https://github.com/Master-MD/NALA-DNA-Med).
3. Select the latest run and scroll down to the **Artifacts** section.
4. Download the `NALA-DNA-Med-Windows-x64.zip` bundle, extract it, and double-click `NalaDnaMedWin.exe` to run the app instantly!

## Getting Started for Developers

Open `NalaDnaMedWin.sln` in Visual Studio 2022. 

See the `/docs/` folder for installation and architecture guidelines.
