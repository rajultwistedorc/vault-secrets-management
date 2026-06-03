#!/usr/bin/env bash
set -euo pipefail
export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
export VAULT_TOKEN="${VAULT_TOKEN:?Set VAULT_TOKEN}"

vault audit enable file file_path=/vault/logs/audit.log 2>/dev/null || true
vault read sys/audit 2>/dev/null || echo "Audit devices:"
vault list -format=json sys/audit 2>/dev/null | jq . || true
echo "Recent secret access (metadata):"
vault kv metadata get secret/app/database 2>/dev/null || true
