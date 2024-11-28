# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

data "juju_model" "sdcore" {
  name = var.model
}

module "amf" {
  source    = "git::https://github.com/canonical/sdcore-amf-k8s-operator//terraform?ref=v1.5"
  model     = data.juju_model.sdcore.name
  channel   = var.sdcore_channel
  config    = var.amf_config
  revision  = var.amf_revision
  resources = var.amf_resources
}

module "ausf" {
  source    = "git::https://github.com/canonical/sdcore-ausf-k8s-operator//terraform?ref=v1.5"
  model     = data.juju_model.sdcore.name
  channel   = var.sdcore_channel
  revision  = var.ausf_revision
  resources = var.ausf_resources
}

module "nms" {
  source    = "git::https://github.com/canonical/sdcore-nms-k8s-operator//terraform?ref=v1.5"
  model     = data.juju_model.sdcore.name
  channel   = var.sdcore_channel
  revision  = var.nms_revision
  resources = var.nms_resources
}

module "nrf" {
  source    = "git::https://github.com/canonical/sdcore-nrf-k8s-operator//terraform?ref=v1.5"
  model     = data.juju_model.sdcore.name
  channel   = var.sdcore_channel
  revision  = var.nrf_revision
  resources = var.nrf_resources
}

module "nssf" {
  source    = "git::https://github.com/canonical/sdcore-nssf-k8s-operator//terraform?ref=v1.5"
  model     = data.juju_model.sdcore.name
  channel   = var.sdcore_channel
  revision  = var.nssf_revision
  resources = var.nssf_resources
}

module "pcf" {
  source    = "git::https://github.com/canonical/sdcore-pcf-k8s-operator//terraform?ref=v1.5"
  model     = data.juju_model.sdcore.name
  channel   = var.sdcore_channel
  revision  = var.pcf_revision
  resources = var.pcf_resources
}

module "smf" {
  source    = "git::https://github.com/canonical/sdcore-smf-k8s-operator//terraform?ref=v1.5"
  model     = data.juju_model.sdcore.name
  channel   = var.sdcore_channel
  revision  = var.smf_revision
  resources = var.smf_resources
}

module "udm" {
  source    = "git::https://github.com/canonical/sdcore-udm-k8s-operator//terraform?ref=v1.5"
  model     = data.juju_model.sdcore.name
  channel   = var.sdcore_channel
  revision  = var.udm_revision
  resources = var.udm_resources
}

module "udr" {
  source    = "git::https://github.com/canonical/sdcore-udr-k8s-operator//terraform?ref=v1.5"
  model     = data.juju_model.sdcore.name
  channel   = var.sdcore_channel
  revision  = var.udr_revision
  resources = var.udr_resources
}

module "mongodb" {
  source     = "../external/mongodb-k8s"
  model_name = data.juju_model.sdcore.name
  channel    = var.mongo_channel
  config     = var.mongo_config
}

module "grafana-agent" {
  source     = "../external/grafana-agent-k8s"
  model_name = data.juju_model.sdcore.name
  channel    = var.grafana_agent_channel
  config     = var.grafana_agent_config
}

module "self-signed-certificates" {
  source     = "git::https://github.com/canonical/self-signed-certificates-operator//terraform"
  model_name = data.juju_model.sdcore.name
  channel    = var.self_signed_certificates_channel
  config     = var.self_signed_certificates_config
}

module "traefik" {
  source     = "../external/traefik-k8s"
  model_name = data.juju_model.sdcore.name
  channel    = var.traefik_channel
  config     = var.traefik_config
}

# Integrations for `fiveg-nrf` endpoint

resource "juju_integration" "amf-fiveg-nrf" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.amf.app_name
    endpoint = module.amf.requires.fiveg_nrf
  }

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.provides.fiveg_nrf
  }
}

resource "juju_integration" "udm-fiveg-nrf" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udm.app_name
    endpoint = module.udm.requires.fiveg_nrf
  }

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.provides.fiveg_nrf
  }
}

resource "juju_integration" "smf-fiveg-nrf" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.smf.app_name
    endpoint = module.smf.requires.fiveg_nrf
  }

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.provides.fiveg_nrf
  }
}

resource "juju_integration" "pcf-fiveg-nrf" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.pcf.app_name
    endpoint = module.pcf.requires.fiveg_nrf
  }

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.provides.fiveg_nrf
  }
}

resource "juju_integration" "nssf-fiveg-nrf" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nssf.app_name
    endpoint = module.nssf.requires.fiveg_nrf
  }

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.provides.fiveg_nrf
  }
}

