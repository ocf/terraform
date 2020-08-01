provider "github" {
  organization = "ocf"
  anonymous    = false
}

terraform {
  backend "gcs" {
    bucket = "ocf-terraform"
    prefix = "github"
  }
}
