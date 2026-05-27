# Doctor Funding Pitch Summary

Status: 2026-05-27

This is a public, sanitized summary of the current doctor/gremium pitch. The original working PDF and older foundation packages are intentionally not stored in the public repository.

## One-Line Pitch

NALA-DNA-Med is a local-first, privacy-aware research-support app that helps medical and research teams organize papers, project data, molecular/protein context, hypotheses, and auditable reports without sending sensitive work to public cloud tools by default.

## Pitch Goal

In a short demo, show why a secure local Bio/DNA/AI workspace can help clinical research, literature review, and project decisions while keeping patient-data boundaries, governance, and auditability explicit.

## Clinical Pain Point

- Research ideas, papers, molecule lists, notes, and project files are scattered across tools.
- Public cloud AI is convenient, but not every question or file belongs in external systems.
- Committees and medical teams need a fast way to understand usefulness, risk, cost, responsibility, and auditability.

## What The App Is

- Research-support workspace.
- Literature and paper triage with sources.
- Project vaults for teams, data, and hypotheses.
- BioLab demo for SMILES/protein-sequence style workflows.
- Audit log, roles, TenantShield, backup/restore concept.
- Preparation for local biomedical model plugins.

## What The App Is Not

- Not a medical device.
- Not a diagnostic or treatment system.
- Not patient advice.
- Not a replacement for clinical studies, laboratory validation, review boards, or qualified medical responsibility.
- Not a production patient-data system without validation, consent, security review, and governance.

## Demo Workflow

1. Open a project with topic, team, and data room.
2. Upload papers, CSV, FASTA, SMILES, or project notes.
3. Ask research questions with source citations and warnings.
4. Run a clearly marked BioLab dry-run.
5. Export a report for expert review or committee discussion.

## BioLab Direction

The current BioLab mode is a demo/stub. Future plugin directions can include MAMMAL, RDKit, BioPython, validated internal datasets, retrieval systems, and local model runtimes. Any real biomedical result requires independent validation.

## TenantShield Direction

The app should block cross-project and cross-tenant data mixing. Retrieval, tool calls, and reports should include project context and audit events.

## Pilot Roadmap

- Week 1-2: Local Lite MVP, project model, safety boundary, first doctor-facing demo.
- Week 3-4: Optional core runtime, upload vault, audit, backup/restore.
- Week 5-6: BioLab stub plus integration plan for biomedical tooling.
- Week 7-8: Pilot report covering usefulness, risk, effort, and go/no-go.

## Operating Modes

- Local Lite: direct local app for demos and lightweight workflows.
- Core Mode: optional local services for API, database, vector search, object storage, and job processing.
- Server Mode: future Ubuntu/server deployment for teams, GPU jobs, backups, remote clients, and governed access.

## Safety Rules

- No medical decision without qualified review.
- No patient-data production use in the MVP.
- Every export must include sources and safety warnings.
- No training on user data without explicit consent.
- No unsupported cure, diagnosis, or treatment claims.

## Current Ask

Define a small, harmless research use case and use the app to test whether local AI can make medical research preparation safer, faster, and more auditable.

Suggested wording:

> We are not funding magic. We are testing whether local AI can make medical research work safer, clearer, and faster.