resource "juju_integration" "udr-fiveg-nrf" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udr.app_name
    endpoint = module.udr.requires.fiveg_nrf
  }

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.provides.fiveg_nrf
  }
}

resource "juju_integration" "ausf-fiveg-nrf" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.ausf.app_name
    endpoint = module.ausf.requires.fiveg_nrf
  }

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.provides.fiveg_nrf
  }
}

# Integrations for `database` endpoint

resource "juju_integration" "udr-auth-database" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udr.app_name
    endpoint = module.udr.requires.auth_database
  }

  application {
    name     = module.mongodb.app_name
    endpoint = module.mongodb.database_endpoint
  }
}

resource "juju_integration" "udr-common-database" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udr.app_name
    endpoint = module.udr.requires.common_database
  }

  application {
    name     = module.mongodb.app_name
    endpoint = module.mongodb.database_endpoint
  }
}

resource "juju_integration" "nrf-database" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.requires.database
  }

  application {
    name     = module.mongodb.app_name
    endpoint = module.mongodb.database_endpoint
  }
}

resource "juju_integration" "nms-auth-database" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nms.app_name
    endpoint = module.nms.requires.auth_database
  }

  application {
    name     = module.mongodb.app_name
    endpoint = module.mongodb.database_endpoint
  }
}

resource "juju_integration" "nms-common-database" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nms.app_name
    endpoint = module.nms.requires.common_database
  }

  application {
    name     = module.mongodb.app_name
    endpoint = module.mongodb.database_endpoint
  }
}

resource "juju_integration" "nms-webui-database" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nms.app_name
    endpoint = module.nms.requires.webui_database
  }

  application {
    name     = module.mongodb.app_name
    endpoint = module.mongodb.database_endpoint
  }
}

# Integrations for `sdcore_config` endpoint

resource "juju_integration" "amf-sdcore-config" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.amf.app_name
    endpoint = module.amf.requires.sdcore_config
  }

  application {
    name     = module.nms.app_name
    endpoint = module.nms.provides.sdcore_config
  }
}

resource "juju_integration" "ausf-sdcore-config" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.ausf.app_name
    endpoint = module.ausf.requires.sdcore_config
  }

  application {
    name     = module.nms.app_name
    endpoint = module.nms.provides.sdcore_config
  }
}

resource "juju_integration" "nrf-sdcore-config" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.requires.sdcore_config
  }

  application {
    name     = module.nms.app_name
    endpoint = module.nms.provides.sdcore_config
  }
}

resource "juju_integration" "nssf-sdcore-config" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nssf.app_name
    endpoint = module.nssf.requires.sdcore_config
  }

  application {
    name     = module.nms.app_name
    endpoint = module.nms.provides.sdcore_config
  }
}

resource "juju_integration" "pcf-sdcore-config" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.pcf.app_name
    endpoint = module.pcf.requires.sdcore_config
  }

  application {
    name     = module.nms.app_name
    endpoint = module.nms.provides.sdcore_config
  }
}

resource "juju_integration" "smf-sdcore-config" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.smf.app_name
    endpoint = module.smf.requires.sdcore_config
  }

  application {
    name     = module.nms.app_name
    endpoint = module.nms.provides.sdcore_config
  }
}

resource "juju_integration" "udm-sdcore-config" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udm.app_name
    endpoint = module.udm.requires.sdcore_config
  }

  application {
    name     = module.nms.app_name
    endpoint = module.nms.provides.sdcore_config
  }
}

resource "juju_integration" "udr-sdcore-config" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udr.app_name
    endpoint = module.udr.requires.sdcore_config
  }

  application {
    name     = module.nms.app_name
    endpoint = module.nms.provides.sdcore_config
  }
}

# Integrations for `metrics` endpoint

resource "juju_integration" "amf-metrics" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.amf.app_name
    endpoint = module.amf.provides.metrics
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}

resource "juju_integration" "ausf-metrics" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.ausf.app_name
    endpoint = module.ausf.provides.metrics
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}

resource "juju_integration" "mongodb-metrics" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.mongodb.app_name
    endpoint = module.mongodb.metrics_endpoint
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}

resource "juju_integration" "nrf-metrics" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.provides.metrics
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}

resource "juju_integration" "nssf-metrics" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nssf.app_name
    endpoint = module.nssf.provides.metrics
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}

resource "juju_integration" "pcf-metrics" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.pcf.app_name
    endpoint = module.pcf.provides.metrics
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}

resource "juju_integration" "smf-metrics" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.smf.app_name
    endpoint = module.smf.provides.metrics
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}

resource "juju_integration" "udm-metrics" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udm.app_name
    endpoint = module.udm.provides.metrics
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}

