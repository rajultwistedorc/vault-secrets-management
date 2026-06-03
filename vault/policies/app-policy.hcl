path "secret/data/app/*" {
  capabilities = ["read", "list"]
}

path "secret/metadata/app/*" {
  capabilities = ["read", "list"]
}

path "auth/token/lookup-self" {
  capabilities = ["read"]
}
