variable "vault_address" {
  type    = string
  default = "http://127.0.0.1:8200"
}

variable "vault_token" {
  type      = string
  sensitive = true
}

variable "db_username" {
  type    = string
  default = "appuser"
}

variable "db_host" {
  type    = string
  default = "db.internal"
}
