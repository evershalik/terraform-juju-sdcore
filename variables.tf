variable "model_name" {
  description = "Name of Juju model to deploy application to."
  type        = string
  default     = ""
}

variable "channel" {
  description = "The channel to use when deploying a charm."
  type        = string
  default     = "1.3/edge"
}

variable "mongo-channel" {
  description = "The channel to use when deploying a charm "
  type        = string
  default     = "6/beta"
}

variable "grafana-channel" {
  description = "The channel to use when deploying a charm "
  type        = string
  default     = "latest/stable"
}

variable "cert-channel" {
  description = "The channel to use when deploying a charm "
  type        = string
  default     = "beta"
}

variable "traefik-channel" {
  description = "The channel to use when deploying a charm."
  type        = string
  default     = "latest/stable"
}

variable "amf-config" {
  description = "Additional configuration for the AMF"
  default     = {}
}

variable "nssf-config" {
  description = "Additional configuration for the NSSF"
  default     = {}
}

variable "mongo-config" {
  description = "Additional configuration for the MongoDB"
  default     = {}
}

variable "grafana-config" {
  description = "Additional configuration for the Grafana"
  default     = {}
}

variable "metrics_remote_write_offer_url" {
  description = "Prometheus offer URL for `send-remote-write` endpoint"
  type        = string
  default     = ""
}

variable "logging_offer_url" {
  description = "Loki offer URL for `logging-consumer` endpoint"
  type        = string
  default     = ""
}

variable "cert-config" {
  description = "Additional configuration for the Self-Signed-Certificates"
  default     = {}
}

variable "traefik-config" {
  description = "Additional configuration for the Traefik"
  default = {
    routing_mode = "subdomain"
  }
}