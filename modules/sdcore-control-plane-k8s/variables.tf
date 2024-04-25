# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

variable "model_name" {
  description = "Name of Juju model to deploy application to."
  type        = string
  default     = ""
}

variable "create_model" {
  description = "Allows to skip Juju model creation and re-use a model created in a higher level module."
  type        = bool
  default     = true
}

variable "amf_channel" {
  description = "The channel to use when deploying `sdcore-amf-k8s` charm."
  type        = string
  default     = "1.4/edge"
}

variable "ausf_channel" {
  description = "The channel to use when deploying `sdcore-ausf-k8s` charm."
  type        = string
  default     = "1.4/edge"
}

variable "nms_channel" {
  description = "The channel to use when deploying `sdcore-nms-k8s` charm."
  type        = string
  default     = "1.4/edge"
}

variable "nrf_channel" {
  description = "The channel to use when deploying `sdcore-nrf-k8s` charm."
  type        = string
  default     = "1.4/edge"
}

variable "nssf_channel" {
  description = "The channel to use when deploying `sdcore-nssf-k8s` charm."
  type        = string
  default     = "1.4/edge"
}

variable "pcf_channel" {
  description = "The channel to use when deploying `sdcore-pcf-k8s` charm."
  type        = string
  default     = "1.4/edge"
}

variable "smf_channel" {
  description = "The channel to use when deploying `sdcore-smf-k8s` charm."
  type        = string
  default     = "1.4/edge"
}

variable "udm_channel" {
  description = "The channel to use when deploying `sdcore-udm-k8s` charm."
  type        = string
  default     = "1.4/edge"
}

variable "udr_channel" {
  description = "The channel to use when deploying `sdcore-udr-k8s` charm."
  type        = string
  default     = "1.4/edge"
}

variable "webui_channel" {
  description = "The channel to use when deploying `sdcore-webui-k8s` charm."
  type        = string
  default     = "1.4/edge"
}

variable "mongo_channel" {
  description = "The channel to use when deploying `mongodb-k8s` charm."
  type        = string
  default     = "6/beta"
}

variable "grafana_agent_channel" {
  description = "The channel to use when deploying `grafana-agent-k8s` charm."
  type        = string
  default     = "latest/stable"
}

variable "self_signed_certificates_channel" {
  description = "The channel to use when deploying `self-signed-certificates-operator` charm."
  type        = string
  default     = "latest/stable"
}

variable "traefik_channel" {
  description = "The channel to use when deploying `traefik-k8s` charm."
  type        = string
  default     = "latest/stable"
}

variable "amf_config" {
  description = "Application config for the AMF. Details about available options can be found at https://charmhub.io/sdcore-amf-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "nssf_config" {
  description = "Application config for the NSSF. Details about available options can be found at https://charmhub.io/sdcore-nssf-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "mongo_config" {
  description = "Additional configuration for the MongoDB. Details about available options can be found at https://charmhub.io/mongodb-k8s/configure?channel=6/beta."
  type        = map(string)
  default     = {}
}

variable "grafana_agent_config" {
  description = "Additional configuration for the Grafana Agent. Details about available options can be found at https://charmhub.io/grafana-agent-k8s/configure."
  type        = map(string)
  default     = {}
}

variable "self_signed_certificates_config" {
  description = "Additional configuration for the Self-Signed-Certificates. Details about available options can be found at https://charmhub.io/self-signed-certificates-operator/configure."
  type        = map(string)
  default     = {}
}

variable "traefik_config" {
  description = "Additional configuration for the Traefik. Details about available options can be found at https://charmhub.io/traefik-k8s-operator/configure."
  type        = map(string)
  default = {
    routing_mode = "subdomain"
  }
}

# Canonical Observability Stack (COS)

variable "deploy_cos" {
  description = "When set to `true`, COS will be deployed along with SD-Core. COS will use a separate model on the same Juju controller."
  type        = bool
  default     = false
}
variable "cos_model_name" {
  description = "Name of Juju model to deploy COS to."
  type        = string
  default     = "cos-lite"
}
variable "cos_configuration_config" {
  description = "COS Configuration application config. Details about available options can be found at https://charmhub.io/cos-configuration-k8s/configure."
  type        = map(string)
  default = {
    git_repo                = "https://github.com/canonical/sdcore-cos-configuration"
    git_branch              = "main"
    grafana_dashboards_path = "grafana_dashboards/sdcore/"
  }
}
