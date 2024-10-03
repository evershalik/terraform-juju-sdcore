# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

# Integration offers for external systems

output "upf_fiveg_n3_offer_url" {
  description = "UPF `fiveg_n3` offer."
  value       = juju_offer.upf-fiveg-n3.url
}

output "upf_fiveg_n4_offer_url" {
  description = "UPF `fiveg_n4` offer."
  value       = juju_offer.upf-fiveg-n4.url
}
