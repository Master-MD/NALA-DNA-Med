# Troubleshooting

## Local Lite

Use `Kleiner` and Demo Mode when disk, network, Ollama, Docker, or OrbStack checks are yellow or red.

## Developer Build

Run:

```bash
swift test
swift build
./script/build_and_run.sh --verify
./script/make_dmg.sh
```

## Visual Verification

If automated screenshots fail, grant screen recording permission to the terminal/Codex host app or verify the launched `NALA-DNA-Med` process manually.
