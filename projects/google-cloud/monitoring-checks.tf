# Default notification channels (notify both Slack and mon@ email)
locals {
  project_id = google_project.ocf.project_id
  default_channels = [
    data.google_monitoring_notification_channel.slack-alerts.name,
    google_monitoring_notification_channel.email-mon.name,
  ]
}

###############################################################################
#####   The OCF website                                                   #####
###############################################################################
module "ocfweb" {
  source = "../../modules/https_check"

  host                  = "ocf.berkeley.edu"
  content_match         = "Open Computing Facility"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if the OCF website is up and responding at https://www.ocf.berkeley.edu/"
}
module "ocf_io" {
  source = "../../modules/https_check"

  host                  = "ocf.io"
  content_match         = "Open Computing Facility"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if the OCF website is up and responding at https://ocf.io/"
}
module "static" {
  source = "../../modules/https_check"

  host                  = "static.ocf.berkeley.edu"
  path                  = "/scss/site.scss.css"
  content_match         = "Bootstrap"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that the CSS on the OCF website is loading properly"
}
module "new" {
  source = "../../modules/https_check"

  host                  = "new.ocf.berkeley.edu"
  content_match         = "Open Computing Facility"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that https://new.ocf.berkeley.edu is up and responding"
}

###############################################################################
#####   Vhosting                                                          #####
###############################################################################
module "dev_vhost_cgi" {
  source = "../../modules/https_check"

  host                  = "dev-vhost.ocf.berkeley.edu"
  path                  = "/whoami.cgi"
  content_match         = "ggroup"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if https://dev-vhost.ocf.berkeley.edu/whoami.cgi loads and is working"
}
module "dev_vhost_php" {
  source = "../../modules/https_check"

  host                  = "dev-vhost.ocf.berkeley.edu"
  path                  = "/whoami.php"
  content_match         = "ggroup"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if https://dev-vhost.ocf.berkeley.edu/whoami.php loads and is working"
}
module "dev_vhost_flask" {
  source = "../../modules/https_check"

  host                  = "dev-vhost.ocf.berkeley.edu"
  path                  = "/flask-vhost/"
  content_match         = "flask-vhost"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if https://dev-vhost.ocf.berkeley.edu/flask-vhost/ loads and is working"
}
module "dev_vhost_alias" {
  source = "../../modules/https_check"

  host                  = "dev-vhost-alias.ocf.berkeley.edu"
  content_match         = "Index of /"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if https://dev-vhost-alias.ocf.berkeley.edu/ loads and is working"
}

###############################################################################
#####   Apphosting                                                        #####
###############################################################################
module "dev_apphost" {
  source = "../../modules/https_check"

  host                  = "dev-app.ocf.berkeley.edu"
  content_match         = "congratulations, you are the"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if https://dev-app.ocf.berkeley.edu/ loads and is working"
}

###############################################################################
#####   Auth (keycloak)                                                   #####
###############################################################################
module "auth" {
  source = "../../modules/https_check"

  host = "auth.ocf.berkeley.edu"
  # Keycloak has a meta refresh thing which means we can't check for the end
  # state unfortunately, but we can check that it loads something correct
  content_match         = "If you are not redirected automatically"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if keycloak is up in kubernetes and https://auth.ocf.berkeley.edu is available"
}

###############################################################################
#####   Templates                                                         #####
###############################################################################
module "templates" {
  source = "../../modules/https_check"

  host                  = "templates.ocf.berkeley.edu"
  content_match         = "user-what-is-wordpress"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if https://templates.ocf.berkeley.edu is available"
}

###############################################################################
#####   Sourcegraph                                                       #####
###############################################################################
module "sourcegraph" {
  source = "../../modules/https_check"

  host                  = "sourcegraph.ocf.berkeley.edu"
  content_match         = "Sourcegraph Search"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if https://sourcegraph.ocf.berkeley.edu is available"
}

###############################################################################
#####   Jenkins                                                           #####
###############################################################################
module "jenkins" {
  source = "../../modules/https_check"

  host                  = "jenkins.ocf.berkeley.edu"
  content_match         = "Jenkins"
  project_id            = local.project_id
  notification_channels = local.default_channels
  # This can be flaky, especially when restarting after plugins have updated.
  # We don't really mind if this is down for a while since it's internal-only,
  # as long as we are alerted sometime.
  trigger_count = 5
  documentation = "Check if https://jenkins.ocf.berkeley.edu is available"
}

