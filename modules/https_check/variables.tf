# Required variables
variable "host" {
  description = "The host to monitor"
  type        = string
}
variable "project_id" {
  description = "The GCP project to associate the check with"
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
variable "timeout" {
  description = "The default timeout before failing the check"
  type        = number
  default     = 10
}
variable "content_match" {
  description = "Any content to match on the page as part of the monitoring check"
  type        = string
  default     = ""
}
variable "path" {
  description = "The path to use (added onto the host)"
  type        = string
  default     = "/"
}
