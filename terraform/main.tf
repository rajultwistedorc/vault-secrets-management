terraform {
  required_version = ">= 1.6.0"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.0"
    }
  }
}

provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}

resource "vault_mount" "secret" {
  path        = "secret"
  type        = "kv-v2"
  description = "Application secrets"
}

resource "vault_policy" "app" {
  name   = "app-policy"
  policy = file("${path.module}/../vault/policies/app-policy.hcl")
}

resource "vault_policy" "admin" {
  name   = "admin-policy"
  policy = file("${path.module}/../vault/policies/admin-policy.hcl")
}

resource "vault_kv_secret_v2" "app_db" {
  mount = vault_mount.secret.path
  name  = "app/database"
  data_json = jsonencode({
    username = var.db_username
    host     = var.db_host
  })
}
