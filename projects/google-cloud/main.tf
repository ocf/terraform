provider "google" {
  project = "open-computing-facility"
  region  = "us-west1"
  zone    = "us-west1-b"
}

terraform {
  backend "gcs" {
    bucket = "ocf-terraform"
    prefix = "google-cloud"
  }
}
