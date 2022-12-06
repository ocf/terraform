resource "vault_jwt_auth_backend" "keycloak" {
  description        = "Keycloak"
  path               = "oidc"
  type               = "oidc"
  oidc_discovery_url = var.discovery_url
  oidc_client_id     = var.client_id
  oidc_client_secret = var.client_secret
  default_role       = "default"
  tune {
    default_lease_ttl = "1h"
    max_lease_ttl     = "8h"
    allowed_response_headers     = []
    audit_non_hmac_request_keys  = []
    audit_non_hmac_response_keys = []
    listing_visibility           = "unauth"
    passthrough_request_headers  = []
    token_type                   = "default-service"
  }
}

resource "vault_jwt_auth_backend_role" "default" {
  backend        = vault_jwt_auth_backend.keycloak.path
  role_name      = "default"
  token_policies = ["default"]

  user_claim            = "sub"
  groups_claim          = "groups"
  role_type             = "oidc"
  allowed_redirect_uris = var.authorized_redirects
}

resource "vault_identity_group" "ocfroot" {
  name     = "ocfroot"
  type     = "external"
  policies = [vault_policy.ocfroot.name]
}

resource "vault_identity_group_alias" "ocfroot" {
  name           = "ocfroot"
  mount_accessor = vault_jwt_auth_backend.keycloak.accessor
  canonical_id   = vault_identity_group.ocfroot.id
}
