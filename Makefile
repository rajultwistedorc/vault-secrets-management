.PHONY: up init unseal status rotate

up:
	docker compose up -d

init:
	bash scripts/init-vault.sh

unseal:
	@source .vault-keys 2>/dev/null && vault operator unseal $$VAULT_UNSEAL_KEY

status:
	vault status || docker compose exec vault vault status

rotate:
	bash scripts/rotate-secrets.sh
