# How To Use This Repository

Status: 2026-05-27

## For A Quick Public Overview

1. Read [README.md](../README.md).
2. Review [PITCH_SUMMARY.md](PITCH_SUMMARY.md).
3. Check [WIKI_INDEX.md](WIKI_INDEX.md).
4. Open the macOS or Windows folder depending on your platform.

## For macOS Development

```bash
cd macOS
swift test
swift build
./script/build_and_run.sh --verify
./script/make_dmg.sh
```

The default DMG is universal for Apple Silicon and Intel. Generated DMGs and app bundles stay local under `macOS/dist/` and are ignored by Git.

Optional architecture-specific DMGs:

```bash
./script/make_dmg.sh arm64
./script/make_dmg.sh x86_64
```

## For Windows Development

1. Open `Windows/NalaDnaMedWin.sln` in Visual Studio 2022.
2. Read [Windows/ANTIGRAVITY_SYNC_PROMPT.md](../Windows/ANTIGRAVITY_SYNC_PROMPT.md).
3. Use [Windows/TODO_FROM_MACOS.md](../Windows/TODO_FROM_MACOS.md) for parity work.
4. Keep new parity features experimental until built and tested on Windows.

## When macOS Gets A New Feature

1. Update [FEATURE_MATRIX.md](FEATURE_MATRIX.md).
2. Run:

```bash
./tools/make-windows-sync-todo.sh origin/main
```

3. Give `Windows/ANTIGRAVITY_SYNC_PROMPT.md` and `Windows/TODO_FROM_MACOS.md` to Antigravity.
4. Port behavior into native WinUI/C# without deleting existing Windows features.

## Before Pushing

Run a privacy scan for local paths, personal e-mail addresses, credentials, API keys, generated binaries, and real health data. Then run:

```bash
git diff --check
```

Generated binaries, local source drops, real health data, API keys, and local filesystem paths must not be committed.
