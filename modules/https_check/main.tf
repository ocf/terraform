resource "google_monitoring_uptime_check_config" "https_check" {
  display_name = "https://${var.host}${var.path}"
  timeout      = "${var.timeout}s"
  period       = "60s"

  dynamic "content_matchers" {
    for_each = var.content_match == "" ? [] : [1]
    content {
      content = var.content_match
      matcher = "CONTAINS_STRING"
    }
  }

  http_check {
    path         = var.path
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = var.host
    }
  }
}

module "https_uptime_alert" {
  source = "../uptime_alert"

  trigger_count         = var.trigger_count
  uptime_check_id       = google_monitoring_uptime_check_config.https_check.uptime_check_id
  notification_channels = var.notification_channels
  documentation         = var.documentation
}
