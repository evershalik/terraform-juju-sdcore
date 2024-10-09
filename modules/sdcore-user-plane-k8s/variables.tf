# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

variable "model" {
  description = "Reference to a juju_model to deploy application to."
  type        = string
  default     = ""
}

variable "upf_channel" {
  description = "The channel to use when deploying `sdcore-upf-k8s` charm."
  type        = string
  default     = "1.5/edge"
}

variable "grafana_agent_channel" {
  description = "The channel to use when deploying `grafana-agent-k8s` charm."
  type        = string
  default     = "latest/stable"
}

variable "upf_config" {
  description = "Application config for the UPF. Details about available options can be found at https://charmhub.io/sdcore-upf-k8s-operator/configure."
  type        = map(string)
  default     = {}
}

variable "grafana_agent_config" {
  description = "Additional configuration for the Grafana Agent. Details about available options can be found at https://charmhub.io/grafana-agent-k8s/configure."
  type        = map(string)
  default     = {}
}
