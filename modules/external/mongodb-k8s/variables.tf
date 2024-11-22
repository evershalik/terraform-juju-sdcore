# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

variable "model_name" {
  description = "Name of Juju model to deploy application to."
  type        = string
  default     = ""
}

variable "app_name" {
  description = "Name of the application in the Juju model."
  type        = string
  default     = "mongodb"
}

variable "channel" {
  description = "The channel to use when deploying a charm."
  type        = string
  default     = "6/stable"
}

variable "config" {
  description = "Additional configuration for the MongoDB. Details about available options can be found at https://charmhub.io/mongodb-k8s/configurations?channel=6/stable."
  type        = map(string)
  default     = {}
}