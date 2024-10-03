# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

resource "juju_model" "sdcore" {
  count = var.create_model == true ? 1 : 0
  name  = var.model_name
}

module "upf" {
  source         = "git::https://github.com/canonical/sdcore-upf-operator//terraform"
  model_name     = var.create_model == true ? juju_model.sdcore[0].name : var.model_name
  channel        = var.upf_channel
  base           = "ubuntu@24.04"
  config         = var.upf_config
  machine_number = var.machine_number
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
