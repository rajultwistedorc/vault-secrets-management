#!/usr/bin/env bash
set -euo pipefail
export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
export VAULT_TOKEN="${VAULT_TOKEN:?Set VAULT_TOKEN}"

vault secrets enable -path=secret kv-v2 2>/dev/null || true
vault policy write app-policy vault/policies/app-policy.hcl
vault policy write admin-policy vault/policies/admin-policy.hcl

vault kv put secret/app/database \
  username=appuser \
  password="$(openssl rand -base64 24)" \
  host=db.internal

vault kv put secret/app/api \
  api_key="$(openssl rand -hex 32)"

echo "Secret engines and sample secrets configured"
