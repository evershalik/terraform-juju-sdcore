# SD-Core Control Plane Terraform Module

This folder contains the [Terraform][Terraform] module for the [sdcore-control-plane-k8s][sdcore-control-plane-k8s].

The module uses the [Terraform Juju provider][Terraform Juju provider] to model the charm deployment onto any Kubernetes environment managed by [Juju][Juju].

The module can be used to deploy the `sdcore-control-plane-k8s` separately as well as a part of `sdcore-k8s` module, depending on the deployment architecture.

## Module structure

- **main.tf** - Defines the Juju application to be deployed.
- **variables.tf** - Allows customization of the deployment. Except for exposing the deployment options (Juju model name, channel) also allows overwriting charm's default configuration.
- **terraform.tf** - Defines the Terraform provider.

## Deploying sdcore-control-plane-k8s module separately

### Pre-requisites

The following tools needs to be installed and should be running in the environment. Please [set up your environment][set-up-environment] before deployment.

- A Kubernetes cluster with the `Multus` and `Metallb` addon enabled.
- Juju 3.x
- Juju controller bootstrapped onto the K8s cluster
- Terraform

### Deploying sdcore-control-plane-k8s with Terraform

Form inside the `sdcore-control-plane-k8s` module folder, initialize the provider:

```console
terraform init
```

While creating the plan, the default configuration can be overwritten with `-var-file`. To do that, create a `terraform.tfvars` including the contents similar to below:

```yaml
# Mandatory Config Options
model_name = "put your model-name here"

# Optional Configurations

# channel                        = "put the channel for the SD-Core charms here"
# mongo_channel                  = "put the MongoDB charm channel here"
# grafana_channel                = "put the Grafana charm channel here"
# self_signed_certificates_channel                   = "put the Self Signed Certificates charm channel here"
# traefik_channel                = "put the Self Signed Certificates charm channel here"

# amf_config                     = {} // Put the Additional Config for the AMF charm
# nssf_config                    = {} // Put the Additional Config for the NSSF charm
# mongo_config                   = {} // Put the Additional Config for the MongoDB charm
# grafana_config                 = {} // Put the Additional Config for the Grafana charm
# self_signed_certificates_config                    = {} // Put the Additional Config for the Self Signed Certificates charm
# traefik_config                 = {} // Put the Additional Config for the Traefik charm
```

Fill the mandatory config options in the `terraform.tfvars` file.  The provided Juju `model_name` is not expected to pre-exist and will be created by Juju Terraform Provider.

Create the Terraform Plan:

```console
terraform plan -var-file="terraform.tfvars" 
```

Deploy the resources:

```console
terraform apply -auto-approve 
```

### Check the Output

Run `juju switch <juju model>` to switch to the target Juju model and observe the status of the applications.

```console
juju status --relations
```

### Clean up

Destroy the deployment:

```console
terraform destroy -auto-approve
```

## Using sdcore-control-plane-k8s module in higher level modules

If you want to use `sdcore-control-plane-k8s` module as part of your Terraform module, import it like shown below:

```text
module "sdcore-control-plane" {
  source = "git::https://github.com/canonical/https://github.com/canonical/terraform-juju-sdcore-k8s//modules/sdcore-control-plane-k8s"
  
  model_name = "juju_model_name"
  (Customize configuration variables here if needed)
}
```

[Terraform]: https://www.terraform.io/
[Terraform Juju provider]: https://registry.terraform.io/providers/juju/juju/latest
[Juju]: https://juju.is
[sdcore-control-plane-k8s]: https://charmhub.io/sdcore-control-plane-k8s
[set-up-environment]: [https://discourse.charmhub.io/t/set-up-your-development-environment-with-microk8s-for-juju-terraform-provider/13109#prepare-development-environment-2]
