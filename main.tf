resource "juju_model" "sdcore" {
  name = var.model_name
}

module "sdcore-amf-k8s" {
  source  = "gatici/sdcore-amf-k8s/juju"
  model_name = var.model_name
  certs_application_name = var.certs_application_name
  db_application_name = var.db_application_name
  channel = var.channel
  nrf_application_name = var.nrf_application_name
}

module "sdcore-ausf-k8s" {
  source  = "gatici/sdcore-ausf-k8s/juju"
  model_name = var.model_name
  certs_application_name = var.certs_application_name
  db_application_name = var.db_application_name
  channel = var.channel
  nrf_application_name = var.nrf_application_name
}

module "sdcore-nms-k8s" {
  source  = "gatici/sdcore-nms-k8s/juju"
  model_name = var.model_name
  webui_application_name = var.webui_application_name
  channel = var.channel
  traefik_application_name = var.traefik_application_name
  version = "v1.0.2"
}

module "sdcore-nrf-k8s" {
  source  = "gatici/sdcore-nrf-k8s/juju"
  model_name = var.model_name
  certs_application_name = var.certs_application_name
  db_application_name = var.db_application_name
  channel = var.channel
}

module "sdcore-nssf-k8s" {
  source  = "gatici/sdcore-nssf-k8s/juju"
  model_name = var.model_name
  certs_application_name = var.certs_application_name
  db_application_name = var.db_application_name
  channel = var.channel
  nrf_application_name = var.nrf_application_name
}

module "sdcore-pcf-k8s" {
  source  = "gatici/sdcore-pcf-k8s/juju"
  model_name = var.model_name
  certs_application_name = var.certs_application_name
  db_application_name = var.db_application_name
  channel = var.channel
  nrf_application_name = var.nrf_application_name
}

module "sdcore-smf-k8s" {
  source  = "gatici/sdcore-smf-k8s/juju"
  model_name = var.model_name
  certs_application_name = var.certs_application_name
  db_application_name = var.db_application_name
  channel = var.channel
  nrf_application_name = var.nrf_application_name
}

module "sdcore-udm-k8s" {
  source  = "gatici/sdcore-udm-k8s/juju"
  model_name = var.model_name
  certs_application_name = var.certs_application_name
  db_application_name = var.db_application_name
  channel = var.channel
  nrf_application_name = var.nrf_application_name
}

module "sdcore-udr-k8s" {
  source  = "gatici/sdcore-udr-k8s/juju"
  model_name = var.model_name
  certs_application_name = var.certs_application_name
  db_application_name = var.db_application_name
  channel = var.channel
  nrf_application_name = var.nrf_application_name
}

module "sdcore-webui-k8s" {
  source  = "gatici/sdcore-webui-k8s/juju"
  version = "1.0.0"
  model_name = var.model_name
  db_application_name = var.db_application_name
  channel = var.channel
}

module "mongodb-k8s" {
  source     = "gatici/mongodb-k8s/juju"
  version    = "1.0.2"
  model_name = var.model_name
  channel = var.mongo_channel
}

module "grafana-agent-k8s" {
  source  = "gatici/grafana-agent-k8s/juju"
  version = "1.0.1"
  channel = var.grafana_channel
}

module "self-signed-certificates" {
  source     = "gatici/self-signed-certificates/juju"
  version    = "1.0.3"
  model_name = var.model_name
  channel = var.self_signed_certificates_channel
}

module "traefik-k8s" {
  source  = "gatici/traefik-k8s/juju"
  version = "1.0.0"
  model_name = var.model_name
  channel = var.traefik_channel
}

