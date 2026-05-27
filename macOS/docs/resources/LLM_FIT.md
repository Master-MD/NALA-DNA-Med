# LLM-Fit Advisor

Stand: 2026-05-27

## Purpose

LLM-Fit chooses a reasonable local AI setup for the current machine without forcing the user into a large download.

## Inputs

The app should detect:

- macOS version
- CPU architecture
- chip name where available
- unified memory
- GPU/Metal support
- free disk space
- Ollama availability
- Docker/OrbStack availability
- existing local models
- network availability
- user preference: `Kleiner`, `Optimal`, `Maximal`

## Current Observed Machine Example

Observed on 2026-05-27:

- MacBook Pro
- Apple M4 Max
- 16 CPU cores
- 40 GPU cores
- 64 GB unified memory
- Ollama installed
- Docker installed
- approximately 35 GB free disk at inspection time

Recommendation for that state:

- Default to `Kleiner` or conservative `Optimal` because disk is tight.
- Do not automatically pull large 30B+ models.
- Prompt the user to free disk space before `Maximal`.

## Profile Behavior

### Kleiner

Use when:

- free disk is low
- user wants quick demo
- CPU/GPU capability is unknown

Behavior:

- small chat model
- small embedding model
- minimal local cache
- fastest setup

### Optimal

Use when:

- machine has strong Apple Silicon or GPU support
- enough disk is available
- user wants good quality without excessive download size

Behavior:

- balanced chat model
- stronger embedding model
- enough context for project Q&A
- still avoids large biomedical weights

### Maximal

Use when:

- user explicitly requests the largest feasible setup
- disk and memory checks pass
- download size is confirmed

Behavior:

- larger local LLM
- larger embedding model
- optional reranker
- long-context configuration where supported

## Source Strategy

Use current catalogs at generation/runtime:

- Ollama model library
- Hugging Face model pages
- GitHub plugin repositories

The generated app should treat model catalogs as dynamic. It should refresh metadata and not hardcode outdated model availability.

## Download Gate

Before downloading a large model, show:

- model name
- source
- license if known
- estimated size
- disk available
- expected runtime
- cancel option
- confirmation button

