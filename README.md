# NALA-DNA-Med

Native, local-first biomedical research-support software for macOS and Windows.

> **Critical boundary:** NALA-DNA-Med is not medical advice, not a medical device, and is not validated for diagnosis, treatment, prescription, or clinical decision-making.

## Mission

NALA-DNA-Med exists to give researchers, doctors, patient advocates, builders, and technically curious domain experts a transparent starting point for biomedical hypothesis work. The project is motivated by a simple frustration: many treatments reduce symptoms while still creating heavy side-effect burdens, long-term dependency, or quality-of-life tradeoffs.

This software does not claim to solve that problem by itself. Its goal is to provide a practical open foundation where people can organize evidence, explore molecular and biological hypotheses, inspect risks, compare ideas, and build local AI-assisted workflows without handing sensitive research data to a cloud service by default.

## Kurzfassung

NALA-DNA-Med soll ein offener Grundstein fuer lokale biomedizinische Forschung werden: nicht als Heilversprechen, sondern als Werkzeug, um Ideen, Quellen, Molekuel-/Protein-Daten, Nebenwirkungsfragen und regenerative Forschungsansaetze sauberer zusammenzubringen.

## Structure

- `macOS/`: Native SwiftUI macOS app with CAVEMAN install path, LLM-Fit, model import, safety boundary, docs, and DMG workflow.
- `Windows/`: Native WinUI 3 / Windows App SDK client created with the same product direction and LLM-Fit concept.
- `fundamentals/`: Original concept packages, pitch material, screenshots, source/data bundle, and early app mockups.
- `docs/`: Cross-platform project vision, source archive notes, safety framing, and public-facing project story.

## Core Ideas

- **Local-first:** sensitive biomedical project work should run locally by default.
- **CAVEMAN install:** non-technical users must be able to install and start without Terminal, Docker, Git, or developer knowledge.
- **LLM-Fit:** the app recommends smaller, optimal, or maximal local model setups based on the actual computer and free disk space.
- **TenantShield:** project and tenant context should prevent accidental data mixing.
- **Explicit safety boundary:** research support only; no diagnosis or treatment claims.
- **Open foundation:** the repository should expose the idea, sources, and implementation direction so other people can build on it.

## Current Apps

### macOS

The macOS app is a SwiftUI package in `macOS/`.

```bash
cd macOS
swift test
swift build
./script/build_and_run.sh --verify
./script/make_dmg.sh
```

The generated DMG is `macOS/dist/NALA-DNA-Med.dmg`.

### Windows

The Windows app is in `Windows/` and uses WinUI 3 / Windows App SDK.

The Windows version is intentionally kept in this repository. Do not remove or overwrite it when working on macOS docs or packaging.

## Fundamentals

The original project foundation is preserved in `fundamentals/`:

- pre-app idea archives
- pitch deck and pitch PDF
- source/data package and PDF
- early UI screenshots
- repository link artifact

Start with [docs/PROJECT_VISION.md](docs/PROJECT_VISION.md) and [fundamentals/README.md](fundamentals/README.md).

## Public Position

This project is allowed to be ambitious, but it must remain honest:

- It can help organize and explore biomedical research hypotheses.
- It can help compare sources, risks, and possible directions.
- It can help programmers and domain experts collaborate.
- It cannot claim to cure cancer, autoimmune disease, eye disease, organ damage, or any other condition.
- Any real therapeutic discovery requires laboratory validation, clinical trials, regulatory review, and medical responsibility.
