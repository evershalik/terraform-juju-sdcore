# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

resource "juju_model" "sdcore" {
  count = var.create_model == true ? 1 : 0
  name  = var.model_name
}

module "upf" {
  source     = "git::https://github.com/canonical/sdcore-upf-k8s-operator//terraform"
  model_name = var.create_model == true ? juju_model.sdcore[0].name : var.model_name
  channel    = var.upf_channel
  config     = var.upf_config
}

module "grafana-agent" {
  source     = "../external/grafana-agent-k8s"
  model_name = var.create_model == true ? juju_model.sdcore[0].name : var.model_name
  channel    = var.grafana_agent_channel
  config     = var.grafana_agent_config
}

# Integrations for `metrics` endpoint

resource "juju_integration" "upf-metrics" {
  model = var.create_model == true ? juju_model.sdcore[0].name : var.model_name

  application {
    name     = module.upf.app_name
    endpoint = module.upf.metrics_endpoint
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}

# Integrations for `logging` endpoint

resource "juju_integration" "upf-logging" {
  model = var.create_model == true ? juju_model.sdcore[0].name : var.model_name

  application {
    name     = module.upf.app_name
    endpoint = module.upf.logging_endpoint
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

# Cross-model integrations

resource "juju_offer" "upf-fiveg-n3" {
  model            = var.model_name
  application_name = module.upf.app_name
  endpoint         = module.upf.fiveg_n3_endpoint
}

resource "juju_offer" "upf-fiveg-n4" {
  model            = var.model_name
  application_name = module.upf.app_name
  endpoint         = module.upf.fiveg_n4_endpoint
}
