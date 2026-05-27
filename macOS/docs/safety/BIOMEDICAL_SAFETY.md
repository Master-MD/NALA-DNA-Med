# Biomedical Safety Rules

Stand: 2026-05-27

## Positioning

NALA-DNA-Med is a research-support and hypothesis-generation tool. It is not a medical device and must not be presented as one.

## Mandatory Visible Notice

Every main workflow must make this clear:

```text
This system is not medical advice and is not validated for diagnosis or treatment.
```

German UI text:

```text
Dieses System ist keine medizinische Beratung und nicht fuer Diagnose oder Therapie validiert.
```

## Forbidden Claims

The app must not claim:

- It discovers real medication.
- It diagnoses patients.
- It approves treatment.
- It replaces doctors, laboratory work, review boards, or regulatory validation.
- It safely processes patient data in production without approval.

## Allowed Language

Use:

- research support
- education/demo
- literature triage
- project vault
- screening assistance
- hypothesis generation
- dry-run
- low confidence demo output

## BioLab v0.1 Rules

All BioLab results must include:

- `demo_mode: true`
- `not_medical_advice: true`
- `confidence: low`
- warnings
- no therapeutic recommendation
- no real efficacy claim

## TenantShield Rules

No data operation may run without the required context:

- tenant_id
- user_id where applicable
- project_id where applicable
- audit event where relevant

No RAG retrieval may run without tenant and project filters.

## Patient Data

The MVP must default to no patient-data production use. If sample data is needed, use synthetic or public demo data only.