resource "juju_integration" "udr-metrics" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udr.app_name
    endpoint = module.udr.provides.metrics
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.metrics_endpoint
  }
}

# Integrations for `certificates` endpoint

resource "juju_integration" "amf-certificates" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.amf.app_name
    endpoint = module.amf.requires.certificates
  }

  application {
    name     = module.self-signed-certificates.app_name
    endpoint = module.self-signed-certificates.certificates_endpoint
  }
}

resource "juju_integration" "udm-certificates" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udm.app_name
    endpoint = module.udm.requires.certificates
  }

  application {
    name     = module.self-signed-certificates.app_name
    endpoint = module.self-signed-certificates.certificates_endpoint
  }
}

resource "juju_integration" "smf-certificates" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.smf.app_name
    endpoint = module.smf.requires.certificates
  }

  application {
    name     = module.self-signed-certificates.app_name
    endpoint = module.self-signed-certificates.certificates_endpoint
  }
}

resource "juju_integration" "pcf-certificates" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.pcf.app_name
    endpoint = module.pcf.requires.certificates
  }

  application {
    name     = module.self-signed-certificates.app_name
    endpoint = module.self-signed-certificates.certificates_endpoint
  }
}

resource "juju_integration" "nssf-certificates" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nssf.app_name
    endpoint = module.nssf.requires.certificates
  }

  application {
    name     = module.self-signed-certificates.app_name
    endpoint = module.self-signed-certificates.certificates_endpoint
  }
}

resource "juju_integration" "nrf-certificates" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.requires.certificates
  }

  application {
    name     = module.self-signed-certificates.app_name
    endpoint = module.self-signed-certificates.certificates_endpoint
  }
}

resource "juju_integration" "ausf-certificates" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.ausf.app_name
    endpoint = module.ausf.requires.certificates
  }

  application {
    name     = module.self-signed-certificates.app_name
    endpoint = module.self-signed-certificates.certificates_endpoint
  }
}

resource "juju_integration" "udr-certificates" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udr.app_name
    endpoint = module.udr.requires.certificates
  }

  application {
    name     = module.self-signed-certificates.app_name
    endpoint = module.self-signed-certificates.certificates_endpoint
  }
}

resource "juju_integration" "nms-certificates" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nms.app_name
    endpoint = module.nms.requires.certificates
  }

  application {
    name     = module.self-signed-certificates.app_name
    endpoint = module.self-signed-certificates.certificates_endpoint
  }
}

resource "juju_integration" "traefik-certificates" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.traefik.app_name
    endpoint = module.traefik.certificates_endpoint
  }

  application {
    name     = module.self-signed-certificates.app_name
    endpoint = module.self-signed-certificates.certificates_endpoint
  }
}

# Integrations for `ingress` endpoint

resource "juju_integration" "nms-ingress" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nms.app_name
    endpoint = module.nms.requires.ingress
  }

  application {
    name     = module.traefik.app_name
    endpoint = module.traefik.ingress_endpoint
  }
}

# Integrations for `logging` endpoint

resource "juju_integration" "mongodb-logging" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.mongodb.app_name
    endpoint = module.mongodb.logging_endpoint
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

resource "juju_integration" "amf-logging" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.amf.app_name
    endpoint = module.amf.requires.logging
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

resource "juju_integration" "ausf-logging" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.ausf.app_name
    endpoint = module.ausf.requires.logging
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

resource "juju_integration" "nrf-logging" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nrf.app_name
    endpoint = module.nrf.requires.logging
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

resource "juju_integration" "nssf-logging" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nssf.app_name
    endpoint = module.nssf.requires.logging
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

resource "juju_integration" "pcf-logging" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.pcf.app_name
    endpoint = module.pcf.requires.logging
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

resource "juju_integration" "smf-logging" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.smf.app_name
    endpoint = module.smf.requires.logging
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

resource "juju_integration" "udm-logging" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udm.app_name
    endpoint = module.udm.requires.logging
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

resource "juju_integration" "udr-logging" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.udr.app_name
    endpoint = module.udr.requires.logging
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

resource "juju_integration" "nms-logging" {
  model = data.juju_model.sdcore.name

  application {
    name     = module.nms.app_name
    endpoint = module.nms.requires.logging
  }

  application {
    name     = module.grafana-agent.app_name
    endpoint = module.grafana-agent.logging_provider_endpoint
  }
}

# Cross-model integrations

resource "juju_offer" "amf-fiveg-n2" {
  model            = data.juju_model.sdcore.name
  application_name = module.amf.app_name
  endpoint         = module.amf.provides.fiveg_n2
}