###############################################################################
#####   Matrix (element + synapse)                                        #####
###############################################################################
module "element" {
  source = "../../modules/https_check"

  host = "chat.ocf.berkeley.edu"
  # Would be nice to match on something else, but oh well
  content_match         = "Sorry, Element requires JavaScript"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that element (aka matrix) is up and responding in kubernetes and at https://chat.ocf.berkeley.edu"
}
module "synapse" {
  source = "../../modules/https_check"

  host                  = "matrix.ocf.berkeley.edu"
  content_match         = "It works! Synapse is running"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that synapse (aka matrix) is up and responding in kubernetes and at https://matrix.ocf.berkeley.edu"
}

###############################################################################
#####   Mirrors                                                           #####
###############################################################################
module "mirrors" {
  source = "../../modules/https_check"

  host                  = "mirrors.ocf.berkeley.edu"
  content_match         = "Open Computing Facility Mirrors"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that our mirrors are up at https://mirrors.ocf.berkeley.edu"
}

###############################################################################
#####   Mastodon                                                          #####
###############################################################################
module "mastodon" {
  source = "../../modules/https_check"

  host                  = "mastodon.ocf.berkeley.edu"
  content_match         = "OCF Mastodon"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that mastodon is up in kubernetes and at https://mastodon.ocf.berkeley.edu"
}

###############################################################################
#####   Lab Map                                                           #####
###############################################################################
module "labmap" {
  source = "../../modules/https_check"

  host                  = "labmap.ocf.berkeley.edu"
  content_match         = "Lab Map"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that labmap is up in kubernetes and at https://labmap.ocf.berkeley.edu"
}

###############################################################################
#####   Print List                                                        #####
###############################################################################
module "printlist" {
  source = "../../modules/https_check"

  host                  = "printlist.ocf.berkeley.edu"
  path                  = "/home"
  content_match         = "Print List"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that printlist is up in kubernetes and at https://printlist.ocf.berkeley.edu/home"
}

###############################################################################
#####   phpMyAdmin (pma)                                                  #####
###############################################################################
module "pma" {
  source = "../../modules/https_check"

  host                  = "pma.ocf.berkeley.edu"
  content_match         = "phpMyAdmin"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that pma is up in kubernetes and at https://pma.ocf.berkeley.edu"
}

###############################################################################
#####   SSH and shell-in-a-box                                            #####
###############################################################################
module "webssh" {
  source = "../../modules/https_check"

  host                  = "ssh.ocf.berkeley.edu"
  content_match         = "ShellInABox"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that shell in a box (on tsunami) is up at https://ssh.ocf.berkeley.edu"
}
module "ssh" {
  source = "../../modules/tcp_check"

  host                  = "ssh.ocf.berkeley.edu"
  port                  = 22
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if the SSH server on tsunami is up and running"
}

###############################################################################
#####   Email (SMTP)                                                      #####
###############################################################################
module "smtp" {
  source = "../../modules/tcp_check"

  host = "smtp.ocf.berkeley.edu"
  # Would be nice if we could do a SSL check here too, but unfortunately that
  # doesn't appear to be an option with a TCP check
  port                  = 587
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if the mail server is up and responding on port 587"
}

###############################################################################
#####   DNS                                                               #####
###############################################################################
module "dns" {
  source = "../../modules/tcp_check"

  host = "ns.ocf.berkeley.edu"
  # Yes, DNS is typically over UDP, but we also have it over TCP and there's no
  # UDP uptime check... :(
  port                  = 53
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check if `dig +tcp ocf.io @ns.ocf.berkeley.edu` succeeds"
}

###############################################################################
#####   IRC and Web IRC                                                   #####
###############################################################################
module "irc" {
  source = "../../modules/tcp_check"

  host                  = "irc.ocf.berkeley.edu"
  port                  = 6697
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that the IRC server is up on flood"
}
module "webirc" {
  source = "../../modules/https_check"

  host                  = "irc.ocf.berkeley.edu"
  content_match         = "The Lounge"
  project_id            = local.project_id
  notification_channels = local.default_channels
  documentation         = "Check that thelounge is up and running on kubernetes and that https://irc.ocf.berkeley.edu is working"
}

###############################################################################
#####   TLS/SSL certificate expiration (aggregate for all HTTPS checks)   #####
###############################################################################
resource "google_monitoring_alert_policy" "cert-expiration" {
  display_name = "cert-expiration"
  combiner     = "OR"
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
