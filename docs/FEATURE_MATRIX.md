# Feature Matrix

Status: 2026-05-27

This matrix is the source-of-truth checklist for keeping macOS, Windows, and later mobile/server clients aligned. New features should enter here before they are ported.

| Feature | macOS | Windows | Stability | Port Notes |
|---|---:|---:|---|---|
| CAVEMAN Local Lite first run | Implemented | Implemented | Experimental | Both platforms support full wizard copy and safety status cards. |
| Safety boundary banner | Implemented | Implemented | Experimental | Wording is identical and highly visible across platforms. |
| LLM-Fit profile recommendation | Implemented | Implemented | Experimental | WinUI 3 automatically checks and recommends Kleiner, Optimal, or Maximal. |
| Model Manager Weblink download | Implemented | Implemented | Experimental | WinUI 3 features URL validation and confirmation thresholds for large downloads. |
| Finder/File Explorer model import | Implemented | Implemented | Experimental | WinUI 3 supports .gguf, .safetensors, .bin, .mlmodel, and .mlpackage filters. |
| BioLab dry-run demo | Implemented | Implemented | Experimental | Fully implemented with strict "Not Medical Advice" banners. |
| Support report | Implemented | Implemented | Experimental | Copies clipboard-friendly system hardware trace. |
| Public wiki docs | Implemented | Shared root docs | Draft | Use root `docs/` as cross-platform wiki seed. |
| Responsible use agreement | Draft docs | Implemented | Draft | Added via ToggleSwitch inside Settings page. |
| Server / multi-user plan | Draft docs | Shared root docs | Future | Do not implement until local demos are stable. |
| Runtime screenshots | macOS preview | Windows preview | Draft | Replace SVG previews with verified runtime screenshots when available. |

## Feature Lifecycle

- `Draft`: idea exists in docs only.
- `Experimental`: implemented behind clear non-clinical language or demo controls.
- `Stable`: tested on the target platform and documented for normal users.
- `Deprecated`: kept only for compatibility or migration.

## Rule

No port should overwrite existing platform-specific code blindly. Porting means mapping the feature behavior to native platform patterns and preserving current working features.
