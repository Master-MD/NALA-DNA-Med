# Windows TODO From macOS

Status: 2026-05-27

This file is the handoff list for Antigravity after recent macOS work.

## Must Port Next

- Model Manager:
  - Weblink validation and download action.
  - File Explorer import for local model files.
  - Supported extensions: `.gguf`, `.safetensors`, `.bin`, `.mlmodel`, `.mlpackage`.
  - Store imported/downloaded files in a Windows app data model folder.
  - Show CAVEMAN status format: `Status`, `Problem`, `Impact`, `Next step`, `Technical detail`.
- LLM-Fit:
  - Align free disk and runtime checks with macOS behavior.
  - Keep `Kleiner`, `Optimal`, `Maximal`.
- Support Report:
  - Add copy/export support report for non-technical helpers.
- Docs:
  - Keep Windows docs aligned with root docs and macOS safety language.
  - Link to `docs/PITCH_SUMMARY.md`, `docs/FAQ.md`, `docs/HOWTO.md`, and `docs/SOURCES_AND_FOUNDATION.md`.
  - Do not re-add old source drops, generated app artifacts, private PDFs/ZIPs, local filesystem paths, personal e-mail addresses, API keys, secrets, or real health data.
  - Before committing, confirm that `docs/fundamentals/`, `macOS/dist/`, old pitch/source ZIPs, and obsolete screenshot dumps are not tracked by Git.
  - Run a privacy scan before committing Windows changes.

## Experimental First

These features should be labeled experimental until tested on a Windows machine:

- Model download/import.
- Any local LLM runtime connection.
- BioLab workflow expansion.
- Server sync or remote vault support.

## Later

- Runtime Windows screenshots.
- `.msix` or `.exe` CAVEMAN installer.
- Server login and encrypted vault sync.
- Android/iOS light client planning.
