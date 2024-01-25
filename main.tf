resource "juju_model" "sdcore" {
  name = var.model_name
}

module "sdcore-amf-k8s" {
  source  = "gatici/sdcore-amf-k8s/juju"
  model_name = juju_model.sdcore.name
  certs_application_name = module.self-signed-certificates.certs_application_name
  db_application_name = module.mongodb-k8s.db_application_name
  channel = var.channel
  nrf_application_name = module.sdcore-nrf-k8s.nrf_application_name
}

module "sdcore-ausf-k8s" {
  source  = "gatici/sdcore-ausf-k8s/juju"
  model_name = juju_model.sdcore.name
  certs_application_name = module.self-signed-certificates.certs_application_name
  db_application_name = module.mongodb-k8s.db_application_name
  channel = var.channel
  nrf_application_name = module.sdcore-nrf-k8s.nrf_application_name
}

module "sdcore-nms-k8s" {
  source  = "gatici/sdcore-nms-k8s/juju"
  model_name = juju_model.sdcore.name
  webui_application_name = module.sdcore-webui-k8s.webui_application_name
  channel = var.channel
  traefik_application_name = module.traefik-k8s.traefik_application_name
}

module "sdcore-nrf-k8s" {
  source  = "gatici/sdcore-nrf-k8s/juju"
  model_name = juju_model.sdcore.name
  certs_application_name = module.self-signed-certificates.certs_application_name
  db_application_name = module.mongodb-k8s.db_application_name
  channel = var.channel
}

module "sdcore-nssf-k8s" {
  source  = "gatici/sdcore-nssf-k8s/juju"
  model_name = juju_model.sdcore.name
  certs_application_name = module.self-signed-certificates.certs_application_name
  db_application_name = module.mongodb-k8s.db_application_name
  channel = var.channel
  nrf_application_name = module.sdcore-nrf-k8s.nrf_application_name
}

module "sdcore-pcf-k8s" {
  source  = "gatici/sdcore-pcf-k8s/juju"
  model_name = juju_model.sdcore.name
  certs_application_name = module.self-signed-certificates.certs_application_name
  db_application_name = module.mongodb-k8s.db_application_name
  channel = var.channel
  nrf_application_name = module.sdcore-nrf-k8s.nrf_application_name
}

module "sdcore-smf-k8s" {
  source  = "gatici/sdcore-smf-k8s/juju"
  model_name = juju_model.sdcore.name
  certs_application_name = module.self-signed-certificates.certs_application_name
  db_application_name = module.mongodb-k8s.db_application_name
  channel = var.channel
  nrf_application_name = module.sdcore-nrf-k8s.nrf_application_name
}

module "sdcore-udm-k8s" {
  source  = "gatici/sdcore-udm-k8s/juju"
  model_name = juju_model.sdcore.name
  certs_application_name = module.self-signed-certificates.certs_application_name
  db_application_name = module.mongodb-k8s.db_application_name
  channel = var.channel
  nrf_application_name = module.sdcore-nrf-k8s.nrf_application_name
}

module "sdcore-udr-k8s" {
  source  = "gatici/sdcore-udr-k8s/juju"
  model_name = juju_model.sdcore.name
  certs_application_name = module.self-signed-certificates.certs_application_name
  db_application_name = module.mongodb-k8s.db_application_name
  channel = var.channel
  nrf_application_name = module.sdcore-nrf-k8s.nrf_application_name
}

module "sdcore-webui-k8s" {
  source  = "gatici/sdcore-webui-k8s/juju"
  model_name = juju_model.sdcore.name
  db_application_name = module.mongodb-k8s.db_application_name
  channel = var.channel
}

module "mongodb-k8s" {
  source     = "gatici/mongodb-k8s/juju"
  model_name = juju_model.sdcore.name
}

module "grafana-agent-k8s" {
  source  = "gatici/grafana-agent-k8s/juju"
  model_name = juju_model.sdcore.name
}

module "self-signed-certificates" {
  source     = "gatici/self-signed-certificates/juju"
  model_name = juju_model.sdcore.name
}

module "traefik-k8s" {
  source  = "gatici/traefik-k8s/juju"
  model_name = juju_model.sdcore.name
}

resource "juju_integration" "amf-metrics" {
  model = juju_model.sdcore.name

  application {
    name     = module.sdcore-amf-k8s.amf_application_name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = module.grafana-agent-k8s.grafana_application_name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "smf-metrics" {
  model = juju_model.sdcore.name

  application {
    name     = module.sdcore-smf-k8s.smf_application_name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = module.grafana-agent-k8s.grafana_application_name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "mongo-metrics" {
  model = juju_model.sdcore.name

  application {
    name     = module.mongodb-k8s.db_application_name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = module.grafana-agent-k8s.grafana_application_name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "mongo-logging" {
  model = juju_model.sdcore.name

  application {
    name     = module.mongodb-k8s.db_application_name
    endpoint = "logging"
  }

  application {
    name     = module.grafana-agent-k8s.grafana_application_name
    endpoint = "logging-provider"
  }
}


