# Server and Multi-User Plan

Status: 2026-05-27

## Purpose

The server edition should let teams research together while keeping sensitive data separated, auditable, and access-controlled. It should run on Ubuntu and expose APIs used by light clients on macOS, Windows, iOS, Android, and web.

## Architecture Sketch

- Ubuntu server host.
- API backend for projects, vaults, users, audit logs, and job orchestration.
- PostgreSQL for relational metadata.
- Object storage for files.
- Vector index for retrieval over permitted vault content.
- Optional worker nodes for model inference, OCR, extraction, and research automation.
- Client apps remain thin and local-first where possible.

## Data Vaults

Vaults should support:

- project-level access control
- role-based permissions
- file-level metadata
- immutable source snapshots
- audit logs for reads, writes, exports, and AI retrieval
- encryption at rest
- backup/restore
- retention rules

## Anonymization and Pseudonymization

Use the terms carefully:

- **Anonymized public data**: no reasonable path back to a person. Suitable for public wiki or student examples.
- **Pseudonymized restricted data**: identifiers are separated, but an authorized clinical gatekeeper can re-identify when legally and ethically permitted.

Doctor notification requires pseudonymization, consent, and governance. It is not compatible with fully anonymous public data.

## Doctor Notification Concept

A safe future workflow could be:

1. A restricted research workflow finds a possible match or useful hypothesis for a patient-like profile.
2. The system records evidence, uncertainty, source citations, and contraindication warnings.
3. A qualified reviewer checks the result.
4. If consent and legal basis exist, an authorized clinical gatekeeper re-identifies the patient.
5. The treating physician is notified with a research-support report.
6. The physician and patient decide what to do outside the software.

The app must not contact patients directly, prescribe, diagnose, or recommend treatment.

## Governance Requirements

- consent management
- medical/legal review for real deployments
- incident logging
- export controls
- access review
- data processing agreements where required
- regional compliance review before use with real patient data
