# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

resource "juju_model" "sdcore" {
  name = var.model_name
}

module "upf" {
  source     = "git::https://github.com/canonical/sdcore-upf-k8s-operator//terraform"
  model_name = juju_model.sdcore.name
  channel    = var.channel
  amf-config = var.upf_config
}

module "grafana-agent" {
  source         = "./modules/grafana-agent-k8s"
  model_name     = juju_model.sdcore.name
  channel        = var.grafana_agent_channel
  grafana-config = var.grafana_agent_config
}

# Integrations for `metrics` endpoint

resource "juju_integration" "upf-metrics" {
  model = var.model_name

  application {
    name     = module.upf.app_name
    endpoint = module.upf.metrics_endpoint
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}