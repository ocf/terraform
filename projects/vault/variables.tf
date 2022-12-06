variable "client_secret" {
  description = "Required: OIDC Client secret for Hashicorp Vault"
  type        = string
}

variable "client_id" {
  description = "Required: OIDC Client ID for Hashicorp Vault"
}

variable "discovery_url" {
  description = "OIDC Discovery endpoint"
  type        = string
  default     = "https://auth.ocf.berkeley.edu/auth/realms/ocf"
}

variable "authorized_redirects" {
  description = "List of authorized redirects for Keycloak OIDC"
  type        = list(string)
  default     = ["http://localhost:8250/oidc/callback", "https://vault.ocf.berkeley.edu/ui/vault/auth/oidc/oidc/callback"]
}
