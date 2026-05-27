# Architecture

NALA-DNA-Med is implemented as a SwiftPM-based native SwiftUI macOS app with a reusable core library.

## Modules

- `NALADNAMedCore`: testable model and service logic for System Check, LLM-Fit, download gating, BioLab demo output, TenantShield, backup naming, and support reports.
- `NALADNAMedApp`: native SwiftUI app using `WindowGroup`, `Settings`, `NavigationSplitView`, CAVEMAN onboarding, and Local Lite demo screens.

## Packaging

The scripts in `script/` stage `dist/NALA-DNA-Med.app`, generate the icon from the provided PNG, and create `dist/NALA-DNA-Med.dmg`.
