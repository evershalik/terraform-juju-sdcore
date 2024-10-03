# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

# Integration offers for external systems

output "upf_fiveg_n3_offer_url" {
  description = "UPF `fiveg_n3` offer."
  value       = juju_offer.upf-fiveg-n3.url
}

output "upf_fiveg_n4_offer_url" {
  description = "UPF `fiveg_n4` offer."
  value       = juju_offer.upf-fiveg-n4.url
}

# Outputs required to consume external offers

output "grafana_agent_app_name" {
  description = "Name of the deployed Grafana Agent application."
  value       = module.grafana-agent.app_name
}
output "send_remote_write_endpoint" {
  description = "Name of the endpoint to forward client charms metrics and associated alert rules to Prometheus using prometheus_remote_write interface."
  value       = module.grafana-agent.send_remote_write_endpoint
}
output "logging_consumer_endpoint" {
  description = "Name of the endpoint to send the logs to Loki using loki_push_api interface."
  value       = module.grafana-agent.logging_consumer_endpoint
}
