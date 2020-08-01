###############################################################################
#####   The OCF website                                                   #####
###############################################################################
resource "google_monitoring_uptime_check_config" "ocfweb" {
  display_name = "ocfweb"
  timeout      = "10s"
  period       = "60s"

  content_matchers {
    content = "Open Computing Facility"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "ocf.berkeley.edu"
    }
  }
}

module "ocfweb_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.ocfweb
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if the OCF website is up and responding at https://www.ocf.berkeley.edu/"
}

resource "google_monitoring_uptime_check_config" "ocf-io" {
  display_name = "ocf-io"
  timeout      = "10s"
  period       = "60s"

  content_matchers {
    content = "Open Computing Facility"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "ocf.io"
    }
  }
}

module "ocf_io_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.ocf-io
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if the OCF website is up and responding at https://ocf.io/"
}

###############################################################################
#####   Vhosting                                                          #####
###############################################################################
resource "google_monitoring_uptime_check_config" "dev-vhost-cgi" {
  display_name = "dev-vhost-cgi"
  timeout      = "5s"
  period       = "60s"

  content_matchers {
    content = "ggroup"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/whoami.cgi"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "dev-vhost.ocf.berkeley.edu"
    }
  }
}

module "dev_vhost_cgi_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.dev-vhost-cgi
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if https://dev-vhost.ocf.berkeley.edu/whoami.cgi loads and is working"
}

resource "google_monitoring_uptime_check_config" "dev-vhost-php" {
  display_name = "dev-vhost-php"
  timeout      = "5s"
  period       = "60s"

  content_matchers {
    content = "ggroup"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/whoami.php"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "dev-vhost.ocf.berkeley.edu"
    }
  }
}

module "dev_vhost_php_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.dev-vhost-php
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if https://dev-vhost.ocf.berkeley.edu/whoami.php loads and is working"
}

resource "google_monitoring_uptime_check_config" "dev-vhost-flask" {
  display_name = "dev-vhost-flask"
  timeout      = "5s"
  period       = "60s"

  content_matchers {
    content = "flask-vhost"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/flask-vhost/"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "dev-vhost.ocf.berkeley.edu"
    }
  }
}

module "dev_vhost_flask_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.dev-vhost-flask
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if https://dev-vhost.ocf.berkeley.edu/flask-vhost/ loads and is working"
}

resource "google_monitoring_uptime_check_config" "dev-vhost-alias" {
  display_name = "dev-vhost-alias"
  timeout      = "5s"
  period       = "60s"

  content_matchers {
    content = "Index of /"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "dev-vhost-alias.ocf.berkeley.edu"
    }
  }
}

module "dev_vhost_alias_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.dev-vhost-alias
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if https://dev-vhost-alias.ocf.berkeley.edu/ loads and is working"
}

###############################################################################
#####   Apphosting                                                        #####
###############################################################################
resource "google_monitoring_uptime_check_config" "dev-app" {
  display_name = "dev-app"
  timeout      = "5s"
  period       = "60s"

  content_matchers {
    content = "congratulations, you are the"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "dev-app.ocf.berkeley.edu"
    }
  }
}

module "dev_app_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.dev-app
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if https://dev-app.ocf.berkeley.edu/ loads and is working"
}

###############################################################################
#####   Templates                                                         #####
###############################################################################
resource "google_monitoring_uptime_check_config" "templates" {
  display_name = "templates"
  timeout      = "5s"
  period       = "60s"

  content_matchers {
    content = "user-what-is-wordpress"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "templates.ocf.berkeley.edu"
    }
  }
}

module "templates_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.templates
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if the templates site is up and responding at https://templates.ocf.berkeley.edu"
}

###############################################################################
#####   Jenkins                                                           #####
###############################################################################
resource "google_monitoring_uptime_check_config" "jenkins" {
  display_name = "jenkins"
  timeout      = "10s"
  period       = "60s"

  content_matchers {
    content = "Jenkins"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "jenkins.ocf.berkeley.edu"
    }
  }
}

module "jenkins_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.jenkins
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if Jenkins is up and responding at https://jenkins.ocf.berkeley.edu"
}

###############################################################################
#####   Element                                                           #####
###############################################################################
resource "google_monitoring_uptime_check_config" "element" {
  display_name = "element"
  timeout      = "5s"
  period       = "60s"

  content_matchers {
    # Would be nice to match on something else, but oh well
    content = "Sorry, Element requires JavaScript"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "chat.ocf.berkeley.edu"
    }
  }
}

