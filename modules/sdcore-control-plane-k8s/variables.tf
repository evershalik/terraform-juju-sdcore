# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

variable "model" {
  description = "Reference to the Juju model to deploy application to."
  type        = string
}

variable "sdcore_channel" {
  description = "The channel to use when deploying Charmed Aether SD-Core charms."
  type        = string
  default     = "1.5/stable"
}

variable "mongo_channel" {
  description = "The channel to use when deploying `mongodb-k8s` charm."
  type        = string
  default     = "6/stable"
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

variable "amf_resources" {
  description = "Resources to use with the application. Details about available options can be found at https://charmhub.io/sdcore-amf-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "amf_revision" {
  description = "Revision number of the AMF charm"
  type        = number
  default     = null
}

variable "ausf_resources" {
  description = "Resources to use with the application. Details about available options can be found at https://charmhub.io/sdcore-ausf-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "ausf_revision" {
  description = "Revision number of the AUSF charm"
  type        = number
  default     = null
}

variable "nms_resources" {
  description = "Resources to use with the application. Details about available options can be found at https://charmhub.io/sdcore-nms-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "nms_revision" {
  description = "Revision number of the NMS charm"
  type        = number
  default     = null
}

variable "nrf_resources" {
  description = "Resources to use with the application. Details about available options can be found at https://charmhub.io/sdcore-nrf-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "nrf_revision" {
  description = "Revision number of the NRF charm"
  type        = number
  default     = null
}

variable "nssf_config" {
  description = "Application config for the NSSF. Details about available options can be found at https://charmhub.io/sdcore-nssf-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "nssf_resources" {
  description = "Resources to use with the application. Details about available options can be found at https://charmhub.io/sdcore-nssf-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "nssf_revision" {
  description = "Revision number of the NSSF charm"
  type        = number
  default     = null
}

variable "pcf_resources" {
  description = "Resources to use with the application. Details about available options can be found at https://charmhub.io/sdcore-pcf-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "pcf_revision" {
  description = "Revision number of the PCF charm"
  type        = number
  default     = null
}

variable "smf_resources" {
  description = "Resources to use with the application. Details about available options can be found at https://charmhub.io/sdcore-smf-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "smf_revision" {
  description = "Revision number of the SMF charm"
  type        = number
  default     = null
}

variable "udm_resources" {
  description = "Resources to use with the application. Details about available options can be found at https://charmhub.io/sdcore-udm-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "udm_revision" {
  description = "Revision number of the UDM charm"
  type        = number
  default     = null
}

variable "udr_resources" {
  description = "Resources to use with the application. Details about available options can be found at https://charmhub.io/sdcore-udr-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "udr_revision" {
  description = "Revision number of the UDR charm"
  type        = number
  default     = null
}

variable "mongo_config" {
  description = "Additional configuration for the MongoDB. Details about available options can be found at https://charmhub.io/mongodb-k8s/configurations?channel=6/stable."
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
