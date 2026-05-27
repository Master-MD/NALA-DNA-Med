# DMG Packaging Guide

Stand: 2026-05-27

## Goal

Produce a local macOS distributable:

- `NALA-DNA-Med.app`
- `NALA-DNA-Med.dmg`
- App icon generated from `NALA-DNA-Med.png`
- README/FAQ included in the repository and optionally linked from the DMG background or installer notes

## Icon Source

Use the committed app icon:

```text
macOS/Resources/NALA-DNA-Med.icns
```

If the icon must be regenerated from a private PNG source, set `NALA_ICON_SOURCE` locally and run:

- 16x16
- 32x32
- 128x128
- 256x256
- 512x512
- 1024x1024

## Local Debug Build

Notarization is not required for ordinary local debug runs. A local DMG can be created for testing before signing/notarization.

Suggested generated script:

```bash
script/build_release.sh
script/make_dmg.sh
```

## Distribution Readiness

Before claiming a release build:

1. Validate app bundle structure.
2. Confirm nested helper tools or bundled binaries are signed or clearly marked dev-only.
3. Confirm hardened runtime settings if signing for distribution.
4. Confirm entitlements match actual needs.
5. Run app from `/Applications`, not only from Xcode.
6. Re-run first-launch flow from a clean app data directory.

## Notarization Note

Notarization requires Apple Developer signing credentials. The generated project should provide instructions and validation commands, but local generation must not claim notarization unless it actually completed.
