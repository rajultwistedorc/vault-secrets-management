path "secret/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "sys/*" {
  capabilities = ["read", "list"]
}

path "auth/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
