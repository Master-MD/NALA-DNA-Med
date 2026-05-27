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

## Getting Started

Open `NalaDnaMedWin.sln` in Visual Studio 2022. 

See the `/docs/` folder for installation and architecture guidelines.