resource "juju_integration" "amf-nrf" {
  model = var.model_name

  application {
    name     = var.amf_application_name
    endpoint = "fiveg-nrf"
  }

  application {
    name     = var.nrf_application_name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "amf-mongodb" {
  model = var.model_name

  application {
    name     = var.amf_application_name
    endpoint = "database"
  }

  application {
    name     = var.db_application_name
    endpoint = "database"
  }
}

resource "juju_integration" "amf-metrics" {
  model = var.model_name

  application {
    name     = var.amf_application_name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = var.grafana_application_name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "amf-certs" {
  model = var.model_name

  application {
    name     = var.amf_application_name
    endpoint = "certificates"
  }

  application {
    name     = var.certs_application_name
    endpoint = "certificates"
  }
}

resource "juju_integration" "ausf-nrf" {
  model = var.model_name

  application {
    name     = var.ausf_application_name
    endpoint = "fiveg-nrf"
  }

  application {
    name     = var.nrf_application_name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "ausf-certs" {
  model = var.model_name

  application {
    name     = var.ausf_application_name
    endpoint = "certificates"
  }

  application {
    name     = var.certs_application_name
    endpoint = "certificates"
  }
}

resource "juju_integration" "nms-traefik" {
  model = var.model_name

  application {
    name     = var.nms_application_name
    endpoint = "ingress"
  }

  application {
    name     = var.traefik_application_name
    endpoint = "ingress"
  }
}

resource "juju_integration" "nms-webui" {
  model = var.model_name

  application {
    name     = var.nms_application_name
    endpoint = "dcore-management"
  }

  application {
    name     = var.webui_application_name
    endpoint = "dcore-management"
  }
}

resource "juju_integration" "nrf-mongodb" {
  model = var.model_name

  application {
    name     = var.nrf_application_name
    endpoint = "database"
  }

  application {
    name     = var.db_application_name
    endpoint = "database"
  }
}

resource "juju_integration" "nrf-certs" {
  model = var.model_name

  application {
    name     = var.nrf_application_name
    endpoint = "certificates"
  }

  application {
    name     = var.certs_application_name
    endpoint = "certificates"
  }
}

resource "juju_integration" "nssf-nrf" {
  model = var.model_name

  application {
    name     = var.nssf_application_name
    endpoint = "fiveg-nrf"
  }

  application {
    name     = var.nrf_application_name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "nssf-certs" {
  model = var.model_name

  application {
    name     = var.nssf_application_name
    endpoint = "certificates"
  }

  application {
    name     = var.certs_application_name
    endpoint = "certificates"
  }
}

resource "juju_integration" "pcf-nrf" {
  model = var.model_name

  application {
    name     = var.pcf_application_name
    endpoint = "fiveg-nrf"
  }

  application {
    name     = var.nrf_application_name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "pcf-mongodb" {
  model = var.model_name

  application {
    name     = var.pcf_application_name
    endpoint = "database"
  }

  application {
    name     = var.db_application_name
    endpoint = "database"
  }
}

resource "juju_integration" "pcf-certs" {
  model = var.model_name

  application {
    name     = var.pcf_application_name
    endpoint = "certificates"
  }

  application {
    name     = var.certs_application_name
    endpoint = "certificates"
  }
}

resource "juju_integration" "smf-nrf" {
  model = var.model_name

  application {
    name     = var.smf_application_name
    endpoint = "fiveg-nrf"
  }

  application {
    name     = var.nrf_application_name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "smf-metrics" {
  model = var.model_name

  application {
    name     = var.smf_application_name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = var.grafana_application_name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "smf-mongodb" {
  model = var.model_name

  application {
    name     = var.smf_application_name
    endpoint = "database"
  }

  application {
    name     = var.db_application_name
    endpoint = "database"
  }
}

resource "juju_integration" "smf-certs" {
  model = var.model_name

  application {
    name     = var.smf_application_name
    endpoint = "certificates"
  }

  application {
    name     = var.certs_application_name
    endpoint = "certificates"
  }
}

resource "juju_integration" "udm-nrf" {
  model = var.model_name

  application {
    name     = var.udm_application_name
    endpoint = "fiveg-nrf"
  }

  application {
    name     = var.nrf_application_name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "udm-certs" {
  model = var.model_name

  application {
    name     = var.udm_application_name
    endpoint = "certificates"
  }

  application {
    name     = var.certs_application_name
    endpoint = "certificates"
  }
}

resource "juju_integration" "udr-nrf" {
  model = var.model_name

  application {
    name     = var.udr_application_name
    endpoint = "fiveg-nrf"
  }

  application {
    name     = var.nrf_application_name
    endpoint = "fiveg-nrf"
  }
}

resource "juju_integration" "udr-mongodb" {
  model = var.model_name

  application {
    name     = var.udr_application_name
    endpoint = "database"
  }

  application {
    name     = var.db_application_name
    endpoint = "database"
  }
}

resource "juju_integration" "udr-certs" {
  model = var.model_name

  application {
    name     = var.udr_application_name
    endpoint = "certificates"
  }

  application {
    name     = var.certs_application_name
    endpoint = "certificates"
  }
}

resource "juju_integration" "webui-mongodb" {
  model = var.model_name

  application {
    name     = var.webui_application_name
    endpoint = "database"
  }

  application {
    name     = var.db_application_name
    endpoint = "database"
  }
}

resource "juju_integration" "mongo-metrics" {
  model = var.model_name

  application {
    name     = var.db_application_name
    endpoint = "metrics-endpoint"
  }

  application {
    name     = var.grafana_application_name
    endpoint = "metrics-endpoint"
  }
}

resource "juju_integration" "mongo-logging" {
  model = var.model_name

  application {
    name     = var.db_application_name
    endpoint = "logging"
  }

  application {
    name     = var.grafana_application_name
    endpoint = "logging-provider"
  }
}


