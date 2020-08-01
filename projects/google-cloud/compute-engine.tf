resource "google_compute_instance" "ocf-offsite" {
  name         = "ocf-offsite"
  machine_type = "f1-micro"
  zone         = "us-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-8-jessie-v20170327"
      size  = 15
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip       = "35.185.210.62"
      network_tier = "PREMIUM"
    }
  }

  metadata = {
    ssh-keys = "jvperrin:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTYpp0JepIuTc3v2RwRJqxLjebzjAYMLjELqzKL/CgZI9zhasxxG0tlMpMwOtH6IoykecfG/7xaSkhieSK607UjLfzWnjORbkQ2ToF6xfYNnJTUyXLzMG3Cz15Kd1PMP9CkyUZsQV9OVmXSbl2xfI4vHMJRu2rqd0rksmpmYWAIM3/SKfQScA7C7fB//RD8B9PUu18GVgkXyidVwjmz4p6gCC2HzakTx6HxRrS/8Xfi/Mou35ShW4eoDEvNjC7LISLj5VlHGhMk76hkFZjiuRw6vfbNH5NiVr5Xbbyfa/5uQEmGWaBOQro4ZMk/Eznc/f+MI2+I4NBnmZmobEinlVDRzVUniwMYnxXe7TqGtM6KdEPoI/pfLPyM+kf4krKml/ITUphSbsuTp7fNdbJpsuWTdRm5+wMobZQL5NrUNDkh7ULutUlWJtFudif+3b/kkDKnHWZx5p4G6IrsxfhByxG+SbNWgIxkYzCG3Y8cnDmAeGzuOkz48TpTBTjzhSwuOU8EAGlZKxjt51teHc+urLUC2X3+kITL9OtjXu/WRq1BIQBqSofW4TDjM7dq290jNoSpe54KgBKMTT5nEbVKzXaIhL5OyXe8aw0tJDta2/WH9EE4VxjCzHsqMjih+ZPcaNc70frlJLfWY7/uxl6qPspCSMNf1TUyFUpScFXa9tsOw== jvperrin@ocf.berkeley.edu"
  }

  service_account {
    email  = "576284163800-compute@developer.gserviceaccount.com"
    scopes = ["storage-ro", "logging-write", "monitoring-write", "service-management", "service-control", "trace-append"]
  }
}
