#!/usr/bin/env sh
# Install revoke-probe into a user-writable bin directory.

set -eu

VERSION="0.1.0"
DEFAULT_URL="https://raw.githubusercontent.com/Revoke-Trust-Network/revoke-probe/v0.1.0/revoke-probe"
PROBE_URL="${REVOKE_PROBE_URL:-$DEFAULT_URL}"
INSTALL_DIR="${REVOKE_INSTALL_DIR:-$HOME/.local/bin}"
TARGET="$INSTALL_DIR/revoke-probe"

say() {
  printf '%s\n' "$*"
}

fail() {
  printf 'revoke-probe installer: %s\n' "$*" >&2
  exit 1
}

[ -n "${HOME:-}" ] || fail "HOME is not set"

mkdir -p "$INSTALL_DIR"

tmp_file="$(mktemp "${TMPDIR:-/tmp}/revoke-probe-install.XXXXXX")" || fail "mktemp failed"
cleanup() {
  rm -f "$tmp_file"
}
trap cleanup EXIT INT TERM

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$PROBE_URL" -o "$tmp_file"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$tmp_file" "$PROBE_URL"
else
  fail "curl or wget is required"
fi

head -n 1 "$tmp_file" | grep -q 'sh' || fail "download did not look like a shell script"
chmod 0755 "$tmp_file"
mv "$tmp_file" "$TARGET"
trap - EXIT INT TERM

say ""
say "Revoke Probe $VERSION installed:"
say "  $TARGET"
say ""
if command -v revoke-probe >/dev/null 2>&1; then
  say "Run:"
  say "  revoke-probe --scan"
else
  say "Add this to your shell profile if needed:"
  say "  export PATH=\"$INSTALL_DIR:\$PATH\""
  say ""
  say "Then run:"
  say "  revoke-probe --scan"
fi
say ""
say "No scan was run by the installer."
