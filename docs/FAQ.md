# NALA-DNA-Med FAQ

Status: 2026-05-27

## Is this app medical advice?

No. NALA-DNA-Med is research-support software. It is not medical advice, not a medical device, and not validated for diagnosis, treatment, prescription, or clinical decision-making.

## Can it find medicines?

It can help organize sources, hypotheses, candidate lists, and model-assisted research workflows. It must not claim that it has found a safe or effective medicine. Any therapeutic direction requires laboratory validation, clinical trials, regulatory review where required, and qualified medical responsibility.

## Why local-first?

Biomedical research files can be sensitive. Local-first workflows reduce unnecessary exposure to public cloud services and make it easier to keep audit logs, project boundaries, and explicit user control.

## What is TenantShield?

TenantShield is the project boundary concept: retrieval, tools, jobs, reports, and audit events should always know which tenant/project they belong to. Cross-project data mixing should be blocked.

## What is LLM-Fit?

LLM-Fit recommends a local model profile based on the actual computer, free disk space, available runtimes, and user preference. Profiles are `Kleiner`, `Optimal`, and `Maximal`.

## Are the old foundation PDFs and ZIPs public in GitHub?

No. Old foundation binaries were removed from the public repository. The public repo keeps curated summaries and current source/docs only.

## Where is the pitch content?

See [PITCH_SUMMARY.md](PITCH_SUMMARY.md).

## Where are screenshots?

Current public app previews are in [docs/assets/screenshots](assets/screenshots/). Older mockups are not stored in the public repository.

## Can Windows stay aligned with macOS?

Yes. Use [FEATURE_MATRIX.md](FEATURE_MATRIX.md), [FEATURE_PARITY_WORKFLOW.md](FEATURE_PARITY_WORKFLOW.md), [Windows/TODO_FROM_MACOS.md](../Windows/TODO_FROM_MACOS.md), and [Windows/ANTIGRAVITY_SYNC_PROMPT.md](../Windows/ANTIGRAVITY_SYNC_PROMPT.md).

## Can this become a server product?

Yes, later. The current plan is local macOS and Windows demos first. The future server plan is described in [SERVER_MULTIUSER_PLAN.md](SERVER_MULTIUSER_PLAN.md).

## Can real patient data be uploaded?

Not in the MVP. Real patient data requires consent, privacy review, security review, governance, access control, audit logging, and legal compliance.

## Is this open source?

The intended direction is open source for public benefit. The exact license/foundation setup still needs legal review because open-source distribution and commercial profit-sharing/foundation funding are separate legal questions.
