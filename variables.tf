variable "model_name" {
  description = "Name of Juju model to deploy application to."
  type        = string
  default     = "test"
}

variable "channel" {
  description = "The channel to use when deploying a charm."
  type        = string
  default     = "1.3/edge"
}

variable "mongo_channel" {
  description = "The channel to use when deploying a mongodb-k8s charm."
  type        = string
  default     = "6/beta"
}

variable "grafana_channel" {
  description = "The channel to use when deploying a grafana-agent-k8s charm."
  type        = string
  default     = "latest/stable"
}

variable "traefik_channel" {
  description = "The channel to use when deploying a traefik-k8s charm."
  type        = string
  default     = "latest/stable"
}

variable "self_signed_certificates_channel" {
  description = "The channel to use when deploying a self-signed-certificates charm."
  type        = string
  default     = "beta"
}

variable "traefik_application_name" {
  description = "The name of the application providing the `ingress` endpoint."
  type        = string
  default     = "traefik-k8s"
}

variable "db_application_name" {
  description = "The name of the application providing the `database` endpoint."
  type        = string
  default     = "mongodb-k8s"
}

variable "certs_application_name" {
  description = "Name of the application providing the `certificates` integration endpoint."
  type = string
  default = "self-signed-certificates"
}

variable "nrf_application_name" {
  description = "The name of the application providing the `fiveg_nrf` endpoint."
  type        = string
  default     = "nrf"
}

variable "amf_application_name" {
  description = "The name of the application providing the `fiveg_n2` endpoint."
  type        = string
  default     = "amf"
}

variable "ausf_application_name" {
  description = "The name of the AUSF application."
  type        = string
  default     = "ausf"
}

variable "pcf_application_name" {
  description = "The name of the PCF application."
  type        = string
  default     = "pcf"
}

variable "smf_application_name" {
  description = "The name of the SMF application."
  type        = string
  default     = "smf"
}

variable "udm_application_name" {
  description = "The name of the UDM application."
  type        = string
  default     = "udm"
}

variable "udr_application_name" {
  description = "The name of the UDR application."
  type        = string
  default     = "udr"
}

variable "nms_application_name" {
  description = "The name of the NMS application."
  type        = string
  default     = "nms"
}

variable "nssf_application_name" {
  description = "The name of the NSSF application."
  type        = string
  default     = "nssf"
}

variable "webui_application_name" {
  description = "The name of the Webui application."
  type        = string
  default     = "webui"
}

variable "grafana_application_name" {
  description = "The name of the Grafana application."
  type        = string
  default     = "grafana-agent-k8s"
}


