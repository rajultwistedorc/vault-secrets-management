#!/usr/bin/env bash
set -euo pipefail
export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
export VAULT_TOKEN="${VAULT_TOKEN:?Set VAULT_TOKEN}"
PATH_SECRET="${1:-secret/app/database}"

NEW_PASS="$(openssl rand -base64 24)"
vault kv patch "$PATH_SECRET" password="$NEW_PASS" rotated_at="$(date -Iseconds)"
echo "Rotated password at $PATH_SECRET"
