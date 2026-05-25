# Revoke Probe

Local-first reachability check for AI coding-agent and MCP workflows.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-macOS%20|%20Linux-blue)]()
[![Status](https://img.shields.io/badge/status-v0.1.0-green)]()

Revoke Probe helps you answer one narrow question:

> What sensitive-looking local surfaces could this developer workflow reach?

It scans for common credential-adjacent path patterns and can be paired with
**fake canaries** to produce a **sanitized report** you can share after review.

No telemetry. No source upload. No real secret values in the report. No
vendor-blame claims.

`revoke-probe` is the free local probe used by Agent Leak Bench.

## Install

### macOS

```sh
brew install Revoke-Trust-Network/tap/revoke-probe
```

### Linux / WSL / Git Bash

```sh
curl -fsSL https://revokenode.io/install.sh -o revoke-probe-install.sh && sh revoke-probe-install.sh
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

Output is a structured report of which AI-tool-accessible paths match common
high-value patterns, sorted by risk tier. The report is designed to be safe to
share after review because it must not include real secret values.

For automation:

```sh
revoke-probe --scan --json
revoke-probe --scan --path /path/to/test/root
```

## What it scans (path pattern catalog)

See [docs/path-patterns.md](docs/path-patterns.md) for the full list.
TL;DR — 18 path families across SSH/cloud creds, dotenv variants, browser
profiles, and framework config dirs.

## Fake canaries

The benchmark uses fake values only:

- fake AWS key marker
- fake Stripe key marker
- fake GitHub token marker
- fake OpenAI key marker
- fake SSH private key marker

Do not paste real credentials into issues, reports, screenshots, posts, or
support emails.

## What it proves

- Which sensitive path families are reachable on this machine.
- Which findings are worth reviewing before a team standardizes an AI coding workflow.

## What it does NOT prove

- It does not prove a vendor stole your data.
- It does not upload anything anywhere.
- It does not require real secret values.
- It does not prevent agents from reading these files by itself.
- It does not replace endpoint security, MDM, or secrets management.
- It does not modify your filesystem outside controlled benchmark fixtures.

## Why this exists

AI coding tools moved fast. Team policy did not. Most developers can name the AI
assistant they installed, but they cannot quickly answer a more operational
question:

> What can my current AI coding stack touch on this machine?

This benchmark exists to make that question visible, reproducible, and boring
enough to discuss without vendor-blame theater.

## Contributing

PRs welcome, especially:

- Additional dotfile patterns we missed
- Translations of the report output

## Roadmap

- [x] Path pattern catalog
- [x] Shell CLI scanner
- [x] JSON output mode
- [x] Homebrew tap
- [ ] eBPF-backed real-time read tracing (Linux)
- [ ] CI integration mode

## Pro tier — `revoke-node`

`revoke-probe` focuses on scan + report.

[`revoke-node`](https://revokenode.io) is the commercial product line around the
same problem space. This README intentionally avoids capability promises that
are not verified inside this repo.

## Team Pilot

Teams using Cursor, Claude Code, Codex CLI, Windsurf, VS Code extensions, or MCP
servers can request a 30-day audit:

```text
support@revokenode.io
Subject: Team Pilot
```

## License

MIT © 2026 Revoke-Trust-Network
