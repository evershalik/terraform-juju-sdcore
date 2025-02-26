# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

data "juju_model" "sdcore_upf" {
  name = var.model
}

module "upf" {
  source    = "git::https://github.com/evershalik/sdcore-upf-k8s-operator//terraform"
  model     = data.juju_model.sdcore_upf.name
  channel   = var.upf_channel
  config    = var.upf_config
  revision  = var.upf_revision
  resources = var.upf_resources
}

module "grafana-agent" {
  source     = "../external/grafana-agent-k8s"
  model_name = data.juju_model.sdcore_upf.name
  channel    = var.grafana_agent_channel
  config     = var.grafana_agent_config
}

# Integrations for `metrics` endpoint

resource "juju_integration" "upf-metrics" {
  model = data.juju_model.sdcore_upf.name

  application {
    name     = module.upf.app_name
    endpoint = module.upf.provides.metrics
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}

# Integrations for `logging` endpoint

resource "juju_integration" "upf-logging" {
  model = data.juju_model.sdcore_upf.name

  application {
    name     = module.upf.app_name
    endpoint = module.upf.requires.logging
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

# Cross-model integrations

resource "juju_offer" "upf-fiveg-n3" {
  model            = data.juju_model.sdcore_upf.name
  application_name = module.upf.app_name
  endpoint         = module.upf.provides.fiveg_n3
  name             = "upf-fiveg-n3"
}

resource "juju_offer" "upf-fiveg-n4" {
  model            = data.juju_model.sdcore_upf.name
  application_name = module.upf.app_name
  endpoint         = module.upf.provides.fiveg_n4
  name             = "upf-fiveg-n4"
}
