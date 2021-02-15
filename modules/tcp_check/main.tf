resource "google_monitoring_uptime_check_config" "tcp_check" {
  display_name = "tcp://${var.host}:${var.port}"
  timeout      = "${var.timeout}s"
  period       = "60s"

  tcp_check {
    port = var.port
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = var.host
    }
  }
}

module "uptime_alert" {
  source = "../uptime_alert"

  uptime_check_id       = google_monitoring_uptime_check_config.tcp_check.uptime_check_id
  notification_channels = var.notification_channels
  documentation         = var.documentation
}
