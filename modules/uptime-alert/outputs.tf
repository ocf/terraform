output "uptime_alert_policy_id" {
  value       = google_monitoring_alert_policy.uptime_alert.id
  description = "A human-friendly identifier of the created uptime alert policy"
}

output "uptime_alert_policy_name" {
  value       = google_monitoring_alert_policy.uptime_alert.name
  description = "The unique resource name of the created uptime alert policy"
}
