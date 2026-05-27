# Windows Native Strategy

Stand: 2026-05-27

## Decision

Because the primary app is native SwiftUI, the Windows version must be a separate native client rather than a direct port of the UI code.

## Recommended Windows Stack

- WinUI 3
- Windows App SDK
- C#/.NET
- Fluent styling
- Packaged or unpackaged deployment based on final distribution needs

## What Should Be Shared

The Windows app should share:

- API contracts
- data model concepts
- LLM-Fit decision rules
- resource catalog format
- safety text
- FAQ and documentation
- Core Mode service stack
- BioLab dry-run semantics
- TenantShield rules

## What Is Separate

The Windows app should implement separately:

- UI shell
- navigation
- windowing
- native settings
- installer/MSIX or EXE packaging
- Windows-specific system checks

## Windows Screens

Mirror the macOS functional screens:

- First Run / Safety
- System Check
- LLM-Fit
- Dashboard
- Projects
- Upload Center
- BioLab Demo
- Jobs
- Audit Log
- Resources
- Settings
- Backup/Restore

## Generation Prompt Rule

Do not ask a Windows generator to reuse SwiftUI code. Ask it to reuse the contracts and documentation.

