# NALA-DNA-Med FAQ

Stand: 2026-05-27

## Is NALA-DNA-Med a diagnostic or treatment app?

No. It is a local research-support, documentation, screening, and hypothesis-generation tool. It must not claim to diagnose, prescribe, treat, or replace medical review.

## Why a native SwiftUI Mac app?

The requested primary deliverable is a real macOS application with app icon, Dock presence, native navigation, settings, and DMG packaging. SwiftUI is the best fit for that Mac-first experience.

## Does Local Lite Mode need Docker?

No. Local Lite Mode must work without Docker or OrbStack. It should provide the UI, project vaults, demo BioLab workflows, LLM-Fit recommendations, resource catalog download, and local test data.

## What does CAVEMAN Install mean?

It means normal users can install and run Local Lite without Terminal knowledge. The path is DMG öffnen, App in Applications ziehen, starten, Safety Notice lesen, System Check laufen lassen, `Kleiner` wählen, Demo Mode nutzen. Problems must be explained with green/yellow/red status and clear next steps.

## What is Core Mode?

Core Mode is an optional OrbStack/Docker runtime that can run heavier services such as FastAPI, PostgreSQL, Qdrant, MinIO, Redis, and a BioModel API stub. It is for reproducible multi-service operation, not required for the first demo.

## What is LLM-Fit?

LLM-Fit is the app's model advisor. It scans hardware, free disk, installed runtimes such as Ollama and Docker, and user preference. It then recommends one of three profiles: `Kleiner`, `Optimal`, or `Maximal`.

## Will the app automatically download big models?

No. On first launch, it may download small catalogs, demo metadata, templates, and lightweight resources. Large LLM or biomedical model downloads must require explicit confirmation.

## How do I add a model without Terminal?

Open `Resources`, use `Model Manager`, then either paste a trusted `https://` Weblink and click `Download Weblink`, or click `Choose Local Model File...` and select a model from Finder or an external drive. Supported file endings are `.gguf`, `.safetensors`, `.bin`, `.mlmodel`, and `.mlpackage`.

## Which models are already downloaded on this workstation?

On 2026-05-27, the local Ollama cache was prepared with `qwen3:4b` and `qwen3-embedding:0.6b`. A pre-existing larger model, `hf.co/Jiunsong/supergemma4-26b-uncensored-gguf-v2:latest`, was also present. These model weights live in the local Ollama cache and are not embedded into the small DMG.

## Which model should the current Mac use?

The current observed machine is an Apple M4 Max MacBook Pro with 64 GB unified memory and a 40-core GPU, but only about 35 GB free disk space at inspection time. That means the model advisor should recommend a small or balanced setup until more disk space is available.

## Can it use Hugging Face and GitHub?

Yes. The app should use Hugging Face, GitHub, and Ollama as sources for model catalogs, resource metadata, demo templates, and future plugins. It should verify source URLs and file sizes before download.

## Does it include MAMMAL, RDKit, or BioPython in v0.1?

No. v0.1 should include integration notes and plugin placeholders. Heavy biomedical dependencies and model weights are future opt-in work.

## What does TenantShield do?

TenantShield prevents cross-tenant/project data mixing. Any document, job, vector, or audit event must include tenant and project context where applicable. No retrieval or tool call may run without the required context.

## Can multiple users use it?

The MVP should be multi-user-ready in its data model and UI, but not exposed as a clinical production multi-user system. Real production access requires authentication, role management, security review, and validation.

## Can this become a Windows app?

Yes, but not from the same SwiftUI UI code. The Windows plan is a separate native WinUI app that reuses the same backend/API contracts, LLM-Fit decision rules, resource catalog format, safety copy, and documentation.

## What should be generated first?

Generate the native macOS SwiftUI app scaffold, local data model, first-run resource flow, LLM-Fit advisor, safety banners, demo screens, docs, tests, and DMG packaging scripts. Keep Core Mode as a controlled optional runtime.
