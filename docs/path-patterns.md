# Path Pattern Catalog

The 18 high-value path families that `revoke-probe` scans on a clean dev
machine. Each one is a category your AI coding agent process tree inherits
read access to by default.

## SSH & remote access

- `~/.ssh/id_rsa`, `~/.ssh/id_ed25519`, `~/.ssh/id_ecdsa` — SSH private keys
- `~/.ssh/config` — SSH host configuration
- `~/.ssh/known_hosts` — host fingerprint history

## Cloud credentials

- `~/.aws/credentials` — AWS access keys
- `~/.aws/config` — AWS profile config
- `~/.config/gcloud/` — Google Cloud SDK credentials
- `~/.azure/` — Azure CLI tokens
- `~/.kube/config` — Kubernetes cluster admin credentials

## Package & registry tokens

- `~/.npmrc` — npm auth tokens
- `~/.pypirc` — PyPI publishing credentials
- `~/.docker/config.json` — Container registry credentials
- `~/.cargo/credentials` — crates.io tokens
- `~/.git-credentials`, `~/.netrc` — Git HTTPS / HTTP basic auth

## Wallet keystores (EVM / Solana / Bitcoin)

- `~/.foundry/keystores/` — Foundry encrypted keystores
- `~/.ethereum/keystore/` — go-ethereum keystores
- `~/.config/solana/id.json` — Solana keypair (unencrypted)
- `~/Library/Application Support/Electrum/wallets/` — Electrum BTC
- Browser extension wallet vaults (MetaMask, Phantom, Rabby, etc.)

## Browser profile data

- `~/Library/Application Support/Google/Chrome/`
- `~/.config/google-chrome/`
- `~/Library/Application Support/Firefox/Profiles/`
- `~/.config/BraveSoftware/Brave-Browser/`
- Contains cookies, saved passwords, autofill, session tokens

## Project secrets (current working directory tree)

- `.env`, `.env.local`, `.env.production`, `.env.development`
- `secrets.yml`, `config/secrets.yml`
- `.envrc` (direnv)
- `*.pem`, `*.key`, `*.p12` files anywhere in project tree

## What the probe doesn't catch (yet)

- Keychain / Credential Manager / Keyring entries — these require elevated
  permissions to read, so agents typically can't access them without a
  prompt
- Hardware wallets and Secure Enclave
- Files behind FUSE/FileVault with selective decryption

Contributions to this catalog are welcome — open a PR if you've seen agents
access something not listed.
