output "uptime_check_id" {
  value       = google_monitoring_uptime_check_config.tcp_check.uptime_check_id
  description = "A more human-friendly name (same as the name passed in to the module)"
}
output "uptime_check_name" {
  value       = google_monitoring_uptime_check_config.tcp_check.name
  description = "A unique resource name for the created uptime check config"
}

output "uptime_alert_policy_id" {
  value       = module.uptime_alert.uptime_alert_policy_id
  description = "A human-friendly identifier of the created uptime alert policy"
}
output "uptime_alert_policy_name" {
  value       = module.uptime_alert.uptime_alert_policy_name
  description = "The unique resource name of the created uptime alert policy"
}
