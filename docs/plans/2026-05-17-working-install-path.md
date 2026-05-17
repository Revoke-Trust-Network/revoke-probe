# Working install path plan — 2026-05-17

## Objective and scope

Make the public install commands for Revoke Probe truthful and executable:

- Replace the placeholder `revoke-probe` script with a local scanner that checks readable high-value path names without reading file contents.
- Replace the placeholder `install.sh` with a user-local installer.
- Publish a GitHub release and Homebrew tap so `brew install Revoke-Trust-Network/tap/revoke-probe` works.
- Update the Revokenode `/probe` page and `/install.sh` route to match the live install paths.

Out of scope:

- OS-layer blocking. That remains Revoke Node Pro.
- Native Windows/Scoop packaging. Windows users can use WSL/Git Bash for this pass.
- Reading secret contents, uploading telemetry, or modifying user files.

## Assumptions and constraints

- Repository: `Revoke-Trust-Network/revoke-probe`, public, current user has admin access.
- Homebrew tap repository can be created as `Revoke-Trust-Network/homebrew-tap`.
- Installer must not run the scan automatically.
- Scanner must be read-only and local-first.
- The storefront Worker already serves `/probe` through Worker-first routing.

## Official sources

- Homebrew tap docs, accessed 2026-05-17: https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap
- Homebrew formula cookbook, accessed 2026-05-17: https://docs.brew.sh/Formula-Cookbook
- GitHub CLI manual, accessed 2026-05-17: https://cli.github.com/manual/gh_repo_create and https://cli.github.com/manual/gh_release_create
- Cloudflare Workers static assets routing, accessed 2026-05-17: https://developers.cloudflare.com/workers/static-assets/routing/worker-script/

## Execution plan

1. Implement `revoke-probe --scan`, `--json`, `--path`, `--version`, and `--help`.
2. Implement `install.sh` with `curl`/`wget`, user-local install, and no auto-scan.
3. Validate shell syntax, JSON parsing, scoped scan behavior, and local installer override.
4. Commit and tag `v0.1.0`, push to GitHub, and create a release.
5. Create `homebrew-tap`, add `Formula/revoke-probe.rb`, push it, and verify with `brew`.
6. Add storefront `/install.sh` Worker route and restore the `/probe` page install copy.
7. Deploy storefront and run live `curl`/`brew` checks.

## Validation plan

- `sh -n revoke-probe install.sh`
- `./revoke-probe --version`
- `./revoke-probe --scan --path <tmpdir>`
- `./revoke-probe --scan --path <tmpdir> --json` parsed by `node`
- `REVOKE_INSTALL_DIR=<tmpdir> REVOKE_PROBE_URL=file://... ./install.sh`
- `brew install Revoke-Trust-Network/tap/revoke-probe`
- `curl -fsSL https://revokenode.io/install.sh | head`
- Storefront targeted tests for Worker route behavior.
- Live `curl https://revokenode.io/probe` command-copy verification.

## Reverse review pass 1 — assumptions and contradictions

- The earlier website claimed Homebrew and `install.sh` before they existed; implementation must not reintroduce false Windows/Scoop claims.
- A shell scanner cannot prove process-tree read events; copy must say "can read/reachable/read access", not "has read".
- Homebrew formula should install a stable tagged release, not mutable `main`.

## Reverse review pass 2 — failure paths and rollback

- If Homebrew tap creation fails, keep website on `curl | sh` and source install only.
- If tagged raw file is unavailable, do not advertise `install.sh` until the release is reachable.
- If Worker `/install.sh` proxy fails, rollback to static source-preview copy and keep `/install.sh` unadvertised.
- If brew install leaves a local test package, uninstall or report it explicitly.

## Completion criteria

- The command shown on `/probe` for macOS installs a runnable `revoke-probe`.
- `https://revokenode.io/install.sh` returns a real installer, not 404.
- CLI reports findings from a controlled temp fixture without reading contents.
- README and website match the actual available install paths.
