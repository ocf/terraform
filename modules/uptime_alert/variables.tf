# Required variables
variable "uptime_check_id" {
  description = "The google_monitoring_uptime_check_config ID to associate with"
  type        = string
}
variable "notification_channels" {
  description = "A list of channels to send alert notifications to"
  type        = list(any)
}
variable "documentation" {
  description = "An alert tip included with the alert about what steps to take to resolve it"
  type        = string
}


# Optional variables
variable "failing_duration" {
  description = "The amount of time in seconds that the check has to fail before it alerts"
  type        = number
  default     = 120
}
variable "trigger_percent" {
  description = "The percent of alerts that are failing before the alert triggers"
  type        = number
  default     = null
}
