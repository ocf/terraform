resource "google_storage_bucket" "ocf" {
  name          = "ocf"
  location      = "US"
  storage_class = "STANDARD"
}

resource "google_storage_bucket" "ocf-nearline" {
  name          = "ocf-nearline"
  location      = "US"
  storage_class = "NEARLINE"
}

resource "google_storage_bucket" "ocf-terraform" {
  name          = "ocf-terraform"
  location      = "US-WEST1"
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }
}