module "element_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.element
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check that element (aka matrix) is up and responding in kubernetes and at https://chat.ocf.berkeley.edu"
}

###############################################################################
#####   Synapse                                                           #####
###############################################################################
resource "google_monitoring_uptime_check_config" "synapse" {
  display_name = "synapse"
  timeout      = "5s"
  period       = "60s"

  content_matchers {
    content = "It works! Synapse is running"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "matrix.ocf.berkeley.edu"
    }
  }
}

module "synapse_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.synapse
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check that synapse (aka matrix) is up and responding in kubernetes and at https://matrix.ocf.berkeley.edu"
}

###############################################################################
#####   Mirrors                                                           #####
###############################################################################
resource "google_monitoring_uptime_check_config" "mirrors" {
  display_name = "mirrors"
  timeout      = "5s"
  period       = "60s"

  content_matchers {
    content = "Open Computing Facility Mirrors"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "mirrors.ocf.berkeley.edu"
    }
  }
}

module "mirrors_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.mirrors
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check that our mirrors are up at https://mirrors.ocf.berkeley.edu"
}

###############################################################################
#####   SSH and shell-in-a-box                                            #####
###############################################################################
resource "google_monitoring_uptime_check_config" "webssh" {
  display_name = "webssh"
  timeout      = "10s"
  period       = "60s"

  content_matchers {
    content = "ShellInABox"
    matcher = "CONTAINS_STRING"
  }

  http_check {
    path         = "/"
    use_ssl      = true
    validate_ssl = true
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "ssh.ocf.berkeley.edu"
    }
  }
}

module "webssh_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.webssh
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check that shell in a box (on tsunami) is up at https://ssh.ocf.berkeley.edu"
}

resource "google_monitoring_uptime_check_config" "ssh" {
  display_name = "ssh"
  timeout      = "5s"
  period       = "60s"

  tcp_check {
    port = 22
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "ssh.ocf.berkeley.edu"
    }
  }
}

module "ssh_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.ssh
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if the SSH server on tsunami is up and running"
}

###############################################################################
#####   Email (SMTP)                                                      #####
###############################################################################
resource "google_monitoring_uptime_check_config" "smtp" {
  display_name = "smtp"
  timeout      = "5s"
  period       = "60s"

  tcp_check {
    # Would be nice if we could do a SSL check here too, but unfortunately that
    # doesn't appear to be an option with a TCP check
    port = 587
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "smtp.ocf.berkeley.edu"
    }
  }
}

module "smtp_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.smtp
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if the mail server is up and responding on port 587"
}

###############################################################################
#####   DNS                                                               #####
###############################################################################
resource "google_monitoring_uptime_check_config" "dns" {
  display_name = "dns"
  timeout      = "1s"
  period       = "60s"

  # Yes, DNS is typically over UDP, but we also have it over TCP and there's no
  # UDP uptime check... :(
  tcp_check {
    port = 53
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "ns.ocf.berkeley.edu"
    }
  }
}

module "dns_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.dns
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check if `dig +tcp ocf.io @ns.ocf.berkeley.edu` succeeds"
}

###############################################################################
#####   IRC                                                               #####
###############################################################################
resource "google_monitoring_uptime_check_config" "irc" {
  display_name = "irc"
  timeout      = "5s"
  period       = "60s"

  tcp_check {
    port = 6697
  }

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = google_project.ocf.project_id
      host       = "irc.ocf.berkeley.edu"
    }
  }
}

module "irc_uptime_alert" {
  source = "../../modules/uptime-alert"

  uptime_check          = google_monitoring_uptime_check_config.irc
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
  documentation         = "Check that the IRC server is up on flood"
}


###############################################################################
#####   TLS/SSL certificate expiration                                    #####
###############################################################################
resource "google_monitoring_alert_policy" "cert-expiration" {
  display_name          = "cert-expiration"
  combiner              = "OR"
  notification_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]

  conditions {
    display_name = "Failure of cert expiration check, certs are expiring in fewer than 15 days"
    condition_threshold {
      comparison      = "COMPARISON_LT"
      duration        = "600s"
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/time_until_ssl_cert_expires\" AND resource.type=\"uptime_url\""
      threshold_value = 15

      aggregations {
        alignment_period     = "1200s"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields      = ["resource.label.*"]
        per_series_aligner   = "ALIGN_NEXT_OLDER"
      }

      trigger {
        count = 1
      }
    }
  }

  documentation {
    content = "A TLS/SSL certificate is expiring in fewer than 15 days"
  }
}
