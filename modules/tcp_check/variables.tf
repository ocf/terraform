# Required variables
variable "host" {
  description = "The host to monitor"
  type        = string
}
variable "port" {
  description = "The port to check"
  type        = number
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
  default     = 5
}
