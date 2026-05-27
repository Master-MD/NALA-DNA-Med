# Roadmap

Status: 2026-05-27

NALA-DNA-Med should grow in a controlled sequence: local apps first, then source-backed research workflows, then an optional multi-user server. The project should stay explicit that every result is a research hypothesis until independently validated.

## Near-Term

- Improve macOS and Windows install flows.
- Add real runtime screenshots for both platforms.
- Add a source-backed public wiki under `docs/wiki/`.
- Expand Model Manager to support trusted model catalogs, checksums, license metadata, and interrupted-download resume.
- Add local project vault search over PDFs, notes, and source packages.
- Use `docs/FEATURE_MATRIX.md` and `Windows/TODO_FROM_MACOS.md` as the Mac-to-Windows feature parity workflow.
- Draft and review the first-run responsible-use agreement before enabling real clinical uploads.

## Research Automation Ideas

- Evaluate an `autoresearch`-style loop for small, bounded biomedical workflow experiments: a research agent proposes one change, runs a fixed-budget test, records the metric, and keeps or discards the change.
- Keep the loop limited to software workflow experiments, retrieval quality, source ranking, and model-pipeline tuning. It must not autonomously make clinical claims.
- Add experiment logs, reproducibility metadata, and human approval gates before anything becomes public.

## Memory and Knowledge Base Ideas

- Evaluate a MemPalace-style local memory layer for preserving verbatim project discussions, source notes, and research decisions.
- Evaluate an LLM Wiki-style layer where immutable raw sources feed maintained markdown pages, concept pages, index files, and contradiction logs.
- Prefer local-first ChromaDB/SQLite-style storage for Local Lite; use PostgreSQL/Qdrant only for the server version.

## Server / Multi-User Version

- Build an Ubuntu server edition with API services, project workspaces, data vaults, audit logs, and remote clients.
- Support light clients for macOS, Windows, iOS, Android, and web.
- Add role-based access control for project owners, researchers, students, reviewers, and clinical contacts.
- Separate public knowledge from restricted patient/project vaults.
- Use pseudonymization for clinical collaboration workflows where an authorized doctor may need to re-identify a patient.
- Use true anonymization only for public datasets where no re-identification path is allowed.
- Add consent, access logs, encryption at rest, backup/restore, and admin review workflows before any real patient data is accepted.

## Public Wiki / Education

- Create a public wiki for project concepts, reviewed sources, non-sensitive methods, student exercises, and reproducible demo workflows.
- Never publish patient data, private vault contents, or identifiable clinical case information.
- Let public wiki pages cite source documents and clearly label speculation, evidence, and open questions.

## Clinical Safety Gate

- Add a consent-based doctor notification workflow only for server deployments that are explicitly configured for clinical collaboration.
- A possible flow: pseudonymized research match -> authorized clinical gatekeeper review -> treating physician notification -> patient/doctor decision.
- Do not automate patient contact, diagnosis, treatment recommendation, or medication advice.
