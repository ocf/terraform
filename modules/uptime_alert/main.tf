# This module mainly exists to reduce the kind of boilerplate needed below in
# creating a simple monitoring alert for uptime. It's generally not great
# practice in terraform to just do a wrapper like this, but to make it easier
# to actually add simple alerts it seems worth it.
resource "google_monitoring_alert_policy" "uptime_alert" {
  display_name          = "${var.uptime_check_id}-uptime"
  combiner              = "OR"
  notification_channels = var.notification_channels

  conditions {
    display_name = "Failure of uptime check on ${var.uptime_check_id}"
    condition_threshold {
      comparison      = "COMPARISON_GT"
      duration        = "${var.failing_duration}s"
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND metric.label.check_id=\"${var.uptime_check_id}\" AND resource.type=\"uptime_url\""
      threshold_value = 1

      aggregations {
        alignment_period     = "1200s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields      = ["resource.*"]
        per_series_aligner   = "ALIGN_NEXT_OLDER"
      }

      trigger {
        count   = var.trigger_count
        percent = var.trigger_percent
      }
    }
  }

  documentation {
    content = var.documentation
  }
}
