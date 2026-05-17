# Revoke Probe

> Local-first scanner — see what AI coding agents can read on your dev machine.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-macOS%20|%20Linux%20|%20Windows-blue)]()
[![Status](https://img.shields.io/badge/status-v0.1.0-green)]()

Cursor, Claude Code, Cline, Aider, Copilot, and MCP servers running on your
machine inherit your user's read permissions. They can see every file under
`$HOME` that your shell can — including `.env`, `~/.ssh/`, `~/.aws/`, browser
profiles, and wallet keystores.

`revoke-probe` is a 90-second local scan that enumerates exactly which
high-value paths these agents have read access to.

**No telemetry. No upload. Open source.**

## Install

### macOS

```sh
brew install Revoke-Trust-Network/tap/revoke-probe
```

### Linux / WSL / Git Bash

```sh
curl -fsSL https://revokenode.io/install.sh | sh
```

### From source

```sh
git clone https://github.com/Revoke-Trust-Network/revoke-probe
cd revoke-probe
./revoke-probe --scan
```

## Usage

```sh
$ revoke-probe --scan
```

Output is a structured report of which agent-accessible paths match common
high-value patterns, sorted by risk tier.

For automation:

```sh
revoke-probe --scan --json
revoke-probe --scan --path /path/to/test/root
```

## What it scans (path pattern catalog)

See [docs/path-patterns.md](docs/path-patterns.md) for the full list.
TL;DR — 18 path families across SSH/cloud creds, wallet keystores, dotenv
variants, browser profiles, and framework config dirs.

## What it does NOT do

- ❌ Upload anything anywhere — it's read-only and local
- ❌ Read secret file contents — it only checks path existence/readability
- ❌ Prevent agents from reading these files (that's `revoke-node` Pro)
- ❌ Modify your filesystem in any way
- ❌ Track you, your IP, or anything else

## Why this exists

Three things happened in 2026 that shipped this from "weekend script" to
"open source today":

- **March 31, 2026** — Anthropic's Claude Code source map leaked via npm.
  512K lines of TypeScript exposed. The leak itself wasn't the bug; the
  permission model was the bug.
- **April 25, 2026** — Jer Crane's PocketOS prod database was wiped by a
  Cursor agent in `--auto` mode in 9 seconds.
- **May 7, 2026** — Adversa AI disclosed TrustFall, a chained prompt
  injection across MCP STDIO that affects Claude Code 2.1+, Cursor CLI,
  Gemini CLI, and Copilot CLI.

The pattern across all three: agents inherit user-level read access by
default. We needed a tool to show, in 90 seconds, exactly what that means
on a given machine. So we wrote it.

## Contributing

PRs welcome, especially:

- Windows path enumeration (currently weak)
- Additional dotfile patterns we missed
- Translations of the report output

## Roadmap

- [x] Path pattern catalog
- [x] Shell CLI scanner
- [x] JSON output mode
- [x] Homebrew tap
- [ ] eBPF-backed real-time read tracing (Linux)
- [ ] Native Windows PowerShell installer
- [ ] Scoop package
- [ ] CI integration mode

## Pro tier — `revoke-node`

`revoke-probe` shows you what agents *can* read.
[`revoke-node`](https://revokenode.io) is the OS-layer firewall that blocks,
allows, or audits these reads in real time. Probe is free forever. Node is
$29/mo for individuals.

## License

MIT © 2026 Revoke-Trust-Network
