#!/usr/bin/env bash
set -euo pipefail
export VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"

if vault status 2>/dev/null | grep -q "Sealed.*false"; then
  echo "Vault already initialized and unsealed"
  exit 0
fi

INIT=$(vault operator init -key-shares=1 -key-threshold=1 -format=json)
UNSEAL_KEY=$(echo "$INIT" | jq -r '.unseal_keys_b64[0]')
ROOT_TOKEN=$(echo "$INIT" | jq -r '.root_token')

vault operator unseal "$UNSEAL_KEY"
export VAULT_TOKEN="$ROOT_TOKEN"

echo "VAULT_UNSEAL_KEY=$UNSEAL_KEY" > .vault-keys
echo "VAULT_ROOT_TOKEN=$ROOT_TOKEN" >> .vault-keys
chmod 600 .vault-keys
echo "Vault initialized. Keys saved to .vault-keys (keep secure!)"
