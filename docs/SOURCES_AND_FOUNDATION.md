# Sources and Foundation Archive

Status: 2026-05-27

## Public Repository Policy

The public GitHub repository stores current source code, current documentation, current app previews, and curated summaries.

It does not store old foundation ZIPs, pitch PDFs, raw local source drops, local `.webloc` files, generated DMGs, generated `.app` bundles, personal filesystem paths, API keys, or health data.

## Current Public Source Areas

- `README.md`
  - Public project overview.
- `docs/PITCH_SUMMARY.md`
  - Sanitized summary of the doctor/gremium pitch.
- `docs/assets/screenshots/`
  - Current public app previews.
- `macOS/`
  - Native SwiftUI app source and macOS docs.
- `Windows/`
  - Native WinUI app source and Windows docs.
- `docs/`
  - Shared project wiki, roadmap, safety, governance, references, and parity workflow.

## Local-Only Foundation Material

Original PDFs, slide decks, ZIP packages, and old mockups may exist in local working folders, but they should be treated as private source material unless reviewed and intentionally converted into public markdown.

If useful content from a private source file should be public, summarize it into a document such as [PITCH_SUMMARY.md](PITCH_SUMMARY.md) and remove private paths, personal contact details, API keys, raw clinical data, and obsolete claims.

## Evidence Hygiene

The foundation material explains the idea and project direction. It should not be treated as clinical proof.

When adding biomedical claims, add primary scientific references where possible:

- paper title
- authors
- DOI or PubMed URL
- publication date
- what the paper actually supports
- what it does not support

Avoid converting speculative product ideas into medical promises.
