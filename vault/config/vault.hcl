ui = true
disable_mlock = true

storage "consul" {
  address = "consul:8500"
  path    = "vault/"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

api_addr = "http://vault:8200"
cluster_addr = "http://vault:8201"

default_lease_ttl = "168h"
max_lease_ttl = "720h"
