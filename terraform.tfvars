# Mandatory Config Options
model_name = "put your model-name here"

# Optional Configurations
channel                        = "put the channel for the SD-Core charms here"
mongo-channel                  = "put the MongoDB charm channel here"
grafana-channel                = "put the Grafana charm channel here"
cert-channel                   = "put the Self Signed Certificates charm channel here"
traefik-channel                = "put the Self Signed Certificates charm channel here"
amf-config                     = {} // Put the Additional Config for the AMF charm
nssf-config                    = {} // Put the Additional Config for the NSSF charm
mongo-config                   = {} // Put the Additional Config for the MongoDB charm
grafana-config                 = {} // Put the Additional Config for the Grafana charm
metrics_remote_write_offer_url = "Put the Prometheus offer URL for `send-remote-write` endpoint for the Grafana"
logging_offer_url              = "Put the Loki offer URL for `logging-consumer` endpoint for the Grafana"
cert-config                    = {} // Put the Additional Config for the Self Signed Certificates charm
traefik-config                 = {} // Put the Additional Config for the Traefik charm
