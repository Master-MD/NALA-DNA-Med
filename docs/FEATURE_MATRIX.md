# Feature Matrix

Status: 2026-05-27

This matrix is the source-of-truth checklist for keeping macOS, Windows, and later mobile/server clients aligned. New features should enter here before they are ported.

| Feature | macOS | Windows | Stability | Port Notes |
|---|---:|---:|---|---|
| CAVEMAN Local Lite first run | Implemented | Partial | Experimental | Windows needs the same first-run wizard copy and status cards. |
| Safety boundary banner | Implemented | Implemented | Experimental | Keep wording identical across platforms. |
| LLM-Fit profile recommendation | Implemented | Partial | Experimental | Windows has UI/service basics; align free-disk/runtime checks with macOS. |
| Model Manager Weblink download | Implemented | Missing | Experimental | Port as a guarded flow with URL validation, size warning, progress, and cancel/retry. |
| Finder/File Explorer model import | Implemented | Missing | Experimental | Windows should support `.gguf`, `.safetensors`, `.bin`, `.mlmodel`, `.mlpackage` equivalents where relevant. |
| BioLab dry-run demo | Implemented | Partial | Experimental | Keep demo-only language and safety flags. |
| Support report | Implemented | Missing | Experimental | Add copy/export report for non-technical support. |
| Public wiki docs | Implemented | Shared root docs | Draft | Use root `docs/` as cross-platform wiki seed. |
| Responsible use agreement | Draft docs | Missing in UI | Draft | Add to first-run flow after legal review. |
| Server / multi-user plan | Draft docs | Shared root docs | Future | Do not implement until local demos are stable. |
| Runtime screenshots | macOS preview | Windows preview | Draft | Replace SVG previews with verified runtime screenshots when available. |

## Feature Lifecycle

- `Draft`: idea exists in docs only.
- `Experimental`: implemented behind clear non-clinical language or demo controls.
- `Stable`: tested on the target platform and documented for normal users.
- `Deprecated`: kept only for compatibility or migration.

## Rule

No port should overwrite existing platform-specific code blindly. Porting means mapping the feature behavior to native platform patterns and preserving current working features.
