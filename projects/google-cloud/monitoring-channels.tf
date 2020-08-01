resource "google_monitoring_notification_channel" "email-mon" {
  display_name = "mon@ email"
  type         = "email"
  labels = {
    email_address = "mon@ocf.berkeley.edu"
  }
}

# This has been set up manually since it includes a step to authenticate with
# Slack and would need an auth token to be provided here otherwise
data "google_monitoring_notification_channel" "slack-alerts" {
  display_name = "alerts"
  type         = "slack"
}
